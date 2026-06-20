# base_project

个人开源项目基础模板。

## 构建

```bash
xmake build          # 构建
xmake -r             # 重新构建
```

生成 `compile_commands.json`（供 clang-tidy 等工具使用）：

```bash
xmake project -k compile_commands build
```

## 运行

```bash
xmake run app
```

xmake.lua 中已设置 `set_rundir(".")`，xmake run 从项目根目录执行，可直接使用相对路径。

## 项目结构

```
include/          头文件
src/              源文件
tests/            测试样例
docs/             文档
utils/
  check.sh        一键检查（clang-format + clang-tidy + build + tests）
.githooks/
  pre-commit      转发到 check.sh --hook
output/           输出文件 (gitignore)
```

## 关键约定

- C++23 / xmake / clang++ / libc++ / lld / compiler-rt
- 编译选项 -Wall -Wextra -Werror，零 warning
- `<cctype>` 函数传参必须 `static_cast<unsigned char>()`，否则 signed char 有 UB
- `compile_commands.json` 生成命令统一为 `xmake project -k compile_commands build`
- pre-commit hook 通过 `.githooks/pre-commit` 转发到 `utils/check.sh --hook`；首次克隆后需执行 `git config core.hooksPath .githooks`

## 开发记录规则

**每次文档或代码变动，必须在 `docs/devlog.md` 中留存痕迹。**

记录格式：
```
### YYYY-MM-DD 简述

- **变更类型**: docs / src / fix / refactor / build / chore
- **涉及文件**: 文件列表
- **变更内容**: 具体做了什么
- **原因**: 为什么做这个变更
- **验证**: 如何验证正确性（测试命令/结果）
```
