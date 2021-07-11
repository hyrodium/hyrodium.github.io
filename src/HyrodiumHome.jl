module HyrodiumHome

using Documenter


"""
Disable generating siteinfo.js
"""
function Documenter.Writers.HTMLWriter.generate_siteinfo_file(dir::AbstractString, version::AbstractString)
end

# """
# Redefine gitrm_copy function to produce <repo>/<docs> instead of <repo>/dev/<docs>
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

end
