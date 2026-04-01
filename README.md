# dotfiles

macOS（Apple Silicon）向けの個人 dotfiles。[chezmoi](https://www.chezmoi.io/) で管理。

---

## 新しいマシンのセットアップ

### 1. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. chezmoi のインストールと適用

```bash
brew install chezmoi
chezmoi init --apply oboro-yudachi/dotfiles
```

これで管理しているすべてのファイルがホームディレクトリに展開される。

### 3. Doom Emacs

```bash
# 依存ツール
brew install git ripgrep fd coreutils fd fontconfig markdown shellcheck
brew install --cask font-rambla
xcode-select install

# emacs-mac
brew tap railwaycat/emacsmacport
brew install emacs-mac --with-modules --with-native-compilation
# --with-native-compilation を省略すると doom doctor で native compilation 未対応の警告が出る
ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications/Emacs.app

# Doom Emacs 本体（公式: https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org#doom-emacs）
```

chezmoi で `~/.doom.d/` の設定が展開済みなので、`doom install` 後そのまま使える。

### 4. ランタイム

ランタイムは [mise](https://mise.jdx.dev/) で一元管理する。

```bash
brew install mise

# シェルへの統合は ~/.zshrc に記載済み
# 各ランタイムをインストール（~/.config/mise/config.toml の定義に従う）
mise install
```

### 5. Raycast（手動）

1. [Raycast](https://www.raycast.com/) を公式サイトからインストール
2. Extensions → Script Commands → Add Directories で `~/bin` を登録

---

## 日常的な使い方

```bash
# ファイルをchezmoiの管理下に追加
chezmoi add ~/.zshrc

# ソースを編集
chezmoi edit ~/.zshrc

# ホームに反映
chezmoi apply

# リモートの変更を取得して反映
chezmoi update

# GitHubにpush
chezmoi cd
git add -A && git commit -m "..." && git push
exit
```

