# Package

version       = "0.1.0"
author        = "Kaan Eraslan"
description   = "Digital Edition Helper utilities for html editions"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
installExt    = @["nim"]
# bin           = @["dedutils"]



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


task alldocs, "generate all documentation separately":
    for path in walkDirRec("src", relative=false):
        if ".nim" in path:
            let file = splitFile(path)
            var doccom = "nim doc " & docOpt1 & docOpt2 & docOpt3
            echo file
            doccom = doccom & "/" & file.name & ".html "
            doccom = doccom & "./" & file.dir & "/" & file.name & ".nim"
            exec doccom
