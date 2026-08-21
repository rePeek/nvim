# Nixvim Configuration

基于 [LazyVim](https://github.com/LazyVim/LazyVim) 理念的 Nixvim 配置，针对 **C/C++、Rust、Nix、Python、Lua、Markdown、Web、Shell** 开发优化。
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
    │   ├── snacks.nix         # snacks.nvim (picker/explorer/terminal/通知/goto 等)
    │   ├── grug-far.nix       # 批量替换
    │   ├── multicursors.nix   # 多光标编辑
    │   └── which-key.nix      # 键位提示
    ├── git/                   # Git 集成
    │   ├── default.nix
    │   ├── gitsigns.nix       # 行内 blame & diff
    │   └── lazygit.nix        # lazygit 二进制包
    ├── languages/             # 语言专属配置
    │   ├── default.nix
    │   ├── cpp.nix
    │   ├── lua.nix
    │   ├── vim.nix            # Vim / Query 语言
    │   ├── shell.nix          # Bash / Fish
    │   ├── markdown.nix
    │   ├── nix.nix
    │   ├── python.nix
    │   ├── rust.nix
    │   └── web.nix            # HTML/JS/TS/JSON/YAML
    └── ui/                    # 界面
        ├── default.nix
        ├── colorscheme.nix    # 配色方案 (tokyonight-storm)
        ├── icons.nix          # mini.icons + web-devicons
        ├── noice.nix          # cmdline & 消息 UI
        ├── nui.nix            # UI 库 (noice/dap-ui 依赖)
        └── statusline.nix     # 状态栏 (lualine)
```

## 主题

默认使用 **tokyonight-storm** 配色方案。

所有 UI 插件（lualine、noice 等）自动跟随 colorscheme，无需单独配置。

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
| **瑞士军刀** | [snacks.nvim](https://github.com/folke/snacks.nvim) | picker、explorer、终端、goto、通知、toggle、scratch 等 |
| **主题** | tokyonight (storm) | nixvim 内置模块，`mkDefault` 可被外部覆盖 |
| **补全** | nvim-cmp + LuaSnip + friendly-snippets | LSP / buffer / path / snippet 四源补全 |
| **格式化** | [conform.nvim](https://github.com/stevearc/conform.nvim) | 统一格式化框架，per-language 配置 |
| **LSP** | clangd / rust-analyzer / lua_ls / nil / pyright / marksman | 六语言 LSP |
| **语法高亮** | nvim-treesitter | 20+ 语言语法解析 |
| **语法上下文** | treesitter-context | 粘性作用域提示（最多 3 行） |
| **语法文本对象** | treesitter-textobjects | `]f`/`[f` 跳转函数/类/参数 |
| **自动标签** | ts-autotag | 自动关闭 HTML/JSX 标签 |
| **注释增强** | ts-comments | 更好的注释语法（treesitter 感知） |
| **批量替换** | [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | 实时搜索替换 |
| **键位提示** | [which-key.nvim](https://github.com/folke/which-key.nvim) | 按键分组菜单 |
| **多光标** | multicursors.nvim | 多光标编辑 |
| **Markdown 渲染** | render-markdown.nvim | Normal/Command/Terminal 模式渲染 |
| **调试** | nvim-dap + dap-ui + lldb-dap / codelldb | 断点、单步、变量面板 |
| **Git 装饰** | gitsigns.nvim | 行内 blame、diff 标记、hunk 操作 |
| **Git 终端** | lazygit (via snacks) | 浮动 Git TUI |
| **状态栏** | lualine | `theme = auto`，自动跟随 colorscheme |
| **命令行 UI** | noice | cmdline、消息路由、搜索 UI |
| **图标** | mini.icons + web-devicons | 文件/目录/filetype 图标 |
| **文本对象** | mini.ai | 增强型文本对象（500 行范围） |
| **自动括号** | mini.pairs | 智能配对（insert/command 模式） |
| **LSP 签名** | lsp-signature | 函数签名提示 |

> 所有插件均使用 nixvim 原生 nix 模块，零 `extraPlugins`。

## 键位映射

Leader 键为 `Space`。

### 常用入口

| 键位 | 动作 | 说明 |
|------|------|------|
| `<leader><space>` | Find Files | 查找文件 |
| `<leader>/` | Live Grep | 实时搜索 |
| `<leader>,` | Commands | 命令面板 |
| `<leader>b` | Buffers | Buffer 列表 |
| `<leader>j` | Jumplist | 跳转历史 |
| `<leader>d` | Diagnostics | 诊断信息 |
| `<leader>D` | Buffer Diagnostics | 当前 buffer 诊断 |
| `<leader>l` | Location List | Location 列表 |
| `<leader>x` | Quickfix List | Quickfix 列表 |
| `<leader>e` | Explorer | 文件浏览器 |
| `<leader>q` | Quit All | 全部退出 |
| `<leader>n` | Notifications | 通知历史 (Snacks picker) |
| `<leader>i` | Buffer Info | 当前文件、Git、LSP 与 DAP 信息 |
| `<leader>.` | Scratch Buffer | 持久化临时笔记 |
| `<leader>t` | Floating Terminal | 浮动终端 |

### Yank / 路径复制 (`<leader>y*`)

| 键位 | 动作 | 说明 |
|------|------|------|
| `<leader>yd` | Directory Path | 复制当前文件所在目录 |
| `<leader>yn` | File Name | 复制当前文件名 |
| `<leader>yy` | Absolute Path | 复制当前文件绝对路径 |
| `<leader>yr` | Relative Path | 复制项目相对路径 |

### Goto (`g*`)

| 键位 | 动作 |
|------|------|
| `gd` | Goto Definition |
| `gr` | Goto References |
| `gi` | Goto Implementation |
| `gt` | Goto Type Definition |
| `gD` | Goto Declaration |
| `ge` | Goto End of File |

### Code (`<leader>c*`)

| 键位 | 动作 |
|------|------|
| `<leader>ca` | Code Action |
| `<leader>cA` | Source Action |
| `<leader>cr` | Rename |
| `<leader>ck` | Signature Help |
| `<leader>cd` | 当前行诊断浮窗 |
| `<leader>cf` | 格式化 |
| `<leader>cF` | 格式化注入语言 |

### 注释 (`Ctrl+/`)

| 键位 | 模式 | 动作 |
|------|------|------|
| `<C-/>` | Normal | 切换当前行注释 |
| `<C-/>` | Visual | 切换选中行注释 |

> 也支持 vim 原生注释文本对象：`gc` + 文本对象（如 `gcip` `gciw` `gca(`）

### Symbols (`<leader>s*`)

| 键位 | 动作 |
|------|------|
| `<leader>ss` | LSP Symbols（文档符号） |
| `<leader>sS` | LSP Workspace Symbols（工作区符号） |
| `<leader>st` | Treesitter Symbols |

### Git (`<leader>g*`)

**Picker / 工具：**

| 键位 | 动作 |
|------|------|
| `<leader>gg` | Lazygit |
| `<leader>gf` | Git Files |
| `<leader>gl` | Git Log |
| `<leader>gL` | Git Log (cwd) |
| `<leader>gH` | Git Stash |
| `<leader>gA` | Git Status |
| `<leader>go` | Git Browse（浏览器打开） |

**Hunk 操作（gitsigns）：**

| 键位 | 动作 |
|------|------|
| `]h` / `[h` | 下一个/上一个 Hunk |
| `]H` / `[H` | 最后一个/第一个 Hunk |
| `<leader>gs` | Stage Hunk |
| `<leader>gr` | Reset Hunk |
| `<leader>gS` | Stage Buffer |
| `<leader>gu` | Undo Stage Hunk |
| `<leader>gR` | Reset Buffer |
| `<leader>gp` | Preview Hunk Inline |
| `<leader>gb` | Blame Buffer |
| `<leader>gd` | Diff This |
| `<leader>gD` | Diff This ~ |
| `ih` | 文本对象：选中 Hunk |
| `<leader>uG` | Toggle Git Signs |

### 文件浏览

| 键位 | 动作 | 说明 |
|------|------|------|
| `<leader>e` | Snacks Explorer | 已打开时聚焦，否则打开文件浏览器 |
| `<Esc>`（文件浏览器中） | Close Explorer | 关闭文件浏览器 |

### Buffer

| 键位 | 动作 |
|------|------|
| `<leader>b` | Buffer Picker |
| `Shift+Left` / `Shift+Right` | 上一个/下一个 Buffer |
| `[b` / `]b` | 上一个/下一个 Buffer |

### 窗口

**导航（裸键）：**

| 键位 | 动作 |
|------|------|
| `Ctrl+H/J/K/L` | 左/下/上/右 窗口切换 |
| `Shift+Ctrl+↑/↓/←/→` | 调整窗口大小 |

**操作（`<leader>w*`）：**

| 键位 | 动作 |
|------|------|
| `<leader>ws` | Split Below |
| `<leader>wv` | Split Right |
| `<leader>wd` | Close Window |
| `<leader>w←/↓/↑/→` | Go to Left/Lower/Upper/Right Window |

### 诊断导航 (`[d` / `]d` 系列)

| 键位 | 动作 |
|------|------|
| `[d` / `]d` | 上一条/下一条诊断 |
| `[e` / `]e` | 上一条/下一条 Error |
| `[w` / `]w` | 上一条/下一条 Warning |
| `[q` / `]q` | 上一个/下一个 Quickfix |


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

### 行移动

| 键位 | 模式 | 动作 |
|------|------|------|
| `Alt+Up` / `Alt+Down` | Normal / Insert / Visual | 上/下移动行 |
| `J` / `K` | Visual | 移动选区下/上 |

### 通用

| 键位 | 模式 | 动作 |
|------|------|------|
| `<C-s>` | 全部 | 保存 |
| `<Esc>` | Insert / Normal / Visual | 清除高亮，回到 Normal |
| `<leader>?` | Normal | Buffer 键位提示 (which-key) |
| `<` / `>` | Visual | 缩进后重新选中 |
| `gcc` | Normal | 切换当前行注释 |
| `gc` + 文本对象 | Normal / Visual | 注释选区 |
| `j` / `k` | Normal / Visual | 尊重 wrap 的行移动 |
| `n` / `N` | Normal / Visual / Operator | 搜索结果导航时自动展开 fold |
| `,` / `.` / `;` | Insert | Undo break-point |

### 多光标 (multicursors.nvim)

| 键位 | 动作 |
|------|------|
| `Ctrl+N` | 选中光标下的下一个匹配 |
| `n` / `N` | 跳到下一个/上一个匹配 |

### 其他

| 键位 | 动作 |
|------|------|
| `<leader>sr` | 批量搜索替换 (grug-far) |
| `<leader>m` | 多光标模式 (multicursors) |

> Vim 肌肉记忆全部保留：`ci"` `di(` `%` `daw` `ciw` `yap` 等不受影响。

## Language Server 配置

| 语言 | Server | Formatter | DAP |
|------|--------|-----------|-----|
| **C/C++** | clangd (`--background-index --clang-tidy --header-insertion=never`) | clang-format | lldb-dap |
| **Rust** | rust-analyzer | rustfmt | codelldb |
| **Lua** | lua_ls (inlay hints, codeLens) | stylua | — |
| **Nix** | nil | nixfmt-rfc-style | — |
| **Python** | pyright | — | — |
| **Markdown** | marksman | prettierd | — |
| **Web (JS/TS/JSON/YAML/HTML)** | — | prettierd | — |
| **Shell (Bash/Fish)** | — | shfmt / fish_indent | — |

> LSP server 均不自动安装，依赖系统 PATH。找不到时 Neovim 跳过该 server，不影响使用。

## Debug 配置

使用 **nvim-dap** + **dap-ui**，调试 adapter 由语言模块选择：

- C/C++：`lldb-dap`，编译后启动，`program = ${fileDirname}/${fileBasenameNoExtension}`
- Rust：`codelldb`，同上

两个 adapter 均依赖系统 PATH，不由配置自动安装。

DAP UI 会在调试开始时自动打开，结束时自动关闭。

### DAP 键位 (`<leader>d*`)

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

## Treesitter 语法支持

```bash
Shell:   Bash
Vim:     Diff, Query, Regex, Vim, Vimdoc
Lua:     Lua, Luadoc, Luap
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
}
```

> `colorschemes.tokyonight.enable` 使用了 `lib.mkDefault true`，外部普通赋值即可覆盖。

> Stylix 会自动生成 Neovim 配色方案。lualine 默认 `theme = "auto"`，自动跟随 colorscheme。

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
