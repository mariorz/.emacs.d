(setq load-path (cons "~/.emacs.d/" load-path))
(setq load-path (cons "~/.emacs.d/emacs-color-theme-solarized/" load-path))

;;;;A fun startup message, somewhat reminiscent of "The Matrix: Reloaded"
(defun emacs-reloaded ()
  (animate-string (concat ";; Initialization successful. Welcome to "
			    (substring (emacs-version) 0 16)
			      ".")
		    0 1)
  (newline-and-indent)  (newline-and-indent))

(add-hook 'after-init-hook 'emacs-reloaded) 




(setq inhibit-startup-message t)
;;;;Require C-x C-c prompt. helps avoid tragic accidents.
;;;;http://www.dotemacs.de/dotfiles/KilianAFoth.emacs.html
(global-set-key [(control x) (control c)] 
  (function 
   (lambda () (interactive) 
     (cond ((y-or-n-p "Quit? ")
            (save-buffers-kill-emacs))))))



(setq mac-function-modifier 'meta)
;;(setq mac-option-modifier 'meta)


;; visual bell is almost as bad as the sound one
;;(setq visible-bell t)
;; this is better
(setq ring-bell-function (lambda () (message "*beep*")))

;;
;; Never understood why Emacs doesn't have this function.
;;
(defun rename-file-and-buffer (new-name)
 "Renames both current buffer and file it's visiting to NEW-NAME." (interactive "sNew name: ")
 (let ((name (buffer-name))
       (filename (buffer-file-name)))
 (if (not filename)
     (message "Buffer '%s' is not visiting a file!" name)
 (if (get-buffer new-name)
      (message "A buffer named '%s' already exists!" new-name)
   (progn  
     (rename-file name new-name 1)  
     (rename-buffer new-name)  
     (set-visited-file-name new-name)  
       (set-buffer-modified-p nil)))))) ;;


;;(defun fullscreen ()
;;  (interactive)

;;  (set-frame-parameter nil 'fullscreen
;;                           (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
;;
;;(global-set-key [f11] 'fullscreen)

;;;;Provide a useful error trace if loading this .emacs fails.
(setq debug-on-error t)
;;;;Use ANSI colors within shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
;(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
;;(setq auto-mode-alist (cons '("\\.htm$" . html-helper-mode) auto-mode-alist))
;;;;While we are at it, always flash for parens.
(show-paren-mode 1)

;;;;Answer y or n instead of yes or no at minibar prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

;;;;I like M-g for goto-line
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-r" 'scheme-send-region-and-go)

;;;;M-dn and M-up do nothing! :(  Let's make them do something, like M-
;;;left and M-right do.
(global-set-key [M-down] '(lambda () (interactive) (progn (forward-line 4) (recenter) ) ))
(global-set-key [M-up]   '(lambda () (interactive) (progn (forward-line -4) (recenter) ) ))

;;;;Completion ignores filenames ending in any string in this list.
(setq completion-ignored-extensions
      '(".o" ".elc" ".class" "java~" ".ps" ".abs" ".mx" ".~jv" ))

;;;Text files supposedly end in new lines. Or they should.
(setq require-final-newline t)

;;;;Set up ibs- lets you cycle through buffers using C-tab
;;;;http://www.geekware.de/software/emacs/#ibs
;(require 'ibs)


;;use visible line numbers
(require 'linum)

;(require 'yasnippet)
;(yas/initialize)
;(yas/load-directory "~/.emacs.d/snippets")

;;(require 'pymacs)
;;(pymacs-load "ropemacs" "rope-")



(require 'color-theme-solarized)
(color-theme-solarized-dark)

;;------------------------
;;Mermalade http://marmalade-repo.org/
;(require 'package)
;(add-to-list 'package-archives 
;    '("marmalade" .
;      "http://marmalade-repo.org/packages/"))
;(package-initialize)
;;------------------


;;http://www.nongnu.org/geiser/geiser_2.html#Installation
(require 'package)
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/"))

;(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;                         ("marmalade" . "http://marmalade-repo.org/packages/")
;                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'package-archives
  '("geiser" . "http://download.savannah.gnu.org/releases/geiser/packages"))
(package-initialize)



;; line numbers for all buffers
;; http://www.emacswiki.org/LineNumbers
(global-linum-mode 1)


;;http://www.emacswiki.org/emacs/AquamacsEmacsCompatibilitySettings
(scroll-bar-mode -1)  ; no scrollbars


;;from http://www.emacswiki.org/emacs/IndentingText
;; Shift the selected region right if distance is postive, left if
;; negative

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

;; Bind (shift-right) and (shift-left) function to your favorite keys. I use
;; the following so that Ctrl-Shift-Right Arrow moves selected text one 
;; column to the right, Ctrl-Shift-Left Arrow moves selected text one
;; column to the left:


(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)

;(setq tramp-shell-prompt-pattern "^mariorz")
;(setq tramp-shell-prompt-pattern "\\(?:^\\| ^M\\)[^#$%>\n]*[#$%>] *\\(\e\\[[0-9;]*[a-zA-Z] *\\)*")
;(setq tramp-shell-prompt-pattern "\bmariorz\b")
(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*$")
;(setq tramp-verbose 8)
 (eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(setq scheme-program-name
    "/Applications/mit-scheme.app/Contents/Resources/mit-scheme")
(require 'xscheme)
(require 'scheme-complete)
;(require 'quack)

(require 'geiser)
(setq geiser-racket-binary "/Applications/racket/bin/racket")
(add-hook 'after-init-hook 'global-company-mode)

;;http://www.gnu.org/software/mit-scheme/documentation/mit-scheme-user/GNU-Emacs-Interface.html#GNU-Emacs-Interface

;(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme" t)
;(setq scheme-program-name "scheme")




(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

;; open *help* in current frame for `one-buffer-one-frame-mode'
(setq obof-other-frame-regexps (remove "\\*Help\\*" obof-other-frame-regexps))
(add-to-list 'obof-same-frame-regexps "\\*Help\\*")
(add-to-list 'obof-same-frame-switching-regexps "\\*Help\\*")
(setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps))


;disable toolbar
(tool-bar-mode 0)
(tabbar-mode 0)
(emulate-mac-spanish-keyboard-mode 1)
