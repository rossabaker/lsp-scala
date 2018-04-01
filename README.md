# lsp-scala

Scala support for [lsp-mode] using [metals]

## Usage

Follow the [metals instructions](https://github.com/scalameta/metals/blob/master/BETA.md) to install the `MetalsPlugin` and the per-project setup through producing the build metadata.  You don't need to build the VSCode extension or publish the server locally.

Instead of launching `code`, load your file in emacs.  Run `lsp-scala-enable` to start the server.

## Does it work?

metals describes itself as "very alpha stage".  Temper your expectations, cheer them on, and [help if you can](https://github.com/scalameta/metals/blob/master/CONTRIBUTING.md).

Some of this is too nuanced to fit in a boolean.  Some of this may be me my misunderstanding.  More user experience reports welcome.

* [ ] `company-lsp`: cannot complete at point
* [X] `lsp-capabilities`: promises more than it delivers, but the call works
* [ ] `lsp-execute-code-action`: I don't know what this does
* [ ] `lsp-format-buffer`: slow, doesn't seem to do anything
* [ ] `lsp-goto-implementation`: `implementationProvider` capability not yet supported by LS
* [ ] `lsp-goto-type-definition`: `typeDefinitionProvider` capability not yet supported by LS
* [ ] `lsp-info-under-point`: does nothing
* [ ] `lsp-rename`: think I saw this work once, can't reproduce)
* [X] `lsp-restart-workspace`
* [ ] `lsp-symbol-highlight`: does nothing
* [ ] `lsp-ui-doc`: mode does nothing
* [X] `lsp-ui-imenu`
* [ ] `lsp-ui-sideline`: does nothing
* [ ] `lsp-ui-peek`: does nothing

[lsp-mode]: https://github.com/emacs-lsp/lsp-mode
[metals]: https://github.com/scalameta/metals
