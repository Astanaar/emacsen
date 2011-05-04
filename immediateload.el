;; mostly from ESK by technomancy

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Add all files in this buffer's directory to the load-path
(normal-top-level-add-subdirs-to-load-path)

;;; Require common stuff
(require 'cl)
(require 'uniquify)
(require 'ansi-color)
(require 'saveplace)
(require 'paredit)

(provide 'immediateload)