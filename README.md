# vim-browser

カーソル行にある URL をブラウザで開く Vim / Neovim プラグインです。

## 概要 / Overview

`<Leader>w` キーマップを使用して、現在のカーソル行から URL（`http`、`ftp`、`file` で始まる文字列）を取得し、ブラウザで開きます。

対応 OS / Supported OS:

| OS | コマンド |
|----|---------|
| Windows | `start` |
| macOS | `open` |
| Linux | `xdg-open` |

## バージョン / Versions

このプラグインは Vim 向けの VimScript 版と Neovim 向けの Lua 版の両方を提供しています。

---

## VimScript 版（Vim / Neovim 共通）

### ファイル

```
plugin/browser.vim
```

### インストール方法

**vim-plug の場合:**

```vim
Plug 'redtower/vim-browser'
```

**dein.vim の場合:**

```vim
call dein#add('redtower/vim-browser')
```

**手動インストール:**

`plugin/browser.vim` を Vim の `plugin` ディレクトリへ配置してください。

### 使用方法

| 操作 | 説明 |
|------|------|
| `<Leader>w` | カーソル行の URL をブラウザで開く |

**例:**

```
" カーソルを以下のような行に置いて <Leader>w を押す
https://www.example.com
ftp://ftp.example.com/file.txt
file:///home/user/document.html
```

---

## Lua 版（Neovim 専用）

### ファイル

```
lua/browser.lua
```

### インストール方法

**lazy.nvim の場合:**

```lua
{
  'redtower/vim-browser',
  config = function()
    require('browser')
  end,
}
```

**packer.nvim の場合:**

```lua
use {
  'redtower/vim-browser',
  config = function()
    require('browser')
  end,
}
```

**手動インストール:**

`lua/browser.lua` を Neovim の `lua` ディレクトリへ配置し、`init.lua` に以下を追加してください。

```lua
require('browser')
```

### 使用方法

VimScript 版と同じキーマップが利用できます。

| 操作 | 説明 |
|------|------|
| `<Leader>w` | カーソル行の URL をブラウザで開く |

**例:**

```lua
-- init.lua でのロード
require('browser')

-- モジュールとして関数を直接呼び出すことも可能
local browser = require('browser')
browser.browser()   -- カーソル行の URL をブラウザで開く
```

---

## 注意事項 / Notes

- VimScript 版と Lua 版は共存できます。ただし、両方をロードすると `<Leader>w` キーマップが重複して登録されるため、どちらか一方のみをロードしてください。
- Linux では `xdg-open` コマンドが必要です。ほとんどのデスクトップ環境には標準で含まれています。

## ライセンス / License

MIT
