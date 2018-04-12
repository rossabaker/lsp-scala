# lsp-scala

Scala support for [lsp-mode].

## Metals

By default, `lsp-scala` launches [metals].

## Installation

You must install the Emacs plugin (this), the server, and an sbt plugin.

### Emacs

Install the `lsp-mode` and `sbt-mode` dependencies using your preferred package manager.

Then clone this repo and load it:

```emacs-lisp
(add-to-list 'load-path "<path to lsp-java>")
(require 'lsp-scala)
```

### Metals Server Installation

Download (`start-server.sh`)[https://github.com/scalameta/metals/blob/master/bin/start-server.sh], renamed to `metals` on your `$PATH`, or customise `lsp-scala-server-command`.

You must tell emacs which version of the server to use by setting this variable

```emacs-lisp
(setq lsp-scala-server-command '("metals" "<version>"))
```

using the same version in `<version>` to match the sbt plugin. You could set an environment variable and share it between emacs and sbt.

### SBT Integration

Follow the [metals instructions](https://github.com/scalameta/metals/blob/master/docs/installation.md) to install the `MetalsPlugin`.  Ignore the instructions for installing vscode.

Continue to follow the per-project setup to produce the build metadata, i.e. enabling the scalac semanticdb compiler plugin. You may not need to perform this step if you are running a recent version of scalafix.

Run the sbt task `metalsSetup` and open a scala file.

If you have ENSIME installed, avoid potential conflicts by running `M-x ensime-mode` to disable it for the buffer.

Start the metals server with `M-x lsp-scala-enable`.

If you want `lsp-scala` to load for every scala file, add this

```emacs-lisp
(add-hook scala-mode-hook #'lsp-scala-enable)
```

The buffer will hang briefly (30 seconds, worse on slow networks).  If all is well, you should see text appear in your minibuffer indicating that the server has started and you can issue `M-x lsp-info-under-point` to see the inferred type at point.

### Does it work?

metals describes itself as "very alpha stage".  Temper your expectations, cheer them on, and [help if you can](https://github.com/scalameta/metals/blob/master/CONTRIBUTING.md).

Some of this is too nuanced to fit in a boolean.  Some of this may be me my misunderstanding.  More user experience reports welcome.

* [x] `company-lsp`: names, but no help on params yet
* [x] `lsp-capabilities`
* [ ] `lsp-execute-code-action`: I don't know what this does
* [ ] `lsp-format-buffer`: slow, doesn't seem to do anything
* [ ] `lsp-goto-implementation`: `implementationProvider` capability not yet supported by LS
* [ ] `lsp-goto-type-definition`: `typeDefinitionProvider` capability not yet supported by LS
* [x] `lsp-info-under-point`
* [x] `lsp-rename`: works on local variables. Global not implemented yet.
* [x] `lsp-restart-workspace`
* [x] `lsp-symbol-highlight`
* [ ] `lsp-ui-doc`: no errors, but not seeing any docs
* [x] `lsp-ui-imenu`
* [x] `lsp-ui-sideline`
* [x] `lsp-ui-peek`: is finding definition and references. Oddly, `lsp-got-type-definition` doesn't.

[lsp-mode]: https://github.com/emacs-lsp/lsp-mode
[metals]: https://github.com/scalameta/metals

## Other language servers

Other Scala language servers should work in theory.  The easiest way, if your server launches from the command line, is to customize `lsp-scala-server-command`.
