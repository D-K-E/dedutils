## schema.nim schema maker command line interface
import schemafn # getTermListNames
import rdstdin  # readLineFromStdin
import streams  # write file
import json  # pretty
import os
import utils


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
