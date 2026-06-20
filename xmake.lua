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
