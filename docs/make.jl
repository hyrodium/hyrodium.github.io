using HyrodiumHome
using Documenter

makedocs(;
    modules=[HyrodiumHome],
    authors="hyrodium <hyrodium@gmail.com> and contributors",
    repo="https://github.com/hyrodium/HyrodiumHome.jl/blob/{commit}{path}#L{line}",
    sitename="HyrodiumHome.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://hyrodium.github.io/HyrodiumHome.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/hyrodium/HyrodiumHome.jl",
)
