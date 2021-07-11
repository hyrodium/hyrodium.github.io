module HyrodiumHome

using Documenter


# """
# Disable generating siteinfo.js
# The following script is a modified version of the Documenter.jl script. (See LICENSE)
# """
# function Documenter.Writers.HTMLWriter.generate_siteinfo_file(dir::AbstractString, version::AbstractString)
# end

# """
# Redefine gitrm_copy function to produce <repo>/<docs> instead of <repo>/dev/<docs>
# The following script is a modified version of the Documenter.jl script. (See LICENSE)
# """
# function Documenter.gitrm_copy(src, dst)
#     repo_dir = splitdir(dst)[1]

#     # --ignore-unmatch so that we wouldn't get errors if dst does not exist
#     run(`git rm -rf --ignore-unmatch $(repo_dir)`)
#     # git rm also removed parent directories
#     # if they are empty so need to mkpath after
#     # mkpath(dst)
#     mktempdir() do backup
#         cp(joinpath(repo_dir,".git"), joinpath(backup,".git"))
#         cp(src, repo_dir; force=true)
#         cp(joinpath(backup,".git"), joinpath(repo_dir,".git"))
#     end
#     cd(repo_dir)
# end


"""
Generate language list
The following script is a modified version of the Documenter.jl script. (See LICENSE)
"""
function Documenter.Writers.HTMLWriter.generate_version_file(versionfile::AbstractString, _entries, symlinks = [])
    entries = ["en", "ja"]
    open(versionfile, "w") do buf
        println(buf, "var DOC_VERSIONS = [")
        for folder in entries
            println(buf, "  \"", folder, "\",")
        end
        println(buf, "];")

        # entries is empty if no versions have been built at all
        isempty(entries) && return

        # The first element in entries corresponds to the latest version, but is usually not the full version
        # number. So this essentially follows the symlinks that will be generated to figure out the full
        # version number (stored in DOCUMENTER_CURRENT_VERSION in siteinfo.js).
        # Every symlink points to a directory, so this doesn't need to be recursive.
        newest = first(entries)
        for s in symlinks
            if s.first == newest
                newest = s.second
                break
            end
        end
        println(buf, "var DOCUMENTER_NEWEST = \"$(newest)\";")
        println(buf, "var DOCUMENTER_STABLE = \"$(first(entries))\";")
    end
end

end
