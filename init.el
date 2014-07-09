(add-to-list 'load-path "~/.emacs.d/cl-lib/")
(require 'cl-lib)
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/rhtml")
(defun my_emacs_color ()
  (interactive)
  (color-theme-install
   '(my_emacs_color
      ;;((background-color . "#3b0c2f")
     ;;((background-color . "#20091b")
     ((background-color . "#000000")
      (background-mode . light)
      (border-color . "#1a1a1a")
      (cursor-color . "#fce94f")
      (foreground-color . "#d3bee0")
      (mouse-color . "black"))
     (fringe ((t (:background "#1a1a1a"))))
     (mode-line ((t (:foreground "#eeeeec" :background "#555753"))))
     (region ((t (:background "#0d4519"))))
     (font-lock-builtin-face ((t (:foreground "#e5e1e4"))))
     (font-lock-comment-face ((t (:foreground "#2774fc"))))
	 (font-lock-doc-face ((t (:foreground "#cd8b00"))))
     (font-lock-function-name-face ((t (:foreground "#f6e00e"))))
     (font-lock-keyword-face ((t (:foreground "#de09f6"))))
     (font-lock-string-face ((t (:foreground "#ff1a24"))))
     (font-lock-type-face ((t (:foreground"#20f00a"))))
     (font-lock-constant-face ((t (:foreground "#45f256"))))
     (font-lock-variable-name-face ((t (:foreground "#08e2e0"))))
	 (font-lock-preprocessor-face ((t (:foreground "309090"))))
	 (font-lock-reference-face ((t (:bold t :foreground "#808bed"))))
     (minibuffer-prompt ((t (:foreground "#729fcf" :bold t))))
     (font-lock-warning-face ((t (:foreground "red" :bold t))))
     )))
(provide 'my_emacs_color)


;;-------Set Colours--------
(require 'color-theme)
(color-theme-initialize)
(my_emacs_color)
;;(color-theme-taming-mr-arneson)


;; Add transparency
(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
          (oldalpha (if alpha-or-nil alpha-or-nil 100))
          (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

 ;; C-8 will increase opacity (== decrease transparency)
 ;; C-9 will decrease opacity (== increase transparency
 ;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)
                               (modify-frame-parameters nil `((alpha . 100)))))

(defun set-frame-alpha (arg &optional active)
  (interactive "nEnter alpha value (1-100): \np")
  (let* ((elt (assoc 'alpha default-frame-alist))
         (old (frame-parameter nil 'alpha))
         (new (cond ((atom old)     `(,arg ,arg))
                    ((eql 1 active) `(,arg ,(cadr old)))
                    (t              `(,(car old) ,arg)))))
    (if elt (setcdr elt new) (push `(alpha ,@new) default-frame-alist))
    (set-frame-parameter nil 'alpha new)))
(global-set-key (kbd "C-c t") 'set-frame-alpha)


(defun set-transparency (alpha-level)
      (interactive "p")
      (message (format "Alpha level passed in: %s" alpha-level))
      (let ((alpha-level (if (&lt; alpha-level 2)
				(read-number "Opacity percentage: " 85)
				alpha-level))
				(myalpha (frame-parameter nil 'alpha)))
				(set-frame-parameter nil 'alpha alpha-level))
				(message (format "Alpha level is %d" (frame-parameter nil 'alpha)))))


;(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)


;; Remove splash screen
(setq inhibit-splash-screen t)


;;ocaml configurations
(setq auto-mode-alist
      (cons '("\\.ml[iyl]?$" . caml-mode) auto-mode-alist))
(setq load-path  (cons "~/.emacs.d/ocaml.emacs" load-path))

(autoload 'caml-mode "ocaml" (interactive)
   "Major mode for editing Caml code." t)
(autoload 'camldebug "camldebug" (interactive) "Debug caml mode")
;(require 'caml-font)
;;enable ctags for code completion
;(setq path-to-ctags "/usr/bin/ctags")

;(defun create-tags(dir-name)
 ; "Create tags file."
  ;(interactive "DDirectory: ")
  ;(shell-command
   ; (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
 ;)

;;enable project navigation
(require 'nav)
(nav-disable-overeager-window-splitting)

;;Enable syntax highlighting
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;enable php syntax highlighting
;(require 'php-mode)
;(setq auto-mode-alist
 ;     (append '(("\.php$" . php-mode)
;		 ("\.module$" . php-mode))
;		auto-mode-alist))

(setq-default transient-mark-mode t)
;;; Lisp (SLIME) interaction
;;(setq inferior-lisp-program "clisp")
;;(add-to-list 'load-path "~/.slime")
;;(require 'slime)
;;(slime-setup)
;;(global-font-lock-mode t)
;;(show-paren-mode 1)
;;(add-hook 'lisp-mode-hook '(lambda ()
;;	(local-set-key (kbd "RET") 'newline-and-indent)))



;;Set tab size to 4 using spaces
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 120 4))
(setq-default indent-tabs-mode nil)
(global-set-key (kbd "TAB") 'self-insert-command)
(setq c-basic-offset 4)
(setq c-basic-indent 4)
(setq python-indent 4)
(setq php-indent-level 4)

;; Permanent use tab-to-tab-stop to control TAB behavior
(global-set-key (kbd "TAB") 'tab-to-tab-stop)


;;Function to find double words
(defun FindNextDbl ()
  "move to the next doubled word, ignoring <...> tags" (interactive)
  (re-search-forward "\\<\\([a-z]+\\)\\([\n\t]\\|<[^>]+>\\)+\\1\\>")
)
(global-set-key  "\C-x\C-d" 'FindNextDbl)

;;Key bindings
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-xl" 'goto-line)
(global-set-key "\C-x\C-f" 'lusty-file-explorer)
(global-set-key "\C-xb" 'lusty-buffer-explorer)

;;turn off menu bars
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;Code folding
;;(global-semantic-folding-mode t)
(load "folding" 'nomessage 'noerror)
  (folding-mode-add-find-file-hook)

;;Autocomplete
(add-to-list 'load-path "/home/evanson/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/evanson/.emacs.d/ac-dict")
(ac-config-default)

;; Generate a taglist
(defvar taglist-mode-hook nil)

(defvar taglist-keywords
  (list (list "^\t\\([^ ]*\\) \\(L[0-9]+\\) *\\(.*\\)$" 1 font-lock-keyword-face)
        (list "^\t\\([^ ]*\\) \\(L[0-9]+\\) *\\(.*\\)$" 2 font-lock-comment-delimiter-face)
        (list "^\t\\([^ ]*\\) \\(L[0-9]+\\) *\\(.*\\)$" 3 font-lock-function-name-face)))

(defvar taglist-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "RET") 'taglist-jump)
    (define-key map (kbd "q") 'taglist-quit)
    map))

(defvar taglist-window nil)
(defvar taglist-current 0)

(defun taglist nil
  (interactive)
  (require 'speedbar)
  (require 'imenu)

  ;; Clear cache
  (setq imenu--index-alist nil)

  (let ((source-buffer (current-buffer))
        (current-line (line-number-at-pos)))

    ;; Create a buffer
    (if (get-buffer "*etags tmp*")
        (kill-buffer "*etags tmp*"))
    (if (get-buffer "*etags list*")
        (kill-buffer "*etags list*"))
    (set-buffer (get-buffer-create "*etags list*"))

    ;; Call speedbar tags
    (setq taglist-current 0)
    (taglist-fill-tags
     source-buffer
     (cddr (speedbar-fetch-dynamic-tags
            (buffer-file-name source-buffer)))
     ""
     current-line)

    (goto-char (point-min))
    (forward-line (1- taglist-current))

    (setq taglist-window (split-window-vertically))
    (set-window-buffer taglist-window "*etags list*")
    (select-window taglist-window)
    (taglist-mode)))

(defun taglist-fill-tags (source-buffer tags prefix current)
  (while tags
    (if (integer-or-marker-p (cdar tags))
        (let ((tag-line
               (with-current-buffer source-buffer
                 (line-number-at-pos (cdar tags)))))
          (insert (format "\t%s L%-5d%s%s\n"
                          (buffer-name source-buffer)
                          tag-line
                          prefix
                          (caar tags)))
          (when (>= current tag-line)
            (setq taglist-current
                  (1+ taglist-current))))
      (let* ((dir-string (caar tags))
             (marker (get-text-property 0 'org-imenu-marker dir-string))
             (tag-line 0))
        (if marker
          (setq tag-line
                (with-current-buffer source-buffer
                  (line-number-at-pos marker))))
        (insert (format "\t%s L%-5d%s%s\n"
                        (buffer-name source-buffer)
                        tag-line
                        prefix
                        (caar tags)))
        (when (>= current tag-line)
          (setq taglist-current
                (1+ taglist-current)))
        (taglist-fill-tags source-buffer
                           (cdar tags)
                           (concat "+-" prefix)
                           current)))
    (setq tags (cdr tags))))

(defun taglist-kill nil
  (if (and taglist-window
           (window-live-p taglist-window)
           (not (one-window-p)))
      (delete-window taglist-window))
  (setq taglist-window nil)
  (kill-buffer "*etags list*"))

(defun taglist-jump nil
  (interactive)
  (let ((line (buffer-substring
               (line-beginning-position)
               (line-end-position))))
    (string-match "^\t\\([^ ]*\\) L\\([0-9]+\\)[^0-9]" line)
    (taglist-kill)
    (switch-to-buffer (match-string 1 line))
    (goto-char (point-min))
    (forward-line (1- (string-to-number (match-string 2 line))))))

(defun taglist-quit nil
  (interactive)
  (taglist-kill))

(defun taglist-mode nil
  (interactive)
  (kill-all-local-variables)
  (use-local-map taglist-map)
  (setq major-mode 'taglist-mode)
  (setq mode-name "Tag-List")
  (setq font-lock-defaults
        (list 'taglist-keywords))
  (run-mode-hooks 'taglist-mode-hook))


(provide 'taglist)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(desktop-globals-to-save (quote (default-frame-alist nil desktop-missing-file-warning tags-file-name tags-table-list search-ring regexp-search-ring register-alist file-name-history)))
 '(desktop-save-mode nil)
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(py-pychecker-command "pychecker.sh")
 '(py-pychecker-command-args (quote ("")))
 '(python-check-command "pychecker.sh")
)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#20091b" :foreground "#d3bee0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "Droid Sans Mono")))))

;; Lusty-explorer: an interactive buffer explorer
(require 'lusty-explorer)

;; Directory tree listing
(require 'dirtree)

;; Add line numbers
(global-linum-mode t)

(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t) 
(autoload 'inf-ruby-setup-keybindings "inf-ruby" "" t) 
(eval-after-load 'ruby-mode '(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings))

;; Auto-indent in ruby-mode
(add-hook 'ruby-mode-hook
      (lambda()
        (add-hook 'local-write-file-hooks
                  '(lambda()
                     (save-excursion
                       (untabify (point-min) (point-max))
                       (delete-trailing-whitespace)
                       )))
        (set (make-local-variable 'indent-tabs-mode) 'nil)
        (set (make-local-variable 'tab-width) 2)
        (imenu-add-to-menubar "IMENU")
        (define-key ruby-mode-map "\C-m" 'newline-and-indent) ;Not sure if this line is 100% right!
        (require 'ruby-electric)
        (ruby-electric-mode t)
        ))

;; Minor mode for rails development
(setq load-path(cons (expand-file-name "~/.emacs.d/emacs-rails") load-path))
(require 'rails-autoload)

;;; rhtml mode
(require 'rhtml-mode)
; put rhtml templates into rhtml-mode
(setq auto-mode-alist  (cons '("\\.erb$" . rhtml-mode) auto-mode-alist))
; put any rjs scripts into ruby-mode, as they are basically ruby
(setq auto-mode-alist  (cons '("\\.rjs$" . ruby-mode) auto-mode-alist))


;; Auto-indent in python-mode
(add-hook 'python-mode-hook 
    '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))


; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "mode-compile"
    "Command to compile current buffer file based on the major mode" t)
 (global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
    "Command to kill a compilation launched by `mode-compile'" t)
 (global-set-key "\C-ck" 'mode-compile-kill)

;;Add symbols for code folding
;(add-to-list 'load-path "~/.emacs.d/hideshowvis")
(require 'hideshowvis)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")

(autoload 'hideshowvis-minor-mode
   "hideshowvis"
   "Will indicate regions foldable with hideshow in the fringe."
   'interactive)

(dolist (hook (list 'emacs-lisp-mode-hook
                     'c++-mode-hook
                     'ruby-mode-hook
                     'python-mode-hook
                     'java-mode-hook
                     'php-mode-hook
                     'c-mode-hook))
   (add-hook hook 'hideshowvis-enable))
(hideshowvis-symbols)
(put 'upcase-region 'disabled nil)

;(require 'cc-mode)
;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . javascript-mode))
 (add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
 (add-to-list 'auto-mode-alist '("\\.patch\\'" . python-mode))
;; web-mode for mixed html, php, java, js, css blah blah blah editing
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-indent-style 4)
(setq web-mode-enable-heredoc-fontification t)

(add-to-list 'auto-mode-alist '("\\.ldif\\'" . conf-mode))

;; File rename
(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))

(global-set-key (kbd "C-c r") 'rename-this-buffer-and-file)

;; Key binding to get a shell in an emacs buffer
(global-set-key (kbd "C-x s") 'shell)

;; python twisted dev mode
;(setq load-path (cons "~/.emacs.d"))
(require 'twisted-dev)
(add-to-list 'auto-mode-alist '("\\.tac\\'" . python-mode))
;; Rope: a refactoring library for python
(add-to-list 'load-path "~/.emacs.d/site-lisp/rope")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ropemode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ropemacs")
;(require 'pymacs)
;(pymacs-load "ropemacs" "rope-")

;; Enable python autocompletion
;; (require 'python)
;; (require 'auto-complete)
;; (require 'yasnippet)

;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))


;; ;; Initialize Pymacs                                                                                           
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)


;; ;; Initialize Rope                                                                                             
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)

;; ;; Initialize Yasnippet                                                                                        
;; ;Don't map TAB to yasnippet                                                                                    
;; ;In fact, set it to something we'll never use because                                                          
;; ;we'll only ever trigger it indirectly.                                                                        
;; (setq yas/trigger-key (kbd "C-c <kp-multiply>"))
;; (yas--initialize)
;; (yas/load-directory "~/.emacs.d/snippets")



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; ;;; Auto-completion                                                                                            
;; ;;;  Integrates:                                                                                               
;; ;;;   1) Rope                                                                                                  
;; ;;;   2) Yasnippet                                                                                             
;; ;;;   all with AutoComplete.el                                                                                 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; (defun prefix-list-elements (list prefix)
;;   (let (value)
;;     (nreverse
;;      (dolist (element list value)
;;       (setq value (cons (format "%s%s" prefix element) value))))))
;; (defvar ac-source-rope
;;   '((candidates
;;      . (lambda ()
;;          (prefix-list-elements (rope-completions) ac-target))))
;;   "Source for Rope")
;; (defun ac-python-find ()
;;   "Python `ac-find-function'."
;;   (require 'thingatpt)
;;   (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
;;     (if (null symbol)
;;         (if (string= "." (buffer-substring (- (point) 1) (point)))
;;             (point)
;;           nil)
;;       symbol)))
;; (defun ac-python-candidate ()
;;   "Python `ac-candidates-function'"
;;   (let (candidates)
;;     (dolist (source ac-sources)
;;       (if (symbolp source)
;;           (setq source (symbol-value source)))
;;       (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
;;              (requires (cdr-safe (assq 'requires source)))
;;              cand)
;;         (if (or (null requires)
;;                 (>= (length ac-target) requires))
;;             (setq cand
;;                   (delq nil
;;                         (mapcar (lambda (candidate)
;;                                   (propertize candidate 'source source))
;;                                 (funcall (cdr (assq 'candidates source)))))))
;;         (if (and (> ac-limit 1)
;;                  (> (length cand) ac-limit))
;;             (setcdr (nthcdr (1- ac-limit) cand) nil))
;;         (setq candidates (append candidates cand))))
;;     (delete-dups candidates)))
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;                  (auto-complete-mode 1)
;;                  (set (make-local-variable 'ac-sources)
;;                       (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))
;;                  (set (make-local-variable 'ac-find-function) 'ac-python-find)
;;                  (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
;;                  (set (make-local-variable 'ac-auto-start) nil)))

;; ;;Ryan's python specific tab completion                                                                        
;; (defun ryan-python-tab ()
;;   ; Try the following:                                                                                         
;;   ; 1) Do a yasnippet expansion                                                                                
;;   ; 2) Do a Rope code completion                                                                               
;;   ; 3) Do an indent                                                                                            
;;   (interactive)
;;   (if (eql (ac-start) 0)
;;       (indent-for-tab-command)))

;; (defadvice ac-start (before advice-turn-on-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) t))
;; (defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) nil))

;; (define-key python-mode-map "\t" 'ryan-python-tab)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; ;;; End Auto Completion                                                                                        
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(put 'downcase-region 'disabled nil)
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/")

(setq ruby-indent-level 2)
