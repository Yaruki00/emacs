;;
;; PATH
;;__________________________________________________

(add-to-list 'exec-path (expand-file-name "/opt/local/bin/dmd"))

;;
;; Window setting
;;__________________________________________________

(if window-system                   ; x上で動いていたら
    (progn                          ; 逐次実行後、最後のフォームの結果を返す
      (tool-bar-mode 0)             ; ツールバー非表示
      (set-scroll-bar-mode nil)     ; スクロールバー非表示
      (menu-bar-mode -1)            ; メニューバー非表示
      (setq ns-pop-up-frames nil))) ; emacsを複数開かない

;;
;; encoding
;;__________________________________________________

; 言語を日本語にする
(set-language-environment 'Japanese)

; とりあえずUTF-8使っとけ
(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system  'utf-8)
(set-terminal-coding-system     'utf-8)
(set-keyboard-coding-system     'utf-8)
(set-clipboard-coding-system    'utf-8)

;;
;; Others
;;__________________________________________________

; 行番号をデフォルトで表示
(global-linum-mode 1)

; 対応する括弧を光らせる。
(show-paren-mode 1)

; スタートアップ非表示
(setq inhibit-startup-screen t)

; scratchの初期メッセージ消去
(setq initial-scratch-message "")

; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f" (system-name)))

; 初期フレームの設定
(setq initial-frame-alist
      (append
       '((width		.	80)   ; フレーム幅(文字数)
	 (height	.	60)   ; フレーム高(文字数)
	 (top		.	0)    ; 表示位置
	 (left		.	855)  ; 表示位置
	 (foreground-color . "white")
	 (background-color . "black")
	 (border-color     . "white")
	 (mouse-color      . "black")
	 (cursor-color     . "gray"))
       initial-frame-alist))

;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

;;
;; ido-mode
;;___________________________________________________
(ido-mode t)
(require 'ido)


;;
;; package.el
;;___________________________________________________
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
  '("gnu" . "http://elpa.gnu.org/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)

;;
;; auto-complete
;;___________________________________________________
(require 'auto-complete)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'd-mode) ;; d-modeで有効
(setq ac-use-menu-map t)        ;; 補完メニュー表示時にC-n/C-pで補完候補選択

;;
;; popwin
;;___________________________________________________
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;;
;; flycheck
;;___________________________________________________
(add-hook 'after-init-hook #'global-flycheck-mode)

;;
;; D lang
;;___________________________________________________
(require 'd-mode)
(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(setq auto-mode-alist (cons
  '("\\.d$" . d-mode) auto-mode-alist))

;; d expansion
(add-hook 'd-mode-hook
          '(lambda ()
	     (c-set-style "bsd")
	     (setq c-basic-offset 2)
	     (setq indent-tabs-mode nil)
	     (setq tab-width 2)
	     (local-set-key (kbd "C-c C-p") 'flycheck-previous-error)
	     (local-set-key (kbd "C-c C-n") 'flycheck-next-error)
	  ))

;; flycheck-d-unittest
(setup-flycheck-d-unittest)

;;
;; haskell
;;___________________________________________________
(require 'haskell-mode)
(setq auto-mode-alist (cons
  '("\\.hs$" . haskell-mode) auto-mode-alist))
