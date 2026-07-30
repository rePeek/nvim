# AGENTS.md — AI Agent Guidelines

## Git 提交规范

- 每次提交必须属于**同一个功能/修复**，不要混合不相关的改动
- 使用 Conventional Commits 格式：
  - `feat:` — 新功能（新增插件、键位、模块等）
  - `fix:` — 修复问题（构建错误、运行时警告、键位冲突等）
  - `refactor:` — 重构（不改变行为的结构调整）
  - `docs:` — 文档变更
  - `chore:` — 杂项（gitignore、格式化等）
- 示例：
  ```
  feat: add render-markdown.nvim for Markdown rendering
  fix: resolve <leader>gg keymap conflict between LazyGit and Telescope
  refactor: replace extraPlugins with native nixvim module
  ```

## 插件配置原则

- **优先使用 nixvim 原生模块**（`plugins.xxx.enable = true`），不要使用 `extraPlugins`
- 在添加新插件前，先确认 nixvim 是否已内置该插件模块
- `extraConfigLua` 仅在原生模块无法实现时使用（如第三方回调函数）
- 保持配置轻量：LSP server 不自动安装工具，依赖系统 PATH

## 日志查看

启动 nixvim 后在 Neovim 内执行：

```vim
:messages          " 查看启动日志和运行时的警告/错误
```

或使用 headless 模式捕获：

```bash
nix run . -- --headless -c 'lua local m = vim.fn.execute("messages"); io.open("/tmp/nvim.log","w"):write(m); vim.cmd("q")'
cat /tmp/nvim.log
```

查看生成的 init.lua 排查问题：

```bash
./result/bin/nixvim-print-init > /tmp/init.lua
# 然后检查 /tmp/init.lua 中可疑配置
```

## 构建与运行

```bash
nix run .              # 构建并启动 nixvim
nix build .            # 仅构建，不启动
nix flake check .      # 运行检查（验证配置无错误）
nixfmt **/*.nix        # 格式化所有 nix 文件（提交前必须执行）
```

## 开发流程

1. 修改 `config/` 下的 nix 文件
2. 新增模块时，在 `config/default.nix` 的 `imports` 中添加引用
3. 运行 `nix build .` 验证构建通过
4. 运行 `nixfmt **/*.nix` 格式化
5. `git add -A && git commit`（flake 要求文件被 git 跟踪）
