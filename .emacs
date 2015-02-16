(global-unset-key (kbd "C-z"))
(tool-bar-mode -1)
(menu-bar-mode -1)

;; config load-paths
(add-to-list 'load-path "~/.emacs.d/flex-mode")
(add-to-list 'load-path "~/.emacs.d/emacsAddons/")
(add-to-list 'load-path "/home/evenlis/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.gnus")
(add-to-list 'load-path "~/.emacs.d/emacs-eclim")
(add-to-list 'load-path "/home/evenlis/dev/android-sdk-linux/tools/lib")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/noctilux-theme/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(let ((default-directory "~/.emacs.d/emacsAddons/"))
  (normal-top-level-add-subdirs-to-load-path))

(defalias 'pinst 'package-install)

(require 'iso-transl)
(require 'auto-complete-config)
(require 'filesets)
(require 'tramp)
(require 'flex-mode)
(require 'highlight-parentheses)
(require 'auto-complete-config)
(require 'linum)
(require 'smooth-scroll)
(require 'markdown-mode)
(require 'god-mode)
(require 'flymake)
(require 'eww)
(require 'quickrun)
(require 'eclim)
(require 'eclimd)
(require 'ac-emacs-eclim-source)
(require 'company)
(require 'company-emacs-eclim)
(require 'android-mode)
(require 'android)

(custom-set-variables '(android-mode-sdk-dir "/home/evenlis/dev/android-sdk-linux"))

(smooth-scroll-mode 1)
(global-linum-mode 1)
(scroll-bar-mode -1)
(column-number-mode 1)

(add-to-list 'auto-mode-alist '("\\.qml\\'" . qml-mode))
(add-hook 'qml-mode-hook (lambda () (subword-mode 1)))
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.fs\\'" . fsharp-mode))

;; eclim config
(custom-set-variables
  '(eclim-eclipse-dirs '("~/eclipse"))
  '(eclim-executable "~/eclipse/eclim"))

;; eclim, show error detail in echo area
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; eclim, auto complete
(ac-emacs-eclim-config)

;; eclim, company-mode style autocompletion
(company-emacs-eclim-setup)

(delq 'ac-source-yasnippet ac-sources)

;; eclim, start all necessary java features
(defun eclim ()
  (interactive)
  (eclim-mode 1)
  (ac-config-default)
  (global-company-mode t))

(defalias 'eclimd 'start-eclimd)

;; F# hotkeys
(add-hook 'fsharp-mode-hook
          (lambda () (define-key fsharp-mode-map (kbd "M-h") 'insert-back-pipe)))
(add-hook 'fsharp-mode-hook
          (lambda () (define-key fsharp-mode-map (kbd "M-l") 'insert-fwd-pipe)))
(add-hook 'fsharp-mode-hook
          (lambda () (define-key fsharp-mode-map (kbd "M-n") 'insert-choice-operator)))


;; quickrun C++ config
(quickrun-add-command "c++/c11"
                      '((:command . "g++")
                        (:exec    . ("%c -std=c++0x %o -o %e %s"
                                     "%e %a"))
                        (:remove  . ("%e")))
                      :default "c++")

;; quickrun C config
(quickrun-add-command "c/gcc"
                      '((:exec . ("%c -std=c99 %o -o %e %s"
                                  "%e %a")))
                      :override t)

;; enable haskell-mode when editing frege files
(add-to-list 'ac-dictionary-directories "/home/evenlis/.emacs.d/ac-dict")
(add-to-list 'auto-mode-alist '("\\.fr$" . haskell-mode))

;; pretty lambda mode in python
(add-hook 'python-mode-hook (lambda () (pretty-lambda-mode 1)))

;; haskell mode indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; uniquify buffer names
(require 'uniquify) ; bundled with GNU emacs 23.2.1 or before. On in 24.4
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ; emacs 24.4 style ⁖ cat.png<dirName>

;; set 2 spaces default indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; create necessary directories upon creating new file
(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))
;; only show bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-command-list
   (quote
    (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("Makeinfo" "makeinfo %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (ams-tex-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
     ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
     ("View" "zathura -P 1 %s.pdf" TeX-run-discard-or-function t t :help "Run Viewer")
     ("Print" "%p" TeX-run-command t t :help "Print the file")
     ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file")
     ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file")
     ("Check" "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-engine (quote luatex))
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-list (quote (("zathura" "zathura -P 1 %s.pdf"))))
 '(TeX-view-program-selection
   (quote
    ((output-pdf "zathura")
     (output-dvi "xdvi")
     (output-pdf "zathura")
     (output-html "xdg-open"))))
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(ansi-term-color-vector
   [unspecified "#2d2d2d" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#f2f0ec"])
 '(background-color "#202020")
 '(background-mode dark)
 '(coffee-tab-width 4)
 '(cursor-color "#cccccc")
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("7cd77efdb74989d9efe482c530b0839cd3c34003aca88311d09bc08ed2669ecf" "5f39ab775124aaccc7db0e9437cc9eccf7bcbc7ff2a3dc71e9bfd51a937be6cf" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "88d556f828e4ec17ac074077ef9dcaa36a59dccbaa6f2de553d6528b4df79cbd" default)))
 '(foreground-color "#cccccc")
 '(inhibit-startup-screen t)
 '(line-number-mode nil)
 '(nxml-slash-auto-complete-flag t)
 '(python-indent-offset 2)
 '(send-mail-function (quote mailclient-send-it))
 '(tool-bar-mode nil)
 '(user-full-name "Even Lislebø")
 '(user-mail-address "e.lislebo@gmail.com"))

;; camelCase
(add-hook 'prog-mode-hook 'subword-mode)
(add-hook 'haskell-mode-hook 'subword-mode)

;; delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; magit test
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; highlight and insert matching delimiters
(electric-pair-mode +1)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; storing temporary data in the system's temporary directory instead of the current folder:
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; setting default window size:
 (if window-system
      (set-frame-size (selected-frame) 80 24))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; indicate god-mode with different cursor
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'bar
                      'box)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

;; hotkeys for resizing buffers.
(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)

;; cycle buffers
(global-set-key (kbd "C-s-k") 'previous-buffer)
(global-set-key (kbd "C-s-j") 'next-buffer)

;; switch between windows
(global-set-key (kbd "C-M-b") 'windmove-left)
(global-set-key (kbd "C-M-f") 'windmove-right)
(global-set-key (kbd "C-M-p") 'windmove-up)
(global-set-key (kbd "C-M-n") 'windmove-down)

;; call quickrun on current buffer
(global-set-key (kbd "C-q") 'quickrun)
(global-set-key (kbd "C-s-q") 'quickrun-with-arg)

;; bookmark hotkeys
(global-set-key (kbd "C-s-c") 'bookmark-set)
(global-set-key (kbd "C-s-l") 'bookmark-jump)
(global-set-key (kbd "C-s-d") 'bookmark-delete)

;; quick android build & deploy
(global-set-key (kbd "C-c C-j") 'android-ant-debug)
(global-set-key (kbd "C-x C-j") 'android-ant-installd)

;; hotkey to toggle god-mode
(global-set-key (kbd "<escape>") 'god-local-mode)

;; hotkey to transpose windows
(global-set-key (kbd "C-s-SPC") 'transpose-windows)
(global-set-key (kbd "C-s-n") 'transpose-n-windows)

;; hotkey to close window without killing buffer
(global-set-key (kbd "C-s-w") 'delete-window)

;; hotkey to kill buffer and window
(global-set-key (kbd "C-M-w") 'kill-buffer-and-window)

;; hotkey to zoom in an out
(global-set-key (kbd "C-S-<double-mouse-5>") 'text-scale-decrease)
(global-set-key (kbd "C-S-<double-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "C-=") 'text-scale-adjust)

;; neotree hotkey
(global-set-key (kbd "M-RET") 'neotree-toggle)

;;;;;;;;;; Custom functions ;;;;;;;;;;

(defun insert-back-pipe ()
  "Insert <| at cursor point."
  (interactive)
  (insert "<|"))

(defun insert-fwd-pipe ()
  "Insert |> at cursor point."
  (interactive)
  (insert "|>"))

(defun insert-choice-operator ()
  "Insert <|> at cursor point."
  (interactive)
  (insert "<|>"))

;; transpose windows
(defun transpose-windows ()
  (interactive)
  (let ((this-buffer (window-buffer (selected-window)))
        (other-buffer (prog2
                          (other-window +1)
                          (window-buffer (selected-window))
                        (other-window -1))))
    (switch-to-buffer other-buffer)
    (switch-to-buffer-other-window this-buffer)
    (other-window -1)))

;; kill all buffers except current
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))
