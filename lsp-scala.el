;;; lsp-scala.el --- Scala support for lsp-mode

;; Copyright (C) 2018 Ross A. Baker <ross@rossabaker.com>

;; Author: Ross A. Baker <ross@rossabaker.com>
;; Version: 0.0.1
;; Package-Requires: ((lsp-mode "3.0"))
;; Keywords: scala, lsp, metals
;; URL: https://github.com/rossabaker/lsp-scala

(require 'lsp-mode)

;;;###autoload
(defcustom lsp-scala-metals-command '("coursier" "launch"
                                      "-r" "bintray:scalameta/maven"
                                      "org.scalameta:metals_2.12:0.1-SNAPSHOT"
                                      "-M" "scala.meta.metals.Main")
  "The command to launch metals"
  :group 'lsp-scala
  :type 'list)

(defcustom lsp-scala-workspace-root default-directory
  "The root directory of the workspace"
  :group 'lsp-scala
  :type 'directory)

(lsp-define-stdio-client lsp-scala "scala"
                         (lambda () lsp-scala-workspace-root)
                         lsp-scala-metals-command)

(provide 'lsp-scala)
;;; lsp-scala.el ends here
