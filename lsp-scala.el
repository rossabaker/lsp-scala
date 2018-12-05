;;; lsp-scala.el --- Scala support for lsp-mode

;; Copyright (C) 2018 Ross A. Baker <ross@rossabaker.com>

;; Author: Ross A. Baker <ross@rossabaker.com>
;; Version: 0.0.1
;; Package-Requires: ((lsp-mode "3.0"))
;; Keywords: scala, lsp, metals
;; URL: https://github.com/rossabaker/lsp-scala

(require 'lsp-mode)
(require 'sbt-mode)

;;;###autoload
(defcustom lsp-scala-server-command '("metals")
  "The command to launch the language server"
  :group 'lsp-scala
  :type 'list)

(defcustom lsp-scala-workspace-root default-directory
  "The root directory of the workspace"
  :group 'lsp-scala
  :type 'directory)

(defvar lsp-scala--config-options `(:hover (:enabled t)
                                    :highlight (:enabled t)
                                    :scalac (:completions (:enabled t)
                                             :diagnostics (:enabled t))))

(defun lsp-scala--set-configuration ()
  ;; TODO is this going to irritate everything but metals?
  (lsp--set-configuration `(:metals ,lsp-scala--config-options)))

(add-hook 'lsp-after-initialize-hook 'lsp-scala--set-configuration)

(defun lsp-scala-build-import ()
  "Executes metals command build-import"
  (interactive)
  (lsp-send-execute-command "build-import" ())
  )

(defun lsp-scala-build-connect ()
  "Executes metals command build-connect"
  (interactive)
  (lsp-send-execute-command "build-connect" ())
  )

(lsp-define-stdio-client lsp-scala "scala"
                         (lambda () (sbt:find-root))
                         lsp-scala-server-command)

(featurep 'lsp
          (lsp-register-client
           (make-lsp-client :new-connection (lsp-stdio-connection lsp-scala-server-command)
                            :major-modes '(scala-mode)
                            :server-id 'scala)
           )
          )

(defun lsp-scala--run-from-root (orig &rest args)
  (let* ((client (car args))
         (lang-id (funcall (lsp--client-language-id client) (current-buffer))))
    (if (equal "scala" lang-id)
        (let ((default-directory (file-truename (funcall (lsp--client-get-root client)))))
          (apply orig args))
      (apply orig args))))
(advice-add 'lsp--start :around #'lsp-scala--run-from-root)

(provide 'lsp-scala)
;;; lsp-scala.el ends here
