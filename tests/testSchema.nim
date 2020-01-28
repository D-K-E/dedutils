# test schemafn.nim functions
import unittest
import os
import json

import schemafn

suite "schemafn.nim tests":
    
    echo "--------------------------"
    echo "- schemafn.nim tests started -"
    echo "--------------------------"

    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gdir: string = os.joinPath(tdir, "test-data")

    test "makeSchema test":
        let j = "tlist1:efield1;tlist2:efield2"
        let schema = makeSchema(j)
        let cmpv = %* {"tlist1": "efield1",
                       "tlist2": "efield2"}
        check (cmpv == schema)

    echo "--------------------------"
    echo "-- schemafn.nim tests ended --"
    echo "--------------------------"

