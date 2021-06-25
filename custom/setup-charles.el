(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)
(setq compilation-scroll-output t)
(setq compile-command "/usr/bin/time bash -c \"make -j32 && rc -J .\"")
(setq grep-command "git --no-pager grep -n -e")
(require 'linum)
(global-font-lock-mode 1)
;; (global-linum-mode 1)
;; (add-hook 'find-file-hook (lambda () (linum-mode 1)))
;; (setq linum-format "%4d |")
;; (setq linum-format "%4d \u2502")
;;'(linum ((t (:background "yellow" :foreground "gray20" :inverse-video t :underline nil))))
(display-line-numbers-mode t)
;;(setq display-line-numbers "%4d |")
(add-hook 'find-file-hook (lambda () (display-line-numbers-mode 1)))
;;'(line-number ((t (:background "yellow" :foreground "gray20" :inverse-video t :underline nil))))

(column-number-mode 1)

(defun yic-ignore (str)
  (or
   ;;buffers I don't want to switch to
   (string-match "\\*Buffer List\\*" str)
   (string-match "^TAGS" str)
   (string-match "^\\*Messages\\*$" str)
   (string-match "^\\*SPEEDBAR\\*$" str)
   (string-match "^\\*scratch\\*$" str)
   (string-match "^\\*Completions\\*$" str)
   (string-match "^\\*clang-output\\*$" str)
   (string-match "^\\*clang-error\\*$" str)
   (string-match "^\\*cmake\\*$" str)
   (string-match "^\\*vc\\*$" str)
   (string-match "^\\*RTags Log\\*$" str)
   (string-match-p "^\\*helm.*\\*$" str)
   (string-match-p "^\\*magit-.*$" str)
   (string-match "^ " str)
   ;;Test to see if the window is visible on an existing visible frame.
   ;;Because I can always ALT-TAB to that visible frame, I never want to
   ;;Ctrl-TAB to that buffer in the current frame.  That would cause
   ;;a duplicate top-level buffer inside two frames.
   (memq str
         (mapcar
          (lambda (x)
            (buffer-name
             (window-buffer
              (frame-selected-window x))))
          (visible-frame-list)))
   ))

(defun yic-next (ls)
  "Switch to next buffer in ls skipping unwanted ones."
  (let* ((ptr ls)
         bf bn go
         )
    (while (and ptr (null go))
      (setq bf (car ptr)  bn (buffer-name bf))
      (if (null (yic-ignore bn))	;skip over
          (setq go bf)
        (setq ptr (cdr ptr))
        )
      )
    (if go
        (switch-to-buffer go))))

(defun yic-prev-buffer ()
  "Switch to previous buffer in current window."
  (interactive)
  (yic-next (reverse (buffer-list))))

(defun yic-next-buffer ()
  "Switch to the other buffer (2nd in list-buffer) in current window."
  (interactive)
  (bury-buffer (current-buffer))
  (yic-next (buffer-list)))
;;end of yic buffer-switching methods

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
                (t (self-insert-command (or arg 1)))))
(defun intelligent-close ()
  "quit a frame the same way no matter what kind of frame you are on"
  (interactive)
  (if (eq (car (visible-frame-list)) (selected-frame))
      ;;for parent/master frame...
      (if (> (length (visible-frame-list)) 1)
          ;;close a parent with children present
          (delete-frame (selected-frame))
        ;;close a parent with no children present
        (save-buffers-kill-emacs))
    ;;close a child frame
    (delete-frame (selected-frame))))

;; Stuff
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [\C-home] 'beginning-of-buffer)
(global-set-key [\C-end] 'end-of-buffer)
(global-set-key [\S-tab] 'indent-region)
(global-set-key [?\C-/] 'void) ;forward reference
(global-set-key [\C-backspace] 'backward-kill-word)
(global-set-key "\C-o" 'undo-tree-undo)
(global-set-key "\C-p" 'undo-tree-redo)
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\C-\M-s" 'tags-search)
(global-set-key "\C-x\C-n" 'find-file-other-frame) ;open new frame with a file
(global-set-key "\C-x\C-c" 'intelligent-close) ;forward reference
(global-set-key "\C-x55" 'split-window-fork) ;forward reference
(global-set-key "\M-n" 'scroll-n-lines-ahead) ;forward reference
(global-set-key "\M-p" 'scroll-n-lines-behind) ;forward reference
(global-set-key "\M-u" 'void) ;don't bind upcase word
(global-set-key "\M-l" 'void) ;don't bind downcase word
(global-set-key "\C-c\C-c" 'comment-region) ;have to force it for some reason
(global-set-key "\C-xw" 'what-line)
(global-set-key (kbd "C-x p") (lambda()(interactive)(other-window -1)))
;;(global-set-key [delete] 'delete-char)
(global-set-key [backspace] 'delete-backward-char)
(global-set-key [f1] 'yic-next-buffer) ;forward reference
(global-set-key [f2] 'yic-prev-buffer) ;forward reference
(global-set-key [f3] 'sr-speedbar-toggle)
(global-set-key [f4] 'rtags-find-symbol-at-point)
(global-set-key [f5] 'query-replace)
(global-set-key [f6] 'isearch-forward)
(global-set-key [f7] 'isearch-backward)
(global-set-key [f8] 'display-line-numbers-mode)
(global-set-key [f9] 'magit-status)

(global-set-key [(shift f3)]  'ggtags-find-other-symbol)
(global-set-key [(shift f4)]  'ggtags-view-tag-history)
(global-set-key [(shift f5)]  'ggtags-find-reference)
(global-set-key [(shift f6)]  'ggtags-find-definition)
(global-set-key [(shift f7)]  'ggtags-create-tags)
(global-set-key [(shift f8)]  'git-gutter:toggle)
(global-set-key [(shift f9)]  'pop-tag-mark)
(global-set-key (kbd "C-<f6>")  'rtags-find-symbol-at-point)
(global-set-key (kbd "C-<f9>")  'recompile)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-xg" 'goto-line)
(global-set-key "%" 'match-paren)

;; Don't let magit take away my precious goto key
;; with-eval-after-load 'magit-mode
;;  (define-key magit-file-mode-map (kbd "\C-xg") nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ediff and magit                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ediff)
;; don't start another frame
;; this is done by default in preluse
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; put windows side by side
(setq ediff-split-window-function (quote split-window-horizontally))
;;revert windows on exit - needs winner mode
(winner-mode)

(setq-default ediff-forward-word-function 'forward-char)

(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
(setq magit-ediff-dwim-show-on-hunks t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ediff and magit                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'setup-charles)
