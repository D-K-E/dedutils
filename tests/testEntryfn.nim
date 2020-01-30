# test entryfn.nim functions
import unittest
import os
import json

import schemafn

suite "entryfn.nim tests":
    
    echo "-----------------------------"
    echo "- entryfn.nim tests started -"
    echo "-----------------------------"

    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gdir: string = os.joinPath(tdir, "test-data")
    let entryPath: string = os.joinPath(tdir, "entry.json")

    test "makeSchema test":
        let j = "tlist1:efield1;tlist2:efield2"
        let schema = makeSchema(j)
        let cmpv = %* {"tlist1": "efield1",
                       "tlist2": "efield2"}
        check (cmpv == schema)

    echo "--------------------------"
    echo "-- schemafn.nim tests ended --"
    echo "--------------------------"

