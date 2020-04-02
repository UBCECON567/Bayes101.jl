BIB = jmd/bayes.bib
PANDOC = pandoc --bibliography $(BIB) -f markdown -t markdown_mmd-citations --metadata link-citations=true 

WEAVE = julia --project=@. makeweave.jl 
vpath %.jmd jmd


jmdin := $(wildcard jmd/*.jmd)
jmdmd := $(patsubst jmd/%.jmd, md/%.md,$(jmdin))
jmdout := $(patsubst jmd/%.jmd, build/%.md,$(jmdin))

docin := $(wildcard src/*.md)
docout := $(patsubst src/%.md, build/%.md,$(docin))


mdout := $(jmdout) 
nbout := $(patsubst jmd/%.jmd, build/%.ipynb,$(jmdin))


jmd : $(jmdout) 
nb : $(nbout)
doc: $(docout)


$(jmdmd) : md/%.md : %.jmd #makeweave.jl 
	$(WEAVE) $< $@  weave

$(mdout) : build/%.md : md/%.md
	$(PANDOC) $< -o $@

$(nbout) : build/%.ipynb : %.jmd 
	$(WEAVE) $< $@  notebook

$(docout) : build/%.md :  src/%.md
	julia --project=@. -e "using Documenter, Bayes101, DocumenterMarkdown; makedocs( modules=[Bayes101],  format=Markdown(), clean=false,  pages=[  \"Home\" => \"index.md\" ], repo=\"https://github.com/ubcecon567/Bayes101.jl/blob/{commit}{path}#L{line}\",  sitename=\"Bayes101.jl\",  authors=\"Paul Schrimpf <paul.schrimpf@gmail.com>\")"

site: site/index.html

site/index.html: $(rmdout) $(jmdout) $(docout) mkdocs.yml build/figures
	mkdocs build

all: site/index.html #$(nbout)

deploy: site/index.html 
	mkdocs gh-deploy


estpref = canada china italy korea us
estnew := $(patsubst %, %_$(shell date +'%Y-%m.%d').jld2, $(estpref))

$(estnew): 
	julia --project=@. estimate.jl $@

estimate: $(estnew)
