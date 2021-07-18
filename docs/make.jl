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

for (root, dirs, files) in (walkdir("docs/build_en") ∪ walkdir("docs/build_ja"))
    for file in files
        if file == "index.html"
            path_html = joinpath(root, file)
            script = read(path_html, String)
            script = replace(script, ">Version<" => ">Language / 言語<")
            write(path_html, script)
        end
    end
end

# 404 docs
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
    source="src_404",
    build="build_404",
    pages=[
        "404" => "index.md",
    ],
)
mv("docs/build_404/index.html", "docs/build_404/404.html")

deploydocs(;
    target="build_en",
    devurl="en",
    repo="github.com/hyrodium/hyrodium.github.io"
)

deploydocs(;
    target="build_ja",
    devurl="ja",
    repo="github.com/hyrodium/hyrodium.github.io"
)

"""
Disable generating siteinfo.js
The following script is a modified version of the Documenter.jl script. (See LICENSE)
"""
function Documenter.Writers.HTMLWriter.generate_siteinfo_file(dir::AbstractString, version::AbstractString)
end

"""
Redefine gitrm_copy function to produce <repo>/<docs> instead of <repo>/dev/<docs>
The following script is a modified version of the Documenter.jl script. (See LICENSE)
"""
function Documenter.gitrm_copy(src, dst)
    repo_dir = splitdir(dst)[1]

    # --ignore-unmatch so that we wouldn't get errors if dst does not exist
    run(`git rm -rf --ignore-unmatch $(repo_dir)`)
    # git rm also removed parent directories
    # if they are empty so need to mkpath after
    # mkpath(dst)
    mktempdir() do backup
        cp(joinpath(repo_dir,".git"), joinpath(backup,".git"))
        cp(src, repo_dir; force=true)
        cp(joinpath(backup,".git"), joinpath(repo_dir,".git"))
    end
    cd(repo_dir)
end

deploydocs(;
    target="build_404",
    repo="github.com/hyrodium/hyrodium.github.io"
)
