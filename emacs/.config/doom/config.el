;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq
  user-full-name
  "Hugo Pungs"
  user-mail-address "dfxjnl@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq
  doom-theme
  'doom-dracula
  doom-font (font-spec :family "JetBrainsMono" :size 12)
  doom-variable-pitch-font (font-spec :familty "Noto Sans" :size 13))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/projects/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Better defaults.
(setq-default
  window-combination-resize
  t
  x-stretch-cursor t)

(setq
  truncate-string-ellipsis
  "…"
  password-cache-expiry nil
  scroll-margin 2)

(global-subword-mode 1) ; Iterate through CamelCase words.

;; Windows.
(setq
  evil-split-window-below
  t
  evil-vsplit-window-right t)

;; Which-key.
(setq which-key-idle-delay 0.5)
;; Remove `evil-' appearing everywhere.
(setq which-key-allow-multiple-replacements t)
(after!
  which-key
  (pushnew!
    which-key-replacement-alist
    '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
    '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))))

;; View large files.
(use-package!
  vlf-setup
  :defer-incrementally
  vlf-tune
  vlf-base
  vlf-write
  vlf-search
  vlf-occur
  vlf-follow
  vlf-ediff
  vlf)

;; Evil.
(after!
  evil
  (setq
    evil-ex-substitute-global
    t
    evil-move-cursor-back nil))

;; Company.
(after! company (setq company-idle-delay 0.5))

;; Plain text.
(set-company-backend!
  '(text-mode markdown-mode gfm-mode)
  '(:separate company-ispell company-files company-yasnippet))

;; YASnippet.
(setq yas-triggers-in-field t)

;; Emacs lisp auto-formatter.
(use-package! elisp-autofmt :hook (emacs-lisp-mode . elisp-autofmt-mode))
(add-hook!
  'emacs-lisp-mode
  (lambda ()
    (require 'elisp-autofmt)
    (elisp-autofmt-save-hook-for-this-buffer)))

(setq lsp-clients-clangd-args '("--clang-tidy" "--header-insertion-decorators"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(defvar-local my/flycheck-local-cache nil)
(defun my/flycheck-checker-get (fn checker property)
  (or
    (alist-get property (alist-get checker my/flycheck-local-cache))
    (funcall fn checker property)))

(advice-add 'flycheck-checker-get :around 'my/flycheck-checker-get)

(add-hook 'lsp-managed-mode-hook
  (lambda ()
    (when (derived-mode-p 'c++-mode)
      (setq my/flycheck-local-cache
        '((lsp . ((next-checkers . (c/c++-cppcheck)))))))))
(setq flycheck-cppcheck-checks '("style" "performance" "warning" "portability"))

(setq flycheck-checker-error-threshold nil)

(use-package! highlight-escape-sequences :hook (prog-mode . hes-mode))

;; Language customizations.
(define-generic-mode
  sxhkd-mode
  '(?#)
  '("alt" "Escape" "super" "bspc" "ctrl" "space" "shift")
  nil
  '("sxhkd")
  nil
  "Simple mode for sxhkdrc files.")
