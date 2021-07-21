module HyrodiumHome

using Documenter

"""
Generate language list
The following script is a modified version of the Documenter.jl script. (See LICENSE)
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

    # open(versionfile, "w") do buf
    #     println(buf, "var DOC_VERSIONS = [")
    #     println(buf, "  \"en\",")
    #     println(buf, "  \"ja\",")
    #     println(buf, "];")
    #     println(buf, "var DOCUMENTER_NEWEST = \"en\";")
    #     println(buf, "var DOCUMENTER_STABLE = \"en\";")
    # end
end

end
