## test validate.nim
import unittest
import os
import json
import tables
import validate as vld
import transformer/jsonio as jio
import dtype/term
import dtype/schema
import dtype/separator
import dtype/entry
import maker/term as mt

suite "validate.nim tests":

    echo "----------------------------"
    echo "- jsonio.nim tests started -"
    echo "----------------------------"

    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gdir: string = os.joinPath(tdir, "test-data")
    let schdir: string = os.joinPath(gdir, "schema.json")
    let termpath: string = os.joinPath(gdir, "term.json")
    let sid = SchemaId(value: "schema-1")
    let sname = SchemaName(value: "my schema")
    let sfields = {"fieldName": "fieldTerm",
                   "fieldName2": "fieldTerm2"}.toTable
    let schema = Schema(fields: sfields, id: sid, name: sname)
    let terms: seq[Term] = @[mkTerm(id = str2id("term-0"), value = "my",
                         contain = @[]),
                  mkTerm(id = str2id("term-1"), value = "other",
                         contain = @[]),
                  mkTerm(id = str2id("term-2"), value = "term", contain = @[])
    ]

    test "readSchema test":
        let rschema = jio.getSchema(parseFile(schdir))
        check(schema == rschema)

    test "read term list test":
        var rterms = vld.readTermList(termpath)
        rterms = rterms[0..2]
        echo rterms
        echo terms
        check(terms.len == rterms.len)
        for i in [0..rterms.len-1]:
            check(rterms[i] == terms[i])
