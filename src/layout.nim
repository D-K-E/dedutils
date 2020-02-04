## make project layout for given project
from os import existsOrCreateDir, paramCount, paramStr, existsDir, joinPath
from system import newException, OSError, set, ValueError
import unicode  # isAlpha
import streams  # newFileStream
# import io  # fmWrite

## current allowed file structure for the project
## - projectName
##   - data
##     - term-list/ # contains .json files
##     - entry-list/ # contains .json files
##     - shape/ # contains .svg files
##     - info/ # contains .json files
##     - image/ # contains .png files
##     - docpart/ # contains .html files
##     - other/ # contains .html files
##     - main.html
##   - out  # out file changes with respect to compile options
##     - doc.html
##     - doc.xhtml
##     - doc.json etc

if paramCount() == 0:
    raise newException(OSError, "Please provide a path and a project name")
elif paramCount() == 1:
    raise newException(OSError, "Please provide both a path and a project name")

let path = paramStr(1)
let name = paramStr(2)

if isAlpha(name) == false:
    raise newException(ValueError, 
        "Please provide a name consisting only alphabetic characters")

if existsDir(path) == false:
    raise newException(OSError, 
        "Path does not exist!")

proc makeProjectStructure(name: string, path: string): void =
    ## create directory structure of the project
    let projname = joinPath(path, name)
    discard existsOrCreateDir(projname)
    let datadir = joinPath(projname, "data")
    discard existsOrCreateDir(datadir)
    var subdir = joinPath(datadir, "term-list")
    discard existsOrCreateDir(subdir)
    subdir = joinPath(datadir, "shape")
    discard existsOrCreateDir(subdir)
    subdir = joinPath(datadir, "info")
    discard existsOrCreateDir(subdir)
    subdir = joinPath(datadir, "entry-list")
    discard existsOrCreateDir(subdir)
    subdir = joinPath(datadir, "image")
    discard existsOrCreateDir(subdir)
    subdir = joinPath(datadir, "docpart")
    discard existsOrCreateDir(subdir)
    subdir = joinPath(datadir, "other")
    discard existsOrCreateDir(subdir)
    var subfile = joinPath(datadir, "main.html")
    var mainstrm = newFileStream(subfile, fmWrite)
    mainstrm.write("")
    mainstrm.close()
    subdir = joinPath(projname, "out")
    discard existsOrCreateDir(subdir)
    return

makeProjectStructure(name, path)

echo("Created project structure at: " & joinPath(path, name))
