# base_project

个人开源项目基础模板 — C++23 + xmake + clang 工具链。

## 前置条件

| 工具 | 最低版本 | 说明 |
|------|---------|------|
| clang | 17 | C++23 编译器 |
| xmake | 2.8 | 构建系统 |
| lld | — | 链接器 |
| libc++ | — | C++ 标准库 (随 clang 提供) |
| clang-format | — | 代码格式化 (随 clang 提供) |
| clang-tidy | — | 静态分析 (随 clang 提供) |
| perl | — | check.sh 空白修复 |

## 构建

```bash
xmake build      # 构建
xmake -r         # 重新构建
```

`compile_commands.json` 在构建后自动生成到 `build/`（供 clang-tidy / clangd 使用），无需手动运行。

## 首次克隆后设置

首次 `xmake build` 时会自动配置 git hooks（修空白 + 格式化 + clang-tidy），无需手动操作。

## 质量检查

```bash
utils/check.sh                     # 全量检查 (format + tidy + build + test)
utils/check.sh --skip-build        # 跳过构建
utils/check.sh --skip-test         # 跳过测试
```

pre-commit hook 自动调用 `utils/check.sh --hook`，仅检查暂存文件。

## 运行

```bash
xmake run app
```

## 项目结构

```
include/          头文件
src/              源文件
tests/            测试样例
docs/             文档
utils/
  check.sh        统一质量检查脚本（--hook 模式 = pre-commit；默认 = 全量检查）
.githooks/
  pre-commit      转发到 check.sh --hook
.github/
  workflows/
    ci.yml        CI 流水线（push/PR 触发 check.sh）
output/           输出文件 (gitignore)
```

## CI

push 到 `main` 或提交 PR 时，GitHub Actions 自动运行 `utils/check.sh` 全量检查。

## 技术栈

C++23 / xmake / clang++ / libc++ / lld

## 许可证

Apache License 2.0
