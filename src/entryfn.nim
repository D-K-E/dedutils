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
##                              "field-name-id-1": "",
##                              "probability": "",
##                              "value": ["term-id-1", "term-id-2"],
##                         },
##                         {
##                              "field-name-id-2": "",
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

