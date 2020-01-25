# Package

version       = "0.1.0"
author        = "Kaan Eraslan"
description   = "Digital Edition Helper utilities for html editions"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
installExt    = @["nim"]
bin           = @["dedutils", "layout", "term", "schema"]



# Dependencies

requires "nim >= 1.0.2"

# script
import os

let url       = "https://github.com/D-K-E/dedutils"
let commit    = "bd33ce2"
let docDir = "htmldocs"
let docOpt1 = " --git.url:" & url
let docOpt2 = " --git.commit:" & commit
let docOpt3 = " -o:" & docDir



task doclayout, "generate documentation layout.nim":
    exec "nim doc " & docOpt1 & docOpt2 & docOpt3 & "/layout.html " & srcDir & "/layout.nim"

task docterm, "generate documentation term.nim":
    exec "nim doc " & docOpt1 & docOpt2 & docOpt3 & "/term.html " & srcDir &
    "/term.nim"

task docschema, "generate documentation schema.nim":
    exec "nim doc " & docOpt1 & docOpt2 & docOpt3 & "/schema.html " & srcDir &
    "/schema.nim"

task alldocs, "generate all documentation separately":
    for kind, path in walkDir("src"):
        if ".nim" in path:
            let file = splitFile(path)
            var doccom = "nim doc " & docOpt1 & docOpt2 & docOpt3
            doccom = doccom & "/" & file.name & ".html "
            doccom = doccom & srcDir & "/" & file.name & ".nim"
            exec doccom
