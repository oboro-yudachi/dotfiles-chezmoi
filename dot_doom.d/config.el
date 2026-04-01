;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; miseのshimsをPATHに追加（GUIアプリ起動時にシェルのPATHが引き継がれないため）
(let ((mise-shims (expand-file-name "~/.local/share/mise/shims")))
  (setenv "PATH" (concat mise-shims ":" (getenv "PATH")))
  (add-to-list 'exec-path mise-shims))

;; bundle exec経由でruby-lspを起動しない（GemfileにはrubyLSPは含まれていないため）
;; solargraphを無効化してruby-lspを使う（lsp-modeのデフォルトはsolargraph=ruby-ls）
(after! lsp-mode
  (setq lsp-ruby-lsp-use-bundler nil)
  (setq lsp-disabled-clients (append lsp-disabled-clients '(ruby-ls rubocop-ls))))

(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")
