# Nixvim Configuration

个人 Nixvim 配置，针对 **C/C++、Rust、Nix、Python、Markdown** 开发优化。
采用 **Vim 编辑模型 + Helix 风格键位** 的混合方案。

## 快速开始

```bash
nix run .            # 构建并启动
nix develop          # 进入开发环境（nil + nixfmt）
```

## 项目结构

```
nixvim/
├── flake.nix              # Flake 入口 + devShell
├── flake.lock
├── .gitignore
├── AGENTS.md              # AI Agent 开发规范
├── README.md
└── config/
    ├── default.nix        # 模块入口，import 所有子模块
    ├── options.nix        # 共享选项（theme）、编辑器设置、自动命令
    ├── plugins.nix        # 插件配置 + 键位映射
    ├── lsp.nix            # Language Server Protocol
    ├── treesitter.nix     # 语法高亮 & 解析
    ├── dap.nix            # Debug Adapter Protocol
    ├── git.nix            # Git 集成
    └── ui.nix             # 界面：状态栏、标签栏、缩进线等
```

## 主题

默认使用 **catppuccin** (mocha) 配色方案。

所有 UI 插件（lualine、bufferline、telescope、noice 等）自动跟随 colorscheme，无需单独配置。

### 外部覆盖

```nix
# 切换到其他 colorscheme（catppuccin 用了 mkDefault，普通赋值即可关闭）
{
  colorschemes.catppuccin.enable = false;
  colorschemes.tokyonight.enable = true;
}
```

## 插件一览

| 类别 | 插件 | 说明 |
|------|------|------|
| **主题** | catppuccin (mocha) | 配色方案，`mkDefault` 可被外部关闭 |
| **文件浏览** | oil.nvim | 目录即 buffer，编辑即操作 |
| **模糊搜索** | telescope.nvim | 文件、grep、buffer、命令面板 |
| **补全** | nvim-cmp + LuaSnip | LSP / buffer / path / snippet |
| **键位提示** | which-key.nvim | 按 Space 弹出菜单 |
| **多光标** | multicursors.nvim | 内置多光标编辑 |
| **Markdown 渲染** | render-markdown.nvim | Normal/Command/Terminal 模式渲染 |
| **LSP** | clangd / rust-analyzer / nil / pyright / marksman | 五语言 LSP |
| **格式化** | lsp-format | LSP 自动格式化 |
| **语法高亮** | nvim-treesitter | C/C++/Rust/Nix/Python/Markdown 等 |
| **语法上下文** | treesitter-context | 粘性作用域提示 |
| **调试** | nvim-dap + dap-ui + codelldb | 断点、单步、变量面板 |
| **Git 装饰** | gitsigns.nvim | 行内 blame、diff 标记 |
| **Git 终端** | lazygit | 浮动 Git TUI |
| **状态栏** | lualine | `theme = auto`，自动跟随 colorscheme |
| **标签栏** | bufferline | LSP 诊断显示 |
| **命令行 UI** | noice | 更好的 cmdline & 消息 |
| **缩进线** | indent-blankline | 作用域高亮 |

> 所有插件均使用 nixvim 原生 nix 模块，零 `extraPlugins`。

## 键位映射

Leader 键为 `Space`。

### Helix 风格快捷键

| 键位 | 动作 | 说明 |
|------|------|------|
| `Space+Space` | Telescope find_files | 打开文件 (Helix `space+f`) |
| `Space+/` | Telescope live_grep | 实时搜索 (Helix `space+/`) |
| `Space+,` | Telescope commands | 命令面板 (Helix `space+?`) |
| `-` | Oil | 文件浏览器 (Helix 风格) |

### Telescope 搜索

| 键位 | 动作 |
|------|------|
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 实时 Grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | 帮助标签 |
| `<leader>fr` | 最近文件 |
| `<leader>fs` | 搜索光标下的字符串 |
| `<leader>fd` | 诊断信息 |
| `<leader>fk` | 键位列表 |
| `<leader>gf` | Git 文件 |
| `<leader>gj` | Jump list |
| `<leader>gm` | Marks |

### 文件浏览器

| 键位 | 动作 |
|------|------|
| `<leader>e` | Oil 文件浏览器 |
| `-` | Oil (快捷) |

### Buffer

