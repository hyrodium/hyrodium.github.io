using Documenter
using HyrodiumHome

makedocs(;
    modules=[HyrodiumHome],
    authors="hyrodium <hyrodium@gmail.com>",
    repo="https://github.com/hyrodium/hyrodium.github.io/blob/{commit}{path}#L{line}",
    sitename="Hyrodium Home",
    format=Documenter.HTML(;
        prettyurls=true,
        canonical="https://hyrodium.github.io",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "PDF資料" => "pdf.md",
        "出展・発表歴" => "history.md",
        "SNS・連絡先" => "sns.md",
        "GitHub pages" => "githubpages.md",
    ],
)

deploydocs(;
    repo="github.com/hyrodium/hyrodium.github.io"
)
