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
