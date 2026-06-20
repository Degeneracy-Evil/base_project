# base_project

个人开源项目基础模板 — C++23 + xmake + clang 工具链。

## 构建

```bash
xmake build      # 构建
xmake -r         # 重新构建
```

生成 `compile_commands.json`（供 clang-tidy / clangd 等工具使用）：

```bash
xmake project -k compile_commands build
```

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
output/           输出文件 (gitignore)
```

## 技术栈

C++23 / xmake / clang++ / libc++ / lld

## 许可证

Apache License 2.0
