# lsp-scala

[![Join the chat at https://gitter.im/rossabaker/lsp-scala](https://badges.gitter.im/rossabaker/lsp-scala.svg)](https://gitter.im/rossabaker/lsp-scala?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Scala support for [lsp-mode], mainly focus on [metals].

## Installation

Installation instructions with [metals] are available here: https://scalameta.org/metals/docs/editors/emacs.html

#### Other Scala language servers

Other Scala language servers should work in theory.  The easiest way,
if your server launches from the command line, is to customize
`lsp-scala-server-command` and `lsp-scala-server-args`.

## Does it work?

metals describes itself as "work in progress".  Temper your expectations, cheer them on, and [help if you can](https://github.com/scalameta/metals/blob/master/CONTRIBUTING.md).  Though many lsp-mode features are not yet implemented, those that are appear to be working well.  Kudos to the metals team.

Some of this is too nuanced to fit in a boolean.  Some of this may be me my misunderstanding.  More user experience reports welcome.

### lsp-mode

* [x] `lsp-capabilities`
* [x] `lsp-describe-thing-at-point`
* [ ] `lsp-document-highlight`: `Capability not supported by the language server: "documentHighlightProvider"`
* [ ] `lsp-execute-code-action`: I don't know what this does
* [x] `lsp-format-buffer`
* [x] `lsp-goto-implementation`
* [ ] `lsp-goto-type-definition`
* [x] `lsp-hover`
* [ ] `lsp-rename`: `Capability not supported by the language server: "renameProvider"`
* [x] `lsp-restart-workspace`
* [ ] `lsp-signature-help`: `Capability not supported by the language server: "signatureHelpProvider"`
* [ ] `lsp-workspace-folders-add`: `Capability not supported by the language server: "workspaceFolders"`
* [ ] `lsp-workspace-folders-remove`: `Capability not supported by the language server: "workspaceFolders"`
* [ ] `lsp-workspace-folders-switch`: `Capability not supported by the language server: "workspaceFolders"`

### `lsp-ui`

* [x] `lsp-ui-flycheck`: compiles on save, renders errors inline
* [x] `lsp-ui-doc`
* [ ] `lsp-ui-imenu`
* [ ] `lsp-ui-peek`
* [ ] `lsp-ui-sideline-enable`

### `xref`

* [x] `xref-find-definition`: finds definitions of symbols and types

[lsp-mode]: https://github.com/emacs-lsp/lsp-mode
[metals]: https://github.com/scalameta/metals
[Coursier]: https://github.com/coursier/coursier
