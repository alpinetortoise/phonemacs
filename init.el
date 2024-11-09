(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f079ef5189f9738cf5a2b4507bcaf83138ad22d9c9e32a537d61c9aae25502ef"
     default))
 '(package-selected-packages '(## org-bullets org-fragtog org-modern org-roam)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(load-theme 'zenburn t)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(visual-line-mode)

(set-face-attribute
 'default nil
 ;;:font "Droid Sans Mono"
 :height 190)

(use-package counsel)
(ivy-mode 1)

(setq epg-gpg-program "gpg")
(setenv "GPG_AGENT_INFO" nil)
(require 'epa-file)
(epa-file-enable)
(setq org-roam-link-extensions '(".org" ".org.gpg"))

(setq org-directory "~/Brain_2/")
(setq org-agenda-files (list "inbox.org"))

(define-key global-map (kbd "C-c c") 'org-capture)
(setq org-capture-templates
  `(("i" "Inbox" entry (file "inbox.org")
    ,(concat "* TODO %?\n"
             "%a\n"
             "/Entered on/ %U"))))

(use-package org-modern
  :hook
  (org-mode . global-org-modern-mode)
  :custom
  (org-modern-star 'replace)
  (org-modern-replace-stars "§¤•·–")
  (org-modern-keyword nil)
  (org-modern-checkbox nil)
  ;(org-modern-table nil)
  )

(use-package org-fragtog
  :after org
  :custom
  (org-startup-with-latex-preview t)
  :hook
  (org-mode . org-fragtog-mode)
  :custom
  (org-format-latex-options
   (plist-put org-format-latex-options :scale 2)
   (plist-put org-format-latex-options :foreground 'auto)
   (plist-put org-format-latex-options :background 'auto)))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Brain_2")
  (org-roam-dailies-directory "~/Brain_2/00-09 System/03 Dailies/")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%I:%M %p>: %?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c z l" . org-roam-buffer-toggle)
         ("C-c z f" . org-roam-node-find)
         ("C-c z i" . org-roam-node-insert):map org-mode-map
         :map org-mode-map
         ("C-M-i"    . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c z d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))

(setq org-roam-capture-templates
    '(("z" "Zettel" plain
       "%?"
       :if-new
       (file+head "Z.0000 Zettelkasten/${slug}.org"
        "#+title: ${title}
        #+created: %U
        #+last_modified: %U\n\n")
       :immediate-finish t
       :unnarrowed t)
      ("r" "reference" plain
       "%?"
       :if-new
       (file+head "00-09 System/01 Reference/${title}.org"
                  "#+title: ${title}
                  #+created: %U
                  #+last_modified: %U\n\n")
       :immediate-finish t
       :unnarrowed t)
      ("b" "blog" plain             ;;                (article)
       "%?"
       :if-new
       (file+head "Website/${title}.org"
                 "#+HUGO_BASE_DIR: ~/alpineTortoise
                 #+HUGO_SECTION: ./posts
                 #+HUGO_AUTO_SET_LASTMOD: t
                 #+TITLE: ${title}
                 #+DATE: %U
                 #+HUGO_TAGS: article
                 #+HUGO_DRAFT: true\n")
       :immediate-finish t
       :unnarrowed t)))
