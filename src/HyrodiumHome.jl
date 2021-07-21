module HyrodiumHome

using Documenter

"""
Generate language list
The following script is a modified version of the Documenter.jl script.
"""
function Documenter.Writers.HTMLWriter.generate_version_file(versionfile::AbstractString, entries, symlinks = [])
    script = """
    var DOC_VERSIONS = [
      "en",
      "ja",
    ];
    var DOCUMENTER_NEWEST = "en";
    var DOCUMENTER_STABLE = "en";
    """
    write(versionfile, script)
end

end
