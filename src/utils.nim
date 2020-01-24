## some utility functions

import os

proc getDataDir*(): string =
    ## get data directory assuming one is at the base of project
    result = joinPath($(CurDir), "data")

proc getOutDir*(): string =
    ## get out directory assuming one is at the base of project
    result = joinPath($(CurDir), "out")

proc getTermListDir*(): string =
    ## get term list directory assuming one is at the project dir
    result = joinPath(getDataDir(), "term-list")

proc getEntryListDir*(): string =
    ## get entry list directory assuming one is at the project dir
    result = joinPath(getDataDir(), "entry-list")

proc getShapeDir*(): string =
    ## get shape directory assuming one is at the project dir
    result = joinPath(getDataDir(), "shape")


proc getImageDir*(): string =
    ## get image directory assuming one is at the project dir
    result = joinPath(getDataDir(), "image")


proc getDocpartDir*(): string =
    ## get docpart directory assuming one is at the project dir
    result = joinPath(getDataDir(), "docpart")


proc getOtherDir*(): string =
    ## get other directory assuming one is at the project dir
    result = joinPath(getDataDir(), "other")

proc getMainHtmlPath*(): string =
    ## get other directory assuming one is at the project dir
    result = joinPath(getDataDir(), "main.html")
