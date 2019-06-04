;;; lsp-scala.el --- Scala support for lsp-mode  -*- lexical-binding: t -*-

;; Copyright (C) 2018 Ross A. Baker <ross@rossabaker.com>

;; Author: Ross A. Baker <ross@rossabaker.com>
;; Version: 0.0.1
;; Package-Requires: ((emacs "24.4") (lsp-mode "5.0") (sbt-mode "2.0"))
;; Keywords: languages tools scala lsp metals
;; URL: https://github.com/rossabaker/lsp-scala

;;; Commentary:

;; This package defines an lsp-mode client for Scala.

;;; Code:

(require 'lsp-mode)
(require 'sbt-mode)

;;;###autoload
(defcustom lsp-scala-server-command "metals-emacs"
  "The command to launch the Scala language server."
  :group 'lsp-scala
  :type 'file)

;;;###autoload
(defcustom lsp-scala-server-args '()
  "Extra arguments for the Scala language server."
  :group 'lsp-scala
  :type '(repeat string))

(defun lsp-scala--server-command ()
  "Generate the Scala language server startup command."
  `(,lsp-scala-server-command ,@lsp-scala-server-args))

(defvar lsp-scala--config-options `())

(defun lsp-scala-build-import ()
  "Unconditionally run `sbt bloopInstall` and re-connect to the build server."
  (interactive)
  (lsp-send-execute-command "build-import" ()))

(defun lsp-scala-build-connect ()
  "Unconditionally cancel existing build server connection and re-connect."
  (interactive)
  (lsp-send-execute-command "build-connect" ()))

(defun lsp-scala-doctor-run ()
  "Open the Metals doctor to troubleshoot potential build problems."
  (interactive)
  (lsp-send-execute-command "doctor-run" ()))

(defun lsp-scala-sources-scan ()
  "Walk all files in the workspace and index where symbols are defined."
  (interactive)
  (lsp-send-execute-command "source-scan" ()))

(lsp-register-client
 (make-lsp-client :new-connection
		  (lsp-stdio-connection 'lsp-scala--server-command)
		  :major-modes '(scala-mode)
		  :server-id 'scala
                  :initialized-fn (lambda (workspace)
                                    (with-lsp-workspace workspace
                                      (lsp--set-configuration
                                        `(:metals ,lsp-scala--config-options))))))

(provide 'lsp-scala)
;;; lsp-scala.el ends here
