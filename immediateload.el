;; mostly from ESK by technomancy

;; Deprecated, we'll just put it in the head of init.el

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;; Require common stuff
(require 'cl)
(require 'uniquify)
(require 'ansi-color)
(require 'saveplace)
(require 'paredit)

(provide 'immediateload)
