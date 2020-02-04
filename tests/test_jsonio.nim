## test jsonio.nim
import unittest
import os
import json
import tables
import transformer/jsonio
import dtype/term
import dtype/schema
import dtype/separator
import dtype/entry

suite "jsonio.nim tests":

    echo "----------------------------"
    echo "- jsonio.nim tests started -"
    echo "----------------------------"

    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gdir: string = os.joinPath(tdir, "test-data")
    let lstpath: string = os.joinPath(gdir, "term.json")
    const us = safeSeparators[Seps.US]

    let tid = TermId(value: "my-id")
    let cont = @[TermId(value: "my1"),
                 TermId(value: "my2")]
    let term = Term(id: tid, value: "foo",
                    contain: cont)
    let sid = SchemaId(value: "schema-1")
    let sname = SchemaName(value: "my schema")
    let sfields = {"fieldName": "fieldTerm",
                   "fieldName2": "fieldTerm2"}.toTable
    let schema = Schema(fields: sfields, id: sid, name: sname)

    assert os.existsFile(lstpath)

    test "term id 2 json":
        check( % tid == % "my-id")

#test "term to json":
    #    check( % term == %{
    #        % "id": %tid,
    #        % "value": %"foo",
    #        % "contain": % cont
    #        }
    #        )
    test "schema id":
        check(%sid == %* "schema-1")

    test "schema to json":
        check(%schema == %* {
            "fields": {"fieldName": "fieldTerm",
                   "fieldName2": "fieldTerm2"
            },
            "id": "schema-1",
            "name": "my schema"
        })

    test "entry field name to json":
        check(%EntryFieldName(value: "m") == %*"m")

    test "entry id to json":
        check(%EntryId(value: "m") == %* "m")

    test "entry field value id":
        check(%EntryFieldValueId(
            fieldName: EntryFieldName(value: "m"),
            entryId: EntryId(value: "k"),
            nb: 14) == % ("m" & us & "k" & us & "14")
            )
