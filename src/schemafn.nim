## entry schema related procedures
import json
import os # joinPath, CurDir, existsFile, walkFiles
import utils
import strutils


proc getTermListNames*(): seq[string] =
    ## get term-list names from project directory
    let tdir: string = utils.getTermListDir()
    for kind, path in walkDir(tdir):
        if ".json" in path:
            result.add(splitFile(path).name)

proc makeSchema*(fieldPairs: string): JsonNode =
    ## split matching term list with entry fields
    ## delimiter for associations is :
    ## delimiter for pairs is ;
    var schema = newJObject()
    for pairStr in fieldPairs.split(";"):
        let pair = pairStr.split(":")
        if pair[1] == "none" or pair[1] == "null" or pair[1] == "None":
            schema[pair[0]] = newJNull()
        else:
            schema[pair[0]] = newJString(pair[1])
    return schema
