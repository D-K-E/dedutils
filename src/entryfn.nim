## entry-list functions
import json # parseFile
import os
import utils # getSchemaPath
import termfn # getTermList

##
## Entry Structure
## ---------------
##
## The entry structure should be of the following
##
## .. code-block:: json
##
##     {"id": "entry-list-name-1",
##      "info": {
##          "field-name": [{
##                              "id": "entry-list-name-1+-field-name-0",
##                              "probability": int,
##                              "value": ["term-id-1", "term-id-2"],
##                         },
##                         {
##                              "id": "entry-list-name-1+-field-name-0",
##                              "probability": "",
##                              "value": ["term-id-3", "term-id-5"],
##                         }
##                        ]
##         }
##     }

proc readSchema(): JsonNode =
    ## read schema.json for field term association values
    return parseFile(getSchemaPath())

proc makeEntryTemplate(schema: JsonNode,
                       entrynb: int,
                       lstname: string): JsonNode =
    ## make entry template from schema to fill further
    let idstr = lstname & "-entry-" & $(entrynb)
    result = %* {"id": idstr}
    var info = %* {"info": {}}
    for key in schema.keys():
        info[key] = newJArray()
    result["info"] = info

proc getEntriesFromList*(lst: JsonNode,
                         fuzzy: string): JsonNode {.raises: [ValueError].} =
    ## get entries from entry list using fuzzy string
    var entries = newJArray()
    for entry in entries.items():
        let entryId = entry["id"].getStr()
        if fuzzy in entryId:
            entries.add(entry)
            continue
        let entryInfo = entry["info"]
        block inEntryBlock:
            for fieldTpl in entryInfo.pairs():
                let fname = fieldTpl.key.getStr()
                if fuzzy in fname:
                    entries.add(entry)
                    break inEntryBlock
                let farray = fieldTpl.val
                for fieldObj in farray.items():
                    let valarr = fieldObj["value"]
                    for val in valarr.items():
                        if fuzzy in val:
                            entries.add(entry)
                            break inEntryBlock
    return entries

proc getFieldByName(fieldName: string,
                    entry: JsonNode): JsonNode {.raises: [ValueError].} =
    ## get jarray associated to field from entry using its name
    let einfo = entry["info"]
    var found = false
    for name, arr in einfo.pairs():
        let nstr = name.getStr()
        if nstr == fieldName:
            found = true
            return arr
    if found == false:
        var msg = "Field name " & fieldName & " does not exist in entry "
        msg = msg & entry["id"].getStr()

        raise newException(ValueError, msg)

proc addValue2Field(fieldName: string,
                    probability: uint8,
                    fval: string,
                    values: seq[string],
                    entry: JsonNode): JsonNode =
    "add value 2 field"
    var fieldarr = getFieldByName(fieldName, entry)
    let eids = entry["id"].getStr()
    let arrlen = len(fieldarr)
    let valname = eids & "+" & fieldName & "-" & $(arrlen)

    let valobj = %* {valname: fval, "probability": probability,
                     "value": values}
    fieldarr.add(valobj)
    entry["info"][fieldName] = fieldarr
    return entry
