#using Pkg
#Pkg.activate(".")
using Weave

runweave= "weave" ∈ ARGS
runnotebook= "notebook" ∈ ARGS
#runweave= true
#runnotebook= false

src= ARGS[1] 

if runweave
  println("weaving markdown for $src")
  using Weave
  weave(src,out_path="md", cache=:user, cache_path="weavecache",  doctype="github", mod=Main, args=Dict("md" => true))
end

if runnotebook
  println("weaving notebook for $src")
  using Weave
  notebook(src, out_path=joinpath(pwd(),"build"), nbconvert_options="--allow-errors")
end

if (isfile("build/temp.md"))
  rm("build/temp.md")
end
