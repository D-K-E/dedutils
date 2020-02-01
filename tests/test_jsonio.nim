## test jsonio.nim
import unittest
import os
import json
import tables
import "transformer/jsonio"
import "dtype/term"
import "dtype/schema"
import "dtype/entry"

suite "jsonio.nim tests":

    echo "----------------------------"
    echo "- jsonio.nim tests started -"
    echo "----------------------------"

    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gdir: string = os.joinPath(tdir, "test-data")
    let lstpath: string = os.joinPath(gdir, "term.json")
    let tid = TermId(value: "my-id")
    let cont = @[TermId(value: "my1"),
                 TermId(value: "my2")]
    let term = Term(id: tid, value: "foo",
                    contain: cont)
    let sid = SchemaId(value: "schema-1")
    let sname = SchemaName(value: "my schema")
    let sfields = {"fieldName": "fieldTerm",
                   "fieldName2": "fieldTerm2"}.toTable

    assert os.existsFile(lstpath)

    test "term id 2 json":
        check( % t, % "my-id")

    test "term to json":
        check( % t, %* {"id": tid, "value": "foo",
                        "contain": cont})

    test "schema id":

