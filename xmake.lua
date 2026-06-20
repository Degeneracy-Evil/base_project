set_languages("c++23")
set_toolchains("clang")
set_rundir(".")

target("app")
    set_kind("binary")
    add_files("src/*.cpp")
    add_includedirs("include")
    add_cxxflags("-Wall", "-Wextra", "-Werror", "-stdlib=libc++", {force = true})
    add_ldflags("-stdlib=libc++", "-fuse-ld=lld", "-rtlib=compiler-rt", "-unwindlib=libunwind",
               {force = true})

    on_load(function (target)
        if os.isdir(".githooks") and os.isdir(".git") then
            local configured = try { function() os.runv("git", {"config", "core.hooksPath"}); return true end }
            if not configured then
                os.runv("git", {"config", "core.hooksPath", ".githooks"})
            end
        end
    end)

    after_build(function (target)
        local cc_file = path.join(os.projectdir(), "build", "compile_commands.json")
        if not os.isfile(cc_file) then
            local project_dir = os.projectdir()
            local entries = {}
            for _, sourcefile in ipairs(target:sourcefiles()) do
                local abs_source = path.absolute(sourcefile, project_dir)
                local cmd = "clang++ -std=c++23 -Wall -Wextra -Werror -stdlib=libc++ -Iinclude -c " .. abs_source
                table.insert(entries, string.format(
                    '{"directory":"%s","command":"%s","file":"%s"}',
                    project_dir, cmd, abs_source
                ))
            end
            local json = "[" .. table.concat(entries, ",") .. "]"
            io.writefile(cc_file, json)
        end
    end)
