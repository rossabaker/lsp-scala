# lsp-scala

Scala support for [lsp-mode].

## Metals

By default, `lsp-scala` launches [metals].

### Installation

Clone this repo and add:

```emacs-lisp
(add-to-list 'load-path "<path to lsp-java>")
(require 'lsp-scala)
(add-hook scala-mode-hook #'lsp-scala-enable)
```

Customize `lsp-scala-metals-command` to however you start metals.  I am using (start-server.sh)[https://github.com/scalameta/metals/blob/master/bin/start-server.sh], renamed to `metals` in my `$PATH`.  After release, the default value will be expressed in terms of a coursier command.

Follow the [metals instructions](https://github.com/scalameta/metals/blob/master/BETA.md) to install the `MetalsPlugin`.  You don't need the VSCode extension, nor is it required to publish the server locally.

### Usage

Follow the [metals instructions](https://github.com/scalameta/metals/blob/master/BETA.md) per-project setup through producing the build metadata.  Instead of launching `code`, load your file in emacs.  The first Scala file you visit will hang briefly.  If all is well, you should see something like this in `*Messages*`

```
22:43:27.928 INFO  s.m.m.MetalsServices - Client is initialized
```

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
