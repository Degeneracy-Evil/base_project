# 开发记录

### 2026-06-20 初始化项目基础设施

- **变更类型**: chore / build / docs
- **涉及文件**: xmake.lua, .clang-format, .clang-tidy, .clangd, .gitignore, .githooks/pre-commit, utils/check.sh, README.md, AGENTS.md, src/main.cpp, LICENSE
- **变更内容**: 从 lzu/compiler_principles 项目迁移基础设施模板，包括 xmake 构建配置（C++23/clang/libc++/lld）、clang-format 格式化规则、clang-tidy 静态分析配置、clangd IDE 集成、git hooks（pre-commit 转发到 check.sh）、统一质量检查脚本（hook/全量双模式）、README 和 AGENTS 文档。泛化了 target 名称为 "app"，移除了项目特定的宏定义（SPDLOG/TOML），测试部分留为 TODO 占位符。
- **原因**: 作为个人开源项目的基础模板，需要一套完整的、开箱即用的 C++ 工程基础设施
- **验证**: `xmake build` 通过，`xmake run app` 输出 "Hello, World!"，`utils/check.sh` 全量检查 4/4 通过，pre-commit hook 成功运行 clang-tidy 并通过

### 2026-06-20 模板改进：空目录占位、CI、前置条件、clang-tidy 零容忍、gitattributes、compile_commands 自动生成

- **变更类型**: chore / build / docs / ci
- **涉及文件**: include/.gitkeep, tests/.gitkeep, .github/workflows/ci.yml, README.md, AGENTS.md, .clang-tidy, .gitattributes, xmake.lua
- **变更内容**:
  1. 添加 `include/.gitkeep` 和 `tests/.gitkeep`，确保空目录被 git 跟踪
  2. 创建 `.github/workflows/ci.yml`，push/PR 时自动安装工具链并运行 `utils/check.sh`
  3. README 添加前置条件表格（clang/xmake/lld/libc++/clang-format/clang-tidy/perl）
  4. `.clang-tidy` 设置 `WarningsAsErrors: '*'`，静态分析零容忍
  5. 创建 `.gitattributes`，统一行尾为 LF
  6. `xmake.lua` 添加 `after_build` 钩子，构建后自动生成 `compile_commands.json`（手动构造 JSON，避免 xmake 递归调用死锁）
- **原因**: 提升模板的开箱即用性和 CI 就绪度，统一零容忍质量策略
- **验证**: `xmake -r` 后 `compile_commands.json` 自动生成且 JSON 合法，`utils/check.sh` 4/4 通过，clang-tidy exit code 0
