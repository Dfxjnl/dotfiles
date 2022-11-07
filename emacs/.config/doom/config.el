;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Hugo Pungs"
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
(setq doom-theme 'doom-dracula
      doom-font (font-spec :family "JetBrains Mono" :size 13)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24)
      doom-serif-font (font-spec :family "DejaVu Serif" :size 13))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(pixel-scroll-mode 1)

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
(after! evil
  (setq evil-ex-substitute-global t
        evil-kill-on-visual-paste nil
        evil-move-cursor-back nil))

(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=12"
          "--all-scopes-completion"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--cross-file-rename"
          "--header-insertion=iwyu"
          "--header-insertion-decorators"
          "--inlay-hints"
          "--pch-storage=memory"))
  (set-lsp-priority! 'clangd 2))

(after! flycheck
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
                      '((lsp . ((next-checkers . (c/c++-cppcheck)))))
                      flycheck-cppcheck-checks '("all")
                      flycheck-cppcheck-inconclusive t
                      flycheck-cppcheck-suppressions '("functionConst" "unusedFunction" "unusedStructMember")))
              (when (derived-mode-p 'json-mode)
                (setq my/flycheck-local-cache
                      '((lsp . ((next-checkers . (json-python-json))))))
                (flycheck-add-next-checker 'json-python-json 'json-jsonlint)
                (flycheck-add-next-checker 'json-jsonlint 'json-jq))
              (when (derived-mode-p 'python-mode)
                (setq my/flycheck-local-cache
                      '((lsp . ((next-checkers . (python-flake8)))))))))
  (setq flycheck-checker-error-threshold nil))

(+global-word-wrap-mode +1)

(setq +treemacs-git-mode 'deferred)

(after! org
  org-use-property-inheritance t
  org-log-done 'time)

(use-package! org-appear
  :config
  (setq org-appear-autoemphasis t
        org-appear-autolinkts nil
        org-appear-autosubmarkers t)
  ;; For proper first-time setup, `org-appear--set-elements' needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements)
  :hook (org-mode. org-appear-mode))

(use-package! org-transclusion
  :init
  (map! :after org :map org-mode-map
        "<f12>" #'org-transclusion-mode)
  :commands org-transclusion-mode)

(add-hook 'org-mode-hook #'+org-pretty-mode)

(setq which-key-idle-delay 0.5)
(after! which-key
  (pushnew! which-key-replacement-alist
            '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
            '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))))

(setq-default history-length 1000)

(use-package! aas
  :commands aas-mode)

(after! yasnippet
  (setq yas-triggers-in-field t))

(after! smartparens
  (sp-local-pair '(org-mode) "<<" ">>" :actions '(insert)))

(defvar mixed-pitch-modes '(org-mode markdown-mode gfm-mode)
  "Modes that `mixed-pitch-mode' should be enabled in, but only after user
interface initialization.")

(defun init-mixed-pitch-h ()
  "Hook `mixed-pitch-mode' into each mode in `mixed-pitch-modes'. Also
immediately enabled `mixed-pitch-modes' if currently in one of the modes."
  (when (memq major-mode mixed-pitch-modes)
    (mixed-pitch-mode 1))
  (dolist (hook mixed-pitch-modes)
    (add-hook (intern (concat (symbol-name hook) "-hook")) #'mixed-pitch-mode)))

(add-hook 'doom-init-ui-hook #'init-mixed-pitch-h)

(autoload #'mixed-pitch-serif-mode "mixed-pitch"
  "Change the default face of the current buffer to a serified variable pitch,
while keeping some faces fixed pitch." t)

(after! mixed-pitch
  (defface variable-pitch-serif
    '((t (:family "serif")))
    "A variable-pitch face with serifs."
    :group 'basic-faces)
  (setq mixed-pitch-set-height t)
  (setq variable-pitch-serif-font (font-spec :family "Alegreya" :size 14))
  (set-face-attribute 'variable-pitch-serif nil :font variable-pitch-serif-font)
  (defun mixed-pitch-serif-mode (&optional arg)
    "Change the default face of the current buffer to a serified variable pitch,
while keeping some faces fixed pitch."
    (interactive)
    (let ((mixed-pitch-face 'variable-pitch-serif))
      (mixed-pitch-mode (or arg 'toggle)))))

(set-char-table-range composition-function-table ?f '(["\\(?:ff?[fijlt]\\)" 0 font-shape-gstring]))
(set-char-table-range composition-function-table ?T '(["\\(?:Th\\)" 0 font-shape-gstring]))

(after! marginalia
  (setq marginalia-censor-variables nil)

  (defadvice! +marginalia--anotate-local-file-colorful (cand)
    "Just a more colorful version of `marginalia--annotate-local-file'."
    :override #'marginalia--annotate-local-file
    (when-let (attrs (file-attributes (substitute-in-file-name
                                       (marginalia--full-candidate cand))
                                      'integer))
      (marginalia--fields
       ((marginalia--file-owner attrs) :width 12 :face 'marginalia-file-owner)
       ((marginalia--file-modes attrs))
       ((+marginalia-file-size-colorful (file-attribute-size attrs)) :width 7)
       ((+marginalia--time-colorful (file-attribute-modification-time attrs)) :width 12))))

  (defun +marginalia--time-colorful (time)
    (let* ((seconds (float-time (time-subtract (current-time) time)))
           (color (doom-blend (face-attribute 'marginalia-date :foreground nil t)
                              (face-attribute 'marginalia-documentation :foreground nil t)
                              (/ 1.0 (log (+ 3 (/ (+ 1 seconds) 345600.0)))))))
      ;; 1 - log(3 + 1 / (days + 1)) % gray
      (propertize (marginalia--time time) 'face (list :foreground color))))

  (defun +marginalia-file-size-colorful (size)
    (let* ((size-index (/ (log (+ 1 size) 10) 7.0))
           (color (if (< size-index 10000000) ; 10m
                      (doom-blend 'orange 'green size-index)
                    (doom-blend 'red 'orange (- size-index 1)))))
      (propertize (file-size-human-readable size) 'face (list :foreground color)))))

(use-package! page-break-lines
  :commands page-break-lines-mode
  :config
  (setq page-break-lines-max-width fill-column)
  (map! :prefix "g"
        :desc "Prev page break" :nv "[" #'backward-page
        :desc "Next page break" :nv "]" #'forward-page)
  :init
  (autoload 'turn-on-page-break-lines-mode "page-break-lines"))

(setq +zen-text-scale 0.8)

(defvar +zen-serif-p t
  "Whether to use a serified font with `mixed-pitch-mode'.")

(after! writeroom-mode
  (defvar-local +zen--original-org-indent-mode-p nil)
  (defvar-local +zen--original-mixed-pitch-mode-p nil)
  (defvar-local +zen--original-org-pretty-table-mode-p nil)
  (defun +zen-enable-mixed-pitch-mode-h ()
    "Enable `mixed-pitch-mode' when in `+zen-mixed-pitch-modes'."
    (when (apply #'derived-mode-p +zen-mixed-pitch-modes)
      (if writeroom-mode
          (progn
            (setq +zen--original-mixed-pitch-mode-p mixed-pitch-mode)
            (funcall (if +zen-serif-p #'mixed-pitch-serif-mode #'mixed-pitch-mode) 1))
        (funcall #'mixed-pitch-mode (if +zen--original-mixed-pitch-mode-p 1 -1)))))
  (pushnew! writeroom--local-variables
            'display-line-numbers
            'visual-fill-column-width
            'org-adapt-indentation
            'org-superstar-headline-bullets-list
            'org-superstar-remove-leading-stars)
  (add-hook 'writeroom-mode-enable-hook
            (defun +zen-prose-org-h ()
              "Reformat the current Org buffer appearance for prose."
              (when (eq major-mode 'org-mode)
                (setq display-line-numbers nil
                      visual-fill-column-width 60
                      org-adapt-indentation nil)
                (when (featurep 'org-superstar)
                  (setq-local org-superstar-headline-bullets-list '("🙘" "🙙" "🙚" "🙛")
                              org-superstart-remove-leading-stars t)
                  (org-superstar-restart))
                (setq +zen--original-org-indent-mode-p org-indent-mode
                      +zen--original-org-pretty-table-mode-p (bound-and-true-p org-pretty-table-mode))
                (org-indent-mode -1)
                (org-pretty-table-mode 1))))
  (add-hook 'writeroom-mode-disable-hook
            (defun +zen-nonprose-org-h ()
              "Reverse the effect of `+zen-prose-org'."
              (when (eq major-mode 'org-mode)
                (when (featurep 'org-superstar)
                  (org-superstar-restart))
                (when +zen--original-org-indent-mode-p (org-indent-mode 1))))))

(use-package! nov
  :config
  (map! :map nov-mode-map
        :n "RET" #'nov-scroll-up)

  (defun doom-modeline-segment--nov-info ()
    (concat " "
            (propertize (cdr (assoc 'creator nov-metadata)) 'face 'doom-modeline-project-parent-dir)
            " "
            (cdr (assoc 'title nov-metadata))
            " "
            (propertize (format "%d/%d"
                                (1+ nov-documents-index)
                                (length nov-documents))
                        'face 'doom-modeline-info)))

  (advice-add 'nov-render-title :override #'ignore)

  (defun +nov-mode-setup ()
    (setq-local line-spacing 0.2
                next-screen-context-lines 4
                shr-use-colors nil)
    (require 'visual-fill-column nil t)
    (setq-local visual-fill-column-center-text t
                visual-fill-column-width 81
                nov-text-width 80)
    (visual-fill-column-mode 1)
    (hl-line-mode -1)

    (add-to-list '+lookup-definition-functions #'+lookup/dictionary-definition)

    (setq-local mode-line-format
                `((:eval (doom-modeline-segment--workspace-name))
                  (:eval (doom-modeline-segment--window-number))
                  (:eval (doom-modeline-segment--nov-info))
                  ,(propertize " %P " 'face 'doom-modeline-buffer-minor-mode)
                  ,(propertize " " 'face (if (doom-modeline--active) 'mode-line 'mode-line-inactive)
                               'display `((space
                                           :align-to
                                           (- (+ right right-fringe right-margin)
                                              ,(* (let ((width (doom-modeline--font-width)))
                                                    (or (and (= width 1) 1)
                                                        (/ width (frame-char-width) 1.0)))
                                                  (string-width
                                                   (format-mode-line
                                                    (cons ""
                                                          '(:eval (doom-modeline-segment--major-mode))))))))))
                  (:eval (doom-modeline-segment--major-mode)))))

  (add-hook 'nov-mode-hook #'+nov-mode-setup)
  :mode ("\\.epub\\'" . nov-mode))

(after! calc
  (setq calc-symbolic-mode t))

(setq lsp-ui-doc-show-with-mouse t
      lsp-ui-sideline-show-hover t)

(setq fill-column 100)
