;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-one)
(setq display-line-numbers-type nil)
(setq org-directory "~/org/")

(defun my/im-select-abc ()
  (when (executable-find "im-select")
    (start-process "im-select" nil "im-select" "com.apple.keylayout.ABC")))

;; insertから抜けたタイミング
(add-hook 'evil-insert-state-exit-hook #'my/im-select-abc)

;; minibuffer（コマンド入力）終了時も寄せたい場合
(add-hook 'minibuffer-exit-hook #'my/im-select-abc)

;; miseのshimsをPATHに追加（GUIアプリ起動時にシェルのPATHが引き継がれないため）
(let ((mise-shims (expand-file-name "~/.local/share/mise/shims")))
  (setenv "PATH" (concat mise-shims ":" (getenv "PATH")))
  (add-to-list 'exec-path mise-shims))

;; bundle exec経由でruby-lspを起動しない（GemfileにはrubyLSPは含まれていないため）
;; solargraphを無効化してruby-lspを使う（lsp-modeのデフォルトはsolargraph=ruby-ls）
(after! lsp-mode
  (setq lsp-ruby-lsp-use-bundler nil)
  (setq lsp-disabled-clients (append lsp-disabled-clients '(ruby-ls rubocop-ls))))

(use-package lsp-mode
  :config
  (setq lsp-inlay-hint-enable t)
  (setq lsp-disabled-clients '(rubocop-ls))
  (setq lsp-javascript-format-enable nil)
  (setq lsp-typescript-format-enable nil)
  :hook
  ((ruby-mode . lsp)
   (tsx-ts-mode . lsp)
   (typescript-ts-mode . lsp)))

(use-package lsp-ui)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq-default tab-width 2)

;; treemacsの設定
(after! treemacs
  ;; 幅を固定ロックしない（手で調整可能にする）
  (setq treemacs-width-is-initially-locked nil
        treemacs-width 50) ; デフォルト幅

  (defun my/treemacs-set-width (width)
    "Treemacs の幅を WIDTH（列数）に設定する。"
    (interactive "nTreemacs width: ")
    (setq treemacs-width width)
    (when-let ((win (treemacs-get-local-window)))
      (adjust-window-trailing-edge win (- width (window-total-width win)) t))))

(defun open-in-cursor ()
  "Open the current file in Cursor."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
        (start-process "open-in-cursor" nil "open" "-a" "Cursor" filename)
      (message "No file associated with this buffer."))))

(map! :leader
      :desc "Open in Cursor"
      "o C" #'open-in-cursor)

(map! :leader
      :desc "Toggle LSP headerline breadcrumb"
      "l b" #'lsp-headerline-breadcrumb-mode)

(map! :leader
      :desc "Vertico project search"
      "/" #'+vertico/project-search)

(map! :leader
      :desc "treemacs select window"
      "l w" #'treemacs-select-window)

(map! :leader
      :desc "Vertico project search"
      "/" #'+vertico/project-search)
