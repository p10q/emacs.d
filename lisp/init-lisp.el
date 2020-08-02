;; -*- coding: utf-8; lexical-binding: t; -*-

(defun show-scratch-buffer-message ()
  (let* ((fortune-prog (or (executable-find "fortune-zh")
                           (executable-find "fortune"))))
    (cond
     (fortune-prog
      (format
       ";; %s\n\n"
       (replace-regexp-in-string
        "\n" "\n;; " ; comment each line
        (replace-regexp-in-string
         "\\(\n$\\|\\|\\[m *\\|\\[[0-9][0-9]m *\\)" ""    ; remove trailing linebreak
         (shell-command-to-string fortune-prog)))))
     (t
      (concat ";; Happy hacking "
              (or user-login-name "")
              " - Emacs loves you!\n\n")))))

(setq-default initial-scratch-message (show-scratch-buffer-message))

;; A quick way to jump to the definition of a function given its key binding
(global-set-key (kbd "C-h K") 'find-function-on-key)

(with-eval-after-load 'parinfer
  (progn
    (setq parinfer-extensions
          '(defaults       ; should be included.
            pretty-parens  ; different paren styles for different modes.
            evil           ; If you use Evil.
            lispy          ; If you use Lispy. With this extension, you should install Lispy and do not enable lispy-mode directly.
            paredit        ; Introduce some paredit commands.
            smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
            smart-yank))   ; Yank behavior depend on mode.
    (add-hook 'clojure-mode-hook #'parinfer-mode)
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    (add-hook 'common-lisp-mode-hook #'parinfer-mode)
    (add-hook 'scheme-mode-hook #'parinfer-mode)
    (add-hook 'lisp-mode-hook #'parinfer-mode)))

(global-set-key (kbd "C-,") 'parinfer-toggle-mode)

;; @see https://github.com/slime/slime
(with-eval-after-load 'slime
  ;; Please install sbcl at first
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-fancy)))

;; ----------------------------------------------------------------------------
;; Enable desired features for all lisp modes
;; ----------------------------------------------------------------------------
(defun sanityinc/lisp-setup ()
  "Enable features useful in any Lisp mode."
  (parinfer-mode)
  (rainbow-delimiters-mode t)
  (turn-on-eldoc-mode))

(let* ((hooks '(lisp-mode-hook
                inferior-lisp-mode-hook
                lisp-interaction-mode-hook)))
  (dolist (hook hooks)
    (add-hook hook 'sanityinc/lisp-setup)))

(provide 'init-lisp)
