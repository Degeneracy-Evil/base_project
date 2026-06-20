# 开发记录

### 2026-06-20 初始化项目基础设施

- **变更类型**: chore / build / docs
- **涉及文件**: xmake.lua, .clang-format, .clang-tidy, .clangd, .gitignore, .githooks/pre-commit, utils/check.sh, README.md, AGENTS.md, src/main.cpp, LICENSE
- **变更内容**: 从 lzu/compiler_principles 项目迁移基础设施模板，包括 xmake 构建配置（C++23/clang/libc++/lld）、clang-format 格式化规则、clang-tidy 静态分析配置、clangd IDE 集成、git hooks（pre-commit 转发到 check.sh）、统一质量检查脚本（hook/全量双模式）、README 和 AGENTS 文档。泛化了 target 名称为 "app"，移除了项目特定的宏定义（SPDLOG/TOML），测试部分留为 TODO 占位符。
- **原因**: 作为个人开源项目的基础模板，需要一套完整的、开箱即用的 C++ 工程基础设施
- **验证**: `xmake build` 通过，`xmake run app` 输出 "Hello, World!"，`utils/check.sh` 全量检查 4/4 通过，pre-commit hook 成功运行 clang-tidy 并通过
