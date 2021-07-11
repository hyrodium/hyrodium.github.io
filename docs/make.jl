using Documenter
using HyrodiumHome

# English docs
makedocs(;
    modules=[HyrodiumHome],
    authors="hyrodium <hyrodium@gmail.com>",
    repo="https://github.com/hyrodium/hyrodium.github.io/blob/{commit}{path}#L{line}",
    sitename="Hyrodium Home",
    doctest=false,
    format=Documenter.HTML(;
        prettyurls=true,
        canonical="https://hyrodium.github.io",
        assets=String[],
        lang="en",
    ),
    source="src_en",
    build="build_en",
    pages=[
        "Home" => "index.md",
        "PDF documents" => "pdf.md",
        "History" => "history.md",
        "SNS and etc." => "sns.md",
        "GitHub pages" => "githubpages.md",
    ],
)

deploydocs(;
    target="build_en",
    devurl="en",
    repo="github.com/hyrodium/hyrodium.github.io"
)

# Japanese docs
makedocs(;
    modules=[HyrodiumHome],
    authors="hyrodium <hyrodium@gmail.com>",
    repo="https://github.com/hyrodium/hyrodium.github.io/blob/{commit}{path}#L{line}",
    sitename="Hyrodium Home",
    doctest=false,
    format=Documenter.HTML(;
        prettyurls=true,
        canonical="https://hyrodium.github.io",
        assets=String[],
        lang="ja",
    ),
    source="src_ja",
    build="build_ja",
    pages=[
        "Home" => "index.md",
        "PDF資料" => "pdf.md",
        "出展・発表歴" => "history.md",
        "SNS・連絡先" => "sns.md",
        "GitHub pages" => "githubpages.md",
    ],
)

deploydocs(;
    target="build_ja",
    devurl="ja",
    repo="github.com/hyrodium/hyrodium.github.io"
)
