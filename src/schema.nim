## schema.nim schema maker command line interface
import schemafn # getTermListNames
import rdstdin  # readLineFromStdin
import streams  # write file
import json  # pretty
import os
import utils

## Entry Schema Structure
## -----------------------
##
## The entry schema should be unique per project.
## It should contain the following associations
## For info field of an entry each subfield should
## be associated to a term list so that
## the vocabulary used within that field could
## be validated. None is an allowed value
## which simply means no validation is done for
## the content.
##
## .. code-block:: json
##
##     {"field-name-1": "term-list-name-1",
##      "field-name-2": "term-list-name-2"}
##
##

echo "Welcome to entry schema maker interface!"
echo "Here are available term list for entry fields:\n"
for name in getTermListNames():
    echo "  - " & name

echo "Please enter field term association using ; : as delimiter as in:"
echo "fieldname1:termListName1;fieldname2:termListName2;..."
var fieldPairs = readLineFromStdin(
    ""
)
let schema = makeSchema(fieldPairs)
let schemaPath = joinPath(getEntryListDir(), "schema.json")
var strm = newFileStream(schemaPath, fmWrite)
if not isNil(strm):
    strm.write(pretty(schema))
    strm.close()
