module HyrodiumHome

using Documenter


# """
# Disable generating siteinfo.js
# """
# function Documenter.Writers.HTMLWriter.generate_siteinfo_file(dir::AbstractString, version::AbstractString)
# end

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


"""
Generate language list
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


"""
Change sidebar wording from "Version" to "Language"
"""
function Documenter.Writers.HTMLWriter.render_sidebar(ctx, navnode)
    @tags a form img input nav div select option span
    src = get_url(ctx, navnode)
    navmenu = nav[".docs-sidebar"]

    # The logo and sitename will point to the first page in the navigation menu
    href = navhref(ctx, first(ctx.doc.internal.navlist), navnode)

    # Logo
    logo = find_image_asset(ctx, "logo")
    logo_dark = find_image_asset(ctx, "logo-dark")
    if logo !== nothing
        alt = isempty(ctx.doc.user.sitename) ? "Logo" : "$(ctx.doc.user.sitename) logo"
        logo_element = a[".docs-logo", :href => href]
        if logo_dark === nothing
            push!(logo_element.nodes, img[:src => relhref(src, logo), :alt => alt])
        else
            push!(logo_element.nodes, img[".docs-light-only", :src => relhref(src, logo), :alt => alt])
            push!(logo_element.nodes, img[".docs-dark-only", :src => relhref(src, logo_dark), :alt => alt])
        end
        push!(navmenu.nodes, logo_element)
    end
    # Sitename
    if ctx.settings.sidebar_sitename
        push!(navmenu.nodes, div[".docs-package-name"](
            span[".docs-autofit"](a[:href => href](ctx.doc.user.sitename))
        ))
    end

    # Search box
    push!(navmenu.nodes,
        form[".docs-search", :action => navhref(ctx, ctx.search_navnode, navnode)](
            input[
                "#documenter-search-query.docs-search-query",
                :name => "q",
                :type => "text",
                :placeholder => "Search docs",
            ],
        )
    )

    # The menu itself
    menu = navitem(NavMenuContext(ctx, navnode))
    push!(menu.attributes, :class => "docs-menu")
    push!(navmenu.nodes, menu)

    # Version selector
    let
        vs_class = ".docs-version-selector.field.has-addons"
        vs_label = span[".docs-label.button.is-static.is-size-7"]("Language")
        vs_label = div[".control"](vs_label)
        vs_select = select["#documenter-version-selector"]
        if !isempty(ctx.doc.user.version)
            vs_class = "$(vs_class).visible"
            opt = option[:value => "#", :selected => "selected", ](ctx.doc.user.version)
            vs_select = vs_select(opt)
        end
        vs_select = div[".select.is-fullwidth.is-size-7"](vs_select)
        vs_select = div[".docs-selector.control.is-expanded"](vs_select)
        push!(navmenu.nodes, div[vs_class](vs_label, vs_select))
    end
    navmenu
end

end
