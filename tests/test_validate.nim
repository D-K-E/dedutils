## test validate.nim
import unittest
import os
import json
import tables
import validate
import transformer/jsonio as jio
import dtype/term
import dtype/schema
import dtype/separator
import dtype/entry

suite "validate.nim tests":

    echo "----------------------------"
    echo "- jsonio.nim tests started -"
    echo "----------------------------"

    let cdir: string = os.getCurrentDir()
    echo "fooo"
    let tdir: string = os.joinPath(cdir, "tests")
    let gdir: string = os.joinPath(tdir, "test-data")
    let schdir: string = os.joinPath(gdir, "schema.json")
    let sid = SchemaId(value: "schema-1")
    let sname = SchemaName(value: "my schema")
    let sfields = {"fieldName": "fieldTerm",
                   "fieldName2": "fieldTerm2"}.toTable
    let schema = Schema(fields: sfields, id: sid, name: sname)

    test "readSchema test":
        let rschema = jio.getSchema(parseFile(schdir))
        check(schema == rschema)

    test "read term list test":
