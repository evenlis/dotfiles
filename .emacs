;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(tool-bar-mode -1)

(require 'jabber)
(require 'tramp)

(add-to-list 'load-path "~/.emacs.d/flex-mode")
(require 'flex-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/emacsAddons/")
(add-to-list 'load-path "/home/even/.emacs.d/auto-complete")
(require 'auto-complete-config)
(require 'filesets)
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)

(add-to-list 'ac-dictionary-directories "/home/even/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)

;; magit test
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; no more trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'java-mode-hook '(lambda()
			     (local-set-key (kbd "RET") 'newline-and-indent)))

(let ((default-directory "~/.emacs.d/emacsAddons/"))
  (normal-top-level-add-subdirs-to-load-path))

(electric-pair-mode +1)

(require 'linum) ;; line numbers
(global-linum-mode 1)

;; camelCase
(add-hook 'prog-mode-hook 'subword-mode)
(add-hook 'haskell-mode-hook 'subword-mode)

;; storing temporary data in the system's temporary directory instead of the current folder:
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; loading solarized color theme:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/noctilux-theme/")
;;(load-theme 'solarized-light t)
(set-face-attribute 'default nil :font"Inconsolata-13")

;; setting default window size:
 (if window-system
      (set-frame-size (selected-frame) 80 24))


(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;; hotkeys for resizing buffers.
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-list (quote (("zathura" "zathura -P 1 %s.pdf"))))
 '(TeX-view-program-selection (quote ((output-pdf "zathura") (output-dvi "xdvi") (output-pdf "zathura") (output-html "xdg-open"))))
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(ansi-term-color-vector [unspecified "#2d2d2d" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#f2f0ec"])
 '(background-color "#202020")
 '(background-mode dark)
 '(cursor-color "#cccccc")
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes (quote ("7cd77efdb74989d9efe482c530b0839cd3c34003aca88311d09bc08ed2669ecf" "5f39ab775124aaccc7db0e9437cc9eccf7bcbc7ff2a3dc71e9bfd51a937be6cf" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "88d556f828e4ec17ac074077ef9dcaa36a59dccbaa6f2de553d6528b4df79cbd" default)))
 '(foreground-color "#cccccc")
 '(inhibit-startup-screen t)
 '(line-number-mode nil))

(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(setq TeX-PDF-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

(require 'smooth-scroll)
;; scroll one line at a time (less "jumpy" than defaults)
(smooth-scroll-mode 1)
