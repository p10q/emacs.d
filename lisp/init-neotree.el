(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "R") 'neotree-change-root)
  (define-key neotree-mode-map (kbd "j") 'neotree-next-line)
  (define-key neotree-mode-map (kbd "l") 'neotree-enter)
  (define-key neotree-mode-map (kbd "h") 'neotree-select-previous-sibling-node)
  (define-key neotree-mode-map (kbd "c") 'neotree-create-node)
  (define-key neotree-mode-map (kbd "r") 'neotree-rename-node)
  (define-key neotree-mode-map (kbd "d") 'neotree-delete-node)
  (define-key neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
  (define-key neotree-mode-map (kbd "k") 'neotree-previous-line))

(setq neo-window-width 40)
(setq neo-window-fixed-size nil)
(provide 'init-neotree)
