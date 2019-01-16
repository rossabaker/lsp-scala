# lsp-scala

Scala support for [lsp-mode].

## Installation

You must install the Emacs plugin (this) and a language server

### lsp-scala

Clone this repo, and fetch `lsp-mode`, `lsp-ui`, and `sbt-mode` from
MELPA with the package manager of your choice.  (We are working on
adding this package to MELPA to make `lsp-scala` load like the rest.)

This package no longer works with the "legacy lsp-mode" currently in
MELPA stable.  Be sure to use unpin from stable when installing
`lsp-mode` and `lsp-ui`.

Here is an example using `use-package`:

```emacs-lisp
(use-package lsp-mode
  :ensure t)

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-scala
  :load-path "~/path/to/lsp-scala"
  :after scala-mode
  :demand t
  :hook (scala-mode . lsp)
  :init (setq lsp-scala-server-command "~/bin/metals-emacs"))

(use-package sbt-mode
  :ensure t
  :commands sbt-start sbt-command)
```

### Language server

#### Metals

Build a `metals-emacs` binary using the [Coursier] command line interface.

```sh
curl -L -o coursier https://git.io/coursier
METALS_VERSION=0.3.3
chmod +x coursier
./coursier bootstrap \
  --java-opt -XX:+UseG1GC \
  --java-opt -XX:+UseStringDeduplication  \
  --java-opt -Xss4m \
  --java-opt -Xms1G \
  --java-opt -Xmx4G  \
  --java-opt -Dmetals.client=emacs \
  org.scalameta:metals_2.12:${METALS_VERSION} \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-emacs -f
```

Put the resulting `metals-emacs` binary on your path.

#### Other Scala language servers

Other Scala language servers should work in theory.  The easiest way,
if your server launches from the command line, is to customize
`lsp-scala-server-command` and `lsp-scala-server-args`.

## Import a project

### SBT

Open a `*.scala` file in your project and run `M-x lsp`.

You will be prompted:

```
sbt build detected, would you like to import via Bloop? You don't need Bloop installed on your machine to run this step.

Don't show again
Import build via Bloop
```

Choose `Import build via Bloop`.  This will run `sbt bloopInstall`.  If all goes well, you will eventuall y get a message like:

```
time: imported workspace in 2.22s
```

If all didn't go well, check the `.metals/metals.log` file.

## Automatically enable lsp-scala

If you want `lsp-scala` to load for every scala file, add this:

```emacs-lisp
(add-hook 'scala-mode-hook #'lsp)
```

## MELPA stable

If you pin `lsp-mode` to MELPA stable, invoke the server with
`lsp-scala-enable` rather than `lsp`.

## Does it work?

metals describes itself as "work in progress".  Temper your expectations, cheer them on, and [help if you can](https://github.com/scalameta/metals/blob/master/CONTRIBUTING.md).  Though many lsp-mode features are not yet implemented, those that are appear to be working well.  Kudos to the metals team.

Some of this is too nuanced to fit in a boolean.  Some of this may be me my misunderstanding.  More user experience reports welcome.

### lsp-mode

* [x] `lsp-capabilities`
* [ ] `lsp-describe-thing-at-point`: `Wrong type argument: hash-table-p, nil`
* [ ] `lsp-document-highlight`: `Capability not supported by the language server: "documentHighlightProvider"`
* [ ] `lsp-execute-code-action`: I don't know what this does
* [ ] `lsp-format-buffer`: `Capability not supported by the language server: "documentFormattingProvider"`
* [ ] `lsp-goto-implementation`: `Capability not supported by the language server: "implementationProvider"`, but see `xref-find-definitions`
* [ ] `lsp-goto-type-definition`: `Capability not supported by the language server: "typeDefinitionProvider"`, but see `xref-find-definitions`
* [ ] `lsp-hover`: `textDocument/hover is not supported`
* [ ] `lsp-rename`: `Capability not supported by the language server: "renameProvider"`
* [x] `lsp-restart-workspace`
* [ ] `lsp-signature-help`: `Capability not supported by the language server: "signatureHelpProvider"`
* [ ] `lsp-workspace-folders-add`: `Capability not supported by the language server: "workspaceFolders"`
* [ ] `lsp-workspace-folders-remove`: `Capability not supported by the language server: "workspaceFolders"`
* [ ] `lsp-workspace-folders-switch`: `Capability not supported by the language server: "workspaceFolders"`

### `lsp-ui`

* [x] `lsp-ui-flycheck`: compiles on save, renders errors inline
* [ ] `lsp-ui-doc`
* [ ] `lsp-ui-imenu`
* [ ] `lsp-ui-peek`
* [ ] `lsp-ui-sideline-enable`

### `xref`

* [x] `xref-find-definition`: finds definitions of symbols and types

[lsp-mode]: https://github.com/emacs-lsp/lsp-mode
[metals]: https://github.com/scalameta/metals
[Coursier]: https://github.com/coursier/coursier
