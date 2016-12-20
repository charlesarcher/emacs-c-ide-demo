(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "/home/archerc/.emacs.d/custom")
(add-to-list 'load-path "/home/archerc/tools/x86/share/emacs/site-lisp/")

(require 'setup-general)
(require 'setup-helm)
(require 'sr-speedbar)
(require 'magit)
(require 'setup-c)
(require 'setup-editing)
(require 'setup-org)
(require 'setup-charles)
(require 'setup-rtags)

;;(require 'setup-ivy-counsel)
;;(require 'setup-ggtags)
;;(require 'setup-helm-gtags)
;;(require 'setup-cedet)


;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(company-show-numbers t)
 '(grep-use-null-device nil)
 '(grep-use-null-filename-separator nil)
 '(package-selected-packages
   (quote
    (color-theme-solarized solarized-theme color-theme-sanityinc-solarized sr-speedbar zygospore helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clang-format clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(company-preview-common ((t (:background "brightred"))))
 ;;'(company-scrollbar-bg ((t (:background "magenta"))))
 '(highlight ((t (:background "cyan"))))
 '(linum ((t (:background "yellow" :foreground "gray20" :inverse-video t :underline nil))))
 '(secondary-selection ((t (:inherit helm-selection))))
 '(tool-bar ((t (:foreground "color-34" :box (:line-width 1 :style released-button))))))
(put 'downcase-region 'disabled nil)

;; (cmake-ide-setup)
(require 'ansi-color)
(defun my/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)
(setq split-height-threshold 1200)
(setq split-width-threshold 2000)






;;;;;;;;;;;;;;;;;;;; FIND ME A HOME
;; only highlight the current diff:
;; (setq-default ediff-highlight-all-diffs 'nil)

(dolist (entry '((ediff-current-diff-C . ((((class color) (background light))
                                           (:background "#DDEEFF" :foreground "#005588"))
                                          (((class color) (background dark))
                                           (:background "#005588" :foreground "#DDEEFF"))))
                 (ediff-fine-diff-C . ((((class color) (background light))
                                        (:background "#EEFFFF" :foreground "#006699"))
                                       (((class color) (background dark))
                                        (:background "#006699" :foreground "#EEFFFF"))))))
  (let ((face (car entry))
        (spec (cdr entry)))
    (put face 'theme-face nil)
    (face-spec-set face spec)))

(dolist (face-map '((diff-hl-insert              . magit-diff-added)
                    (diff-hl-change              . ediff-current-diff-C)
                    (diff-hl-delete              . magit-diff-removed)
                    (smerge-base                 . magit-diff-base)
                    (smerge-lower                . magit-diff-added)
                    (smerge-markers              . magit-diff-conflict-heading)
                    (smerge-refined-added        . magit-diff-added-highlight)
                    (smerge-refined-removed      . magit-diff-removed-highlight)
                    (smerge-upper                . magit-diff-removed)
                    (ediff-even-diff-A           . magit-diff-context-highlight)
                    (ediff-even-diff-Ancestor    . magit-diff-context)
                    (ediff-even-diff-B           . magit-diff-context-highlight)
                    (ediff-even-diff-C           . magit-diff-context-highlight)
                    (ediff-odd-diff-A            . magit-diff-context-highlight)
                    (ediff-odd-diff-Ancestor     . magit-diff-context)
                    (ediff-odd-diff-B            . magit-diff-context-highlight)
                    (ediff-odd-diff-C            . magit-diff-context-highlight)
                    (ediff-current-diff-A        . magit-diff-our)
                    (ediff-current-diff-Ancestor . magit-diff-base)
                    (ediff-current-diff-B        . magit-diff-their)
                    (ediff-fine-diff-A           . magit-diff-removed-highlight)
                    (ediff-fine-diff-Ancestor    . magit-diff-base-highlight)
                    (ediff-fine-diff-B           . magit-diff-added-highlight)
                    (diff-header                 . magit-diff-hunk-heading)
                    (diff-context                . magit-diff-context)
                    (diff-added                  . magit-diff-added)
                    (diff-removed                . magit-diff-removed)
                    (diff-changed                . smerge-refined-changed)
                    (diff-refine-added           . magit-diff-added-highlight)
                    (diff-refine-removed         . magit-diff-removed-highlight)
                    (diff-refine-changed         . ediff-fine-diff-C)
                    (diff-indicator-added        . magit-diffstat-added)
                    (diff-indicator-removed      . magit-diffstat-removed)))
  (let* ((face (car face-map))
         (alias (cdr face-map)))
    (put face 'theme-face nil)
    (put face 'face-alias alias)))