| 键位 | 动作 |
|------|------|
| `Shift+H` | 上一个 Buffer |
| `Shift+L` | 下一个 Buffer |
| `<leader>bc` | 关闭 Buffer |
| `<leader>bx` | 强制关闭 |
| `<leader>bo` | 关闭其他所有 Buffer |
| `<leader>bl` | Buffer 列表 |
| `<leader>bn` | 新建 Buffer |

### 窗口导航

| 键位 | 动作 |
|------|------|
| `Ctrl+H/J/K/L` | 左/下/上/右 窗口切换 |

### 选择 (Helix 风格)

| 键位 | 动作 |
|------|------|
| `<leader>ss` | 选中单词 |
| `<leader>sl` | 选中整行 |
| `<leader>s%` | 全选 |
| `<leader>si` | 选中括号内 |
| `<leader>sa` | 选中括号外 |
| `<leader>si"` | 选中引号内 |

### Git

| 键位 | 动作 |
|------|------|
| `<leader>gg` | LazyGit |
| `<leader>gh` | 预览 Hunk |
| `<leader>gd` | Diff this |
| `<leader>gb` | Blame line |
| `]c` / `[c` | 下一个/上一个 Hunk |

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

### LSP (按 Buffer 生效)

| 键位 | 动作 |
|------|------|
| `gd` | Go to definition |
| `gD` | Go to references |
| `gt` | Go to type definition |
| `gi` | Go to implementation |
| `K` | Hover 文档 |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>cd` | 打开诊断浮窗 |
| `[d` / `]d` | 上一条/下一条诊断 |

### 通用

| 键位 | 动作 |
|------|------|
| `<leader>w` | 保存 |
| `<leader>q` | 退出 |
| `<leader>Q` | 全部退出 |
| `<Esc>` | 清除搜索高亮 |
| `Alt+J` / `Alt+K` | 上/下移动行 (Normal & Visual) |

### Visual 模式增强

| 键位 | 动作 |
|------|------|
| `<` / `>` | 缩进后重新选中 |
| `J` / `K` | 移动选区下/上 |

### 多光标 (multicursors.nvim)

| 键位 | 动作 |
|------|------|
| `Ctrl+N` | 选中光标下的下一个匹配 |
| `n` / `N` | 跳到下一个/上一个匹配 |

> Vim 肌肉记忆全部保留：`ci"` `di(` `%` `daw` `ciw` `yap` 等不受影响。

## Language Server 配置

| 语言 | Server | 配置 |
|------|--------|------|
| **C/C++** | clangd | `--background-index` `--clang-tidy` `--header-insertion=never` |
| **Rust** | rust-analyzer | 依赖系统 PATH |
| **Nix** | nil | 默认配置 |
| **Python** | pyright | 默认配置 |
| **Markdown** | marksman | 链接跳转、诊断、补全、大纲 |

> LSP server 均不自动安装，依赖系统 PATH。找不到时 Neovim 跳过该 server，不影响使用。

## Debug 配置

使用 **nvim-dap** + **codelldb** (基于 LLDB)：

- C/C++：编译后启动，`program = ${fileDirname}/${fileBasenameNoExtension}`
- Rust：同上
- Python：`program = ${file}`，自动附加

DAP UI 会在调试开始时自动打开，结束时自动关闭。

## Treesitter 语法支持

```
C, C++, Rust, Nix, Bash, Python, Lua,
Markdown, Markdown Inline, Vim, Vimdoc, Query
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
    colorschemes.catppuccin.enable = false;
    colorschemes.tokyonight.enable = true;
  }
];
```

### 禁用/覆盖插件

```nix
modules = [
  nixvim-config
  {
    plugins.oil.enable = nixvim.lib.mkForce false;
  }
];
```

### 与 Stylix 集成

当 NixOS 配置使用 Stylix 管理主题时，关掉本配置自带的 catppuccin，让 Stylix 接管：

```nix
# NixOS configuration.nix
{
  imports = [
    stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };

  programs.nixvim = {
    enable = true;

    # 关掉本配置自带的 catppuccin（mkDefault 使得普通赋值即可覆盖）
    colorschemes.catppuccin.enable = false;

    # 导入本配置的其他设置（键位、插件、LSP 等全部保留）
    imports = [ nixvim-config ];
  };
};
```

> 因为 `colorschemes.catppuccin.enable` 使用了 `lib.mkDefault true`，
> 外部普通赋值 `= false` 即可覆盖，不需要 `mkForce`。
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

- [Nixvim Documentation](https://nix-community.github.io/nixvim/)
- [Nixvim GitHub](https://github.com/nix-community/nixvim)
