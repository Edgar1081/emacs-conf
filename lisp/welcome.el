(defun my/show-ascii-welcome ()
  "Display ASCII art welcome banner in a dedicated buffer."
  (let* ((ascii '(""
                  ""
                  ""
                  ""
                  ""
                  ""
                  "                                                                                        ███████╗███╗   ███╗ █████╗  ██████╗███████╗"
                  "                                                                                        ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝"
                  "                                                                                        █████╗  ██╔████╔██║███████║██║     ███████╗"
                  "                                                                                        ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║"
                  "                                                                                        ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║"
                  "                                                                                        ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝"))
         (buf (get-buffer-create "*Welcome*"))
         (width (window-width))) 
    (with-current-buffer buf
      (read-only-mode -1)
      (erase-buffer)
      (dolist (line ascii)
	(let* ((trimmed (string-trim-left line))
               (pad (max 0 (/ (- width (length trimmed)) 2)))) 
          (insert (concat (make-string pad ? ) trimmed "\n"))))
      (setq-local buffer-read-only t)
      (setq-local truncate-lines t)
      (setq-local mode-line-format nil))))

;; Resizes
(add-hook 'window-size-change-functions (lambda (_frame) (my/show-ascii-welcome)))

;; Show welcome at startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (my/show-ascii-welcome)
            (delete-other-windows)
            (switch-to-buffer "*Welcome*")))

