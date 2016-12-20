;; Used Guess to match to clang format
;; M-x c-guess-no-install and then M-x c-guess-view
(c-add-style "Charles"
             '("gnu"
               (c-basic-offset . 4)
               (c-offsets-alist
                (arglist-cont . 0)
                (arglist-intro . +)
                (block-close . 0)
                (brace-list-intro . ++)
                (defun-block-intro . +)
                (defun-close . 0)
                (innamespace . 0)
                (namespace-close . 0)
                (statement . 0)
                (statement-block-intro . +)
                (statement-cont . +)
                (stream-op . 0)
                (topmost-intro . 0)
                (topmost-intro-cont . 0)
                (access-label . -)
                (annotation-top-cont . 0)
                (annotation-var-cont . +)
                (arglist-close . c-lineup-close-paren)
                (arglist-cont-nonempty . c-lineup-arglist)
                (block-open . 0)
                (brace-entry-open . 0)
                (brace-list-close . 0)
                (brace-list-entry . c-lineup-under-anchor)
                (brace-list-open . +)
                (c . c-lineup-C-comments)
                (case-label . 0)
                (catch-clause . 0)
                (class-close . 0)
                (class-open . 0)
                (comment-intro . c-lineup-comment)
                (composition-close . 0)
                (composition-open . 0)
                (cpp-define-intro c-lineup-cpp-define +)
                (cpp-macro . -1000)
                (cpp-macro-cont . +)
                (defun-open . 0)
                (do-while-closure . 0)
                (else-clause . 0)
                (extern-lang-close . 0)
                (extern-lang-open . 0)
                (friend . 0)
                (func-decl-cont . +)
                (inclass . +)
                (incomposition . +)
                (inexpr-class . +)
                (inexpr-statement . +)
                (inextern-lang . +)
                (inher-cont . c-lineup-multi-inher)
                (inher-intro . +)
                ;; (inlambda . c-lineup-inexpr-block)
                (inlambda . 0)
                (inline-close . 0)
                (inline-open . 0)
                (inmodule . +)
                (knr-argdecl . 0)
                (knr-argdecl-intro . 5)
                (label . 0)
                (lambda-intro-cont . +)
                (member-init-cont . c-lineup-multi-inher)
                (member-init-intro . +)
                (module-close . 0)
                (module-open . 0)
                (namespace-open . 0)
                (objc-method-args-cont . c-lineup-ObjC-method-args)
                (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
                (objc-method-intro .
                                   [0])
                (statement-case-intro . +)
                (statement-case-open . +)
                (string . -1000)
                (substatement . +)
                (substatement-label . 0)
                (substatement-open . +)
                (template-args-cont c-lineup-template-args +))))

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style "Charles") "linux" ;; set style to "linux"
(custom-set-variables '(c-noise-macro-names '("constexpr")))
;;(use-package cc-mode
;;  :init
;;  (define-key c-mode-map  [(tab)] 'company-complete)
;;  (define-key c++-mode-map  [(tab)] 'company-complete))

(provide 'setup-c)
