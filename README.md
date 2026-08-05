# Nixvim Configuration

基于 [LazyVim](https://github.com/LazyVim/LazyVim) 理念的 Nixvim 配置，针对 **C/C++、Rust、Nix、Python、Lua、Markdown、Web** 开发优化。
采用 **LazyVim 键位习惯**。

## 快速开始

```bash
nix run .            # 构建并启动
nix develop          # 进入开发环境（nil + nixfmt）
```

## 项目结构

```
nixvim/
├── flake.nix                  # Flake 入口 + devShell
├── flake.lock
├── AGENTS.md                  # AI Agent 开发规范
├── README.md
└── config/
    ├── default.nix            # 模块入口，import 所有子模块
    ├── core/                  # 核心设置
    │   ├── default.nix
    │   ├── options.nix        # 编辑器基础设置、leader
    │   ├── keymaps.nix        # 全局键位映射
    │   └── autocmd.nix        # 自动命令
    ├── coding/                # 编码能力
    │   ├── default.nix
    │   ├── completion.nix     # nvim-cmp 补全
    │   ├── conform.nix        # 格式化 (conform.nvim)
    │   ├── dap.nix            # Debug Adapter Protocol
    │   ├── lsp.nix            # Language Server Protocol
    │   └── treesitter.nix     # 语法高亮 & 解析
    ├── editor/                # 编辑器增强
    │   ├── default.nix
    │   ├── snacks.nix         # snacks.nvim (picker/explorer/terminal/通知等)
    │   ├── flash.nix          # 跳转 (flash.nvim)
    │   ├── grug-far.nix       # 批量替换
    │   ├── todo-comments.nix  # TODO 注释高亮
    │   ├── trouble.nix        # 诊断面板
    │   ├── which-key.nix      # 键位提示
    │   └── extras.nix         # 其他小插件
    ├── git/                   # Git 集成
    │   ├── default.nix
    │   ├── gitsigns.nix       # 行内 blame & diff
    │   └── lazygit.nix        # 浮动 Git TUI
    ├── languages/             # 语言专属配置
    │   ├── default.nix
    │   ├── cpp.nix
    │   ├── lua.nix
    │   ├── markdown.nix
    │   ├── nix.nix
    │   ├── python.nix
    │   ├── rust.nix
    │   └── web.nix            # HTML/CSS/JS/TS/JSON/YAML
    └── ui/                    # 界面
        ├── default.nix
        ├── bufferline.nix     # 标签栏
        ├── colorscheme.nix    # 配色方案 (tokyonight-storm)
        ├── noice.nix          # cmdline & 消息 UI
        └── statusline.nix     # 状态栏 (lualine)
```

## 主题

默认使用 **tokyonight-storm** 配色方案。

所有 UI 插件（lualine、bufferline、noice 等）自动跟随 colorscheme，无需单独配置。

### 外部覆盖

```nix
# 切换到其他 colorscheme（mkDefault 使得普通赋值即可覆盖）
{
  colorschemes.tokyonight.enable = false;
  colorschemes.catppuccin.enable = true;
}
```

## 插件一览

| 类别 | 插件 | 说明 |
|------|------|------|
| **瑞士军刀** | [snacks.nvim](https://github.com/folke/snacks.nvim) | 文件选择器、文件浏览器、终端、通知、缩进线、平滑滚动、Dashboard、大文件处理等 |
| **主题** | tokyonight (storm) | nixvim 内置模块，`mkDefault` 可被外部覆盖 |
| **补全** | nvim-cmp + LuaSnip + friendly-snippets | LSP / buffer / path / snippet 四源补全 |
| **格式化** | [conform.nvim](https://github.com/stevearc/conform.nvim) | 统一格式化框架，per-language 配置 |
| **LSP** | clangd / rust-analyzer / lua_ls / nil / pyright / marksman | 七语言 LSP |
| **语法高亮** | nvim-treesitter | 20+ 语言语法解析 |
| **语法上下文** | treesitter-context | 粘性作用域提示（最多 3 行） |
| **语法文本对象** | treesitter-textobjects | `]f`/`[f` 跳转函数/类/参数 |
| **自动标签** | ts-autotag | 自动关闭 HTML/JSX 标签 |
| **注释增强** | ts-comments | 更好的注释语法（treesitter 感知） |
| **跳转** | [flash.nvim](https://github.com/folke/snacks.nvim) | 增强搜索、Treesitter 跳转、远程跳转 |
| **批量替换** | [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | 实时搜索替换（LazyVim 风格） |
| **诊断面板** | [trouble.nvim](https://github.com/folke/trouble.nvim) | 诊断、符号、LSP 引用、Quickfix 面板 |
| **TODO 注释** | [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO/FIXME/HACK 高亮 & 跳转 |
| **键位提示** | [which-key.nvim](https://github.com/folke/snacks.nvim) | 按 Space 弹出分组菜单 |
| **多光标** | multicursors.nvim | 多光标编辑 |
| **Markdown 渲染** | render-markdown.nvim | Normal/Command/Terminal 模式渲染 |
| **调试** | nvim-dap + dap-ui + codelldb | 断点、单步、变量面板 |
| **Git 装饰** | gitsigns.nvim | 行内 blame、diff 标记、hunk 操作 |
| **Git 终端** | lazygit (via snacks) | 浮动 Git TUI |
| **状态栏** | lualine | `theme = auto`，自动跟随 colorscheme |
| **标签栏** | bufferline | LSP 诊断显示、Pin/分组 |
| **命令行 UI** | noice | 更好的 cmdline、消息、搜索 UI |
| **图标** | mini.icons | 文件/目录/filetype 图标 |
| **文本对象** | mini.ai | 增强型文本对象（500 行范围） |
| **自动括号** | mini.pairs | 智能配对（insert/command 模式） |
| **LSP 签名** | lsp-signature | 函数签名提示 |

> 所有插件均使用 nixvim 原生 nix 模块，零 `extraPlugins`。

## 键位映射

Leader 键为 `Space`。键位风格来自 LazyVim。

### 文件搜索 (Snacks Picker)

| 键位 | 动作 | 说明 |
|------|------|------|
| `<leader><Space>` | Find Files | 查找文件 |
| `<leader>/` | Live Grep | 实时搜索 |
| `<leader>,` | Commands | 命令面板 |
| `<leader>ff` | Find Files | 查找文件 |
| `<leader>fg` | Live Grep | 实时搜索 |
| `<leader>fb` | Buffers | 切换 Buffer |
| `<leader>fh` | Help Tags | 帮助搜索 |
| `<leader>fr` | Recent Files | 最近文件 |
| `<leader>fs` | Grep Word | 搜索光标下的词 |
| `<leader>fd` | Diagnostics | 诊断信息 |
| `<leader>fk` | Keymaps | 键位列表 |
| `<leader>fl` | Lines | 当前文件行搜索 |

### Git 搜索

| 键位 | 动作 |
|------|------|
| `<leader>gf` | Git 文件 |
| `<leader>gL` | Git Log (cwd) |
| `<leader>gl` | Git Log |

### 文件浏览

| 键位 | 动作 | 说明 |
|------|------|------|
| `<leader>e` | Snacks Explorer | 文件浏览器 |

### Buffer

| 键位 | 动作 |
|------|------|
| `Shift+H` | 上一个 Buffer |
| `Shift+L` | 下一个 Buffer |
| `[b` / `]b` | 上一个/下一个 Buffer |
| `<leader>bb` | 切换到另一个 Buffer |
| `` <leader>` `` | 切换到另一个 Buffer |
| `<leader>bd` | 删除当前 Buffer |
| `<leader>bo` | 关闭其他所有 Buffer |
| `<leader>bn` | 新建 Buffer |
| `<leader>bp` | Toggle Pin |
| `<leader>bP` | 关闭非 Pin 的 Buffer |
| `<leader>br` | 关闭右侧 Buffer |
| `<leader>bl` | 关闭左侧 Buffer |
| `[B` / `]B` | 移动 Buffer 位置 |
| `<leader>bj` | Pick Buffer |

### 窗口

| 键位 | 动作 |
|------|------|
| `Ctrl+H/J/K/L` | 左/下/上/右 窗口切换 |
| `Ctrl+↑/↓/←/→` | 调整窗口大小 |
| `<leader>-` | 水平分割 |
| `<leader>\|` | 垂直分割 |
| `<leader>wd` | 关闭窗口 |

### 行移动

| 键位 | 模式 | 动作 |
|------|------|------|
| `Alt+J` / `Alt+K` | Normal / Insert / Visual | 上/下移动行 |
| `J` / `K` | Visual | 移动选区下/上 |

### Flash 跳转

| 键位 | 模式 | 动作 |
|------|------|------|
| `s` | Normal / Visual / Operator | Flash 跳转 |
| `S` | Normal / Visual / Operator | Flash Treesitter |
| `r` | Operator-pending | Remote Flash |
| `R` | Operator-pending / Visual | Treesitter Search |

### Git (Gitsigns)

| 键位 | 动作 |
|------|------|
| `<leader>gg` | Lazygit |
| `<leader>gB` | Git Browse (浏览器打开) |
| `]h` / `[h` | 下一个/上一个 Hunk |
| `]H` / `[H` | 最后一个/第一个 Hunk |
| `<leader>ghs` | Stage Hunk |
| `<leader>ghr` | Reset Hunk |
| `<leader>ghS` | Stage Buffer |
| `<leader>ghu` | Undo Stage Hunk |
| `<leader>ghR` | Reset Buffer |
| `<leader>ghp` | Preview Hunk Inline |
| `<leader>ghb` | Blame Line (full) |
| `<leader>ghB` | Blame Buffer |
| `<leader>ghd` | Diff This |
| `<leader>ghD` | Diff This ~ |
| `ih` | 文本对象：选中 Hunk |
| `<leader>uG` | Toggle Git Signs |

### Debug (DAP)

| 键位 | 动作 |
|------|------|
| `<leader>db` | Toggle 断点 |
| `<leader>dc` | Continue |
| `<leader>dn` | Step over |
| `<leader>ds` | Step into |
| `<leader>do` | Step out |
| `<leader>dr` | Restart |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |

### LSP

| 键位 | 动作 |
|------|------|
| `gd` | Go to Definition |
| `gr` | Go to References |
| `gD` | Go to Declaration |
| `gt` | Go to Type Definition |
| `gi` | Go to Implementation |
| `K` | Hover 文档 |
| `gK` | Signature Help |
| `Ctrl+K` (insert) | Signature Help |
| `<leader>ca` | Code Action |
| `<leader>cA` | Source Action |
| `<leader>rn` | Rename |
| `<leader>cr` | Rename |
| `<leader>cf` | 格式化 |
| `<leader>cF` | 格式化注入语言 |

### 诊断 & Trouble

| 键位 | 动作 |
|------|------|
| `<leader>cd` | 当前行诊断浮窗 |
| `[d` / `]d` | 上一条/下一条诊断 |
| `[e` / `]e` | 上一条/下一条 Error |
| `[w` / `]w` | 上一条/下一条 Warning |
| `<leader>xx` | Trouble Diagnostics |
| `<leader>xX` | Trouble Buffer Diagnostics |
| `<leader>cs` | Trouble Symbols |
| `<leader>cS` | Trouble LSP References |
| `<leader>xL` | Trouble Location List |
| `<leader>xQ` | Trouble Quickfix |
| `<leader>xt` | Todo (Trouble) |
| `<leader>xT` | Todo/Fix/Fixme (Trouble) |
| `<leader>xq` | Toggle Quickfix |
| `<leader>xl` | Toggle Location List |
| `[q` / `]q` | 上一个/下一个 Quickfix |
| `[t` / `]t` | 上一个/下一个 Todo Comment |
| `[f` / `]f` | 下一个/上一个函数 (treesitter) |
| `[c` / `]c` | 下一个/上一个类 (treesitter) |
| `[a` / `]a` | 下一个/上一个参数 (treesitter) |

### UI 切换 (`<leader>u*`)

| 键位 | 动作 |
|------|------|
| `<leader>uf` | Toggle Auto Format |
| `<leader>us` | Toggle Spelling |
| `<leader>uw` | Toggle Wrap |
| `<leader>ul` | Toggle Line Numbers |
| `<leader>uL` | Toggle Relative Numbers |
| `<leader>ud` | Toggle Diagnostics |
| `<leader>uc` | Toggle Conceal Level |
| `<leader>ub` | Toggle Dark Background |
| `<leader>ug` | Toggle Indent Guides |
| `<leader>ua` | Toggle Animations |
| `<leader>uz` | Toggle Zen Mode |
| `<leader>uZ` | Toggle Zoom |
| `<leader>uh` | Toggle Inlay Hints |
| `<leader>ui` | Inspect Pos |
| `<leader>ur` | Redraw / Clear hlsearch |
| `<leader>un` | Dismiss All Notifications |

### Noice 消息

| 键位 | 动作 |
|------|------|
| `<leader>snl` | Noice Last Message |
| `<leader>snh` | Noice History |
| `<leader>sna` | Noice All |
| `<leader>snd` | Dismiss All |

### 通用

| 键位 | 模式 | 动作 |
|------|------|------|
| `<C-s>` | 全部 | 保存 |
| `<C-/>` | Normal / Terminal | 浮动终端 |
| `<leader>ft` | Normal | 浮动终端 |
| `<leader>.` | Normal | Scratch Buffer |
| `<leader>n` | Normal | 通知历史 |
| `<leader>qq` | Normal | 全部退出 |
| `<Esc>` | Insert / Normal | 清除搜索高亮 |
| `<leader>?` | Normal | Buffer 键位提示 (which-key) |
| `<` / `>` | Visual | 缩进后重新选中 |
| `gco` / `gcO` | Normal | 下方/上方插入注释 |

### 多光标 (multicursors.nvim)

| 键位 | 动作 |
|------|------|
| `Ctrl+N` | 选中光标下的下一个匹配 |
| `n` / `N` | 跳到下一个/上一个匹配 |

### 其他增强

| 键位 | 模式 | 说明 |
|------|------|------|
| `j` / `k` | Normal / Visual | 尊重 wrap 的行移动（无 count 时用 `gj`/`gk`） |
| `n` / `N` | Normal / Visual / Operator | 搜索结果导航时自动展开 fold |
| `,` / `.` / `;` | Insert | Undo break-point（输入标点时自动断点） |

> Vim 肌肉记忆全部保留：`ci"` `di(` `%` `daw` `ciw` `yap` 等不受影响。

## Language Server 配置

| 语言 | Server | Formatter | DAP |
|------|--------|-----------|-----|
| **C/C++** | clangd (`--background-index --clang-tidy --header-insertion=never`) | clang-format | codelldb |
| **Rust** | rust-analyzer | rustfmt | codelldb |
| **Lua** | lua_ls (inlay hints, codeLens) | stylua | — |
| **Nix** | nil | nixfmt-rfc-style | — |
| **Python** | pyright | — | — |
| **Markdown** | marksman | prettierd | — |
| **Web (JS/TS/JSON/YAML/HTML)** | — | prettierd / shfmt | — |

> LSP server 均不自动安装，依赖系统 PATH。找不到时 Neovim 跳过该 server，不影响使用。

## Debug 配置

使用 **nvim-dap** + **codelldb** (基于 LLDB)：

- C/C++：编译后启动，`program = ${fileDirname}/${fileBasenameNoExtension}`
- Rust：同上

DAP UI 会在调试开始时自动打开，结束时自动关闭。

## Treesitter 语法支持

```
Core:    Bash, Diff, Lua, Luadoc, Luap, Query, Regex, Vim, Vimdoc
C/C++:   C, C++
Rust:    Rust
Nix:     Nix
Python:  Python
Web:     HTML, JavaScript, JSDoc, JSON, TypeScript, TSX, YAML, XML, TOML
Docs:    Markdown, Markdown Inline
```

## 开发环境

```bash
nix develop          # 进入 devShell
```

devShell 提供：
- **nil** — Nix LSP server
- **nixfmt** — Nix 代码格式化器

格式化提交前必须执行：

```bash
nixfmt **/*.nix
```

## 外部 Flake 覆盖

本配置可作为 flake input 被其他项目导入，所有 nixvim 选项均可覆盖。

### 切换 colorscheme

```nix
modules = [
  nixvim-config
  {
    colorschemes.tokyonight.enable = false;
  }
];
```

### 禁用/覆盖插件

```nix
modules = [
  nixvim-config
  {
    plugins.flash.enable = nixvim.lib.mkForce false;
  }
];
```

### 与 Stylix 集成

当 NixOS 配置使用 Stylix 管理主题时，关掉本配置自带的 tokyonight，让 Stylix 接管：

```nix
# NixOS configuration.nix
{
  imports = [
    stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  };

  programs.nixvim = {
    enable = true;

    # 关掉本配置自带的 tokyonight（mkDefault 使得普通赋值即可覆盖）
    colorschemes.tokyonight.enable = false;

    # 导入本配置的其他设置（键位、插件、LSP 等全部保留）
    imports = [ nixvim-config ];
  };
};
```

> `colorschemes.tokyonight.enable` 使用了 `lib.mkDefault true`，外部普通赋值即可覆盖。

> Stylix 会自动生成 Neovim 配色方案。
> lualine 默认 `theme = "auto"`，bufferline 无显式 theme，两者都会自动跟随 Stylix 的 colorscheme。

## 自定义

1. 新增配置文件 → 在 `config/` 下创建 `.nix`
2. 在 `config/default.nix` 的 `imports` 中添加引用
3. `git add .`（flake 要求文件被 git 跟踪）
4. `nix build .` 验证
5. `nixfmt **/*.nix` 格式化
6. `nix run .` 启动

## 参考

- [LazyVim](https://github.com/LazyVim/LazyVim) — 本配置的键位习惯与插件选型灵感来源
- [Nixvim Documentation](https://nix-community.github.io/nixvim/)
- [Nixvim GitHub](https://github.com/nix-community/nixvim)
