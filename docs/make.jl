using Documenter, Bayes101

makedocs(;
    modules=[Bayes101],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/schrimpf/Bayes101.jl/blob/{commit}{path}#L{line}",
    sitename="Bayes101.jl",
    authors="Paul Schrimpf <paul.schrimpf@gmail.com>",
    assets=String[],
)
