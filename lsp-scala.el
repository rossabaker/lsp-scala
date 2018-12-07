;;; lsp-scala.el --- Scala support for lsp-mode  -*- lexical-binding: t -*-

;; Copyright (C) 2018 Ross A. Baker <ross@rossabaker.com>

;; Author: Ross A. Baker <ross@rossabaker.com>
;; Version: 0.0.1
;; Package-Requires: ((lsp-mode "3.0"))
;; Keywords: scala, lsp, metals
;; URL: https://github.com/rossabaker/lsp-scala

;;; Commentary

;; This package defines an lsp-mode client for Scala.

;;; Code:

(require 'lsp-mode)
(require 'sbt-mode)

;;;###autoload
(defcustom lsp-scala-server-command '("metals-emacs")
  "The command to launch the language server,"
  :group 'lsp-scala
  :type 'list)

(defcustom lsp-scala-workspace-root default-directory
  "The root directory of the workspace,"
  :group 'lsp-scala
  :type 'directory)

(defvar lsp-scala--config-options `(:hover (:enabled t)
                                    :highlight (:enabled t)
                                    :scalac (:completions (:enabled t)
                                             :diagnostics (:enabled t))))

;; is this going to irritate everything but metals?
(defun lsp-scala--set-configuration ()
  "Set the configuration for the Scala LSP server."
  (lsp--set-configuration `(:metals ,lsp-scala--config-options)))

(add-hook 'lsp-after-initialize-hook 'lsp-scala--set-configuration)

(defun lsp-scala-build-import ()
  "Execute metals command build-import."
  (interactive)
  (lsp-send-execute-command "build-import" ())
  )

(defun lsp-scala-build-connect ()
  "Execute metals command build-connect."
  (interactive)
  (lsp-send-execute-command "build-connect" ())
  )

(lsp-define-stdio-client lsp-scala "scala"
                         (lambda () (sbt:find-root))
                         lsp-scala-server-command)

(provide 'lsp-scala)
;;; lsp-scala.el ends here
