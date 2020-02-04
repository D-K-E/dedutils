## validate edition project parts

import dtype/entry
import dtype/term
import dtype/schema
import transformer/jsonio as jio
import maker/schema as smaker
import utils
import json
import tables
import os # walkDir, splitFile
import strutils
from system import newException, FieldError, ValueError


proc readSchema*(): Schema =
    ## read schema
    let schemaPath = getSchemaPath()
    let jschema = parseJson(schemaPath)
    return jio.getSchema(jschema)

proc readTermList*(path: string): seq[Term] =
    ## read term list from path
    let jterms = parseJson(path)
    return jio.getTermList(jterms)

proc getTermListTable*(): Table[string, seq[Term]] =
    ## get term table termlist name -> termlist path
    let tlistspath = getTermListDir()
    result = initTable[string, seq[Term]]()
    for kind, path in walkDir(tlistspath):
        let tpath = splitFile(path)
        if tpath.ext == ".json":
            result[tpath.name] = readTermList(path)

proc readEntryList(path: string): seq[Entry] =
    ## read entry list from path
    let jentries = parseJson(path)
    for jentry in jentries.items():
        result.add(jio.getEntry(jentry))

proc getEntryLstTable*(): Table[string, seq[Entry]] =
    ## get entry list table
    let elstdir = getEntryListDir()
    result = initTable[string, seq[Entry]]()
    for kind, path in walkDir(elstdir):
        let epath = splitFile(path)
        if epath.ext == ".json":
            result[epath.name] = readEntryList(path)


proc validateEntryFieldValue(e: EntryFieldValue,
                        ts: seq[Term]): bool =
    ## validate entry field's terms
    let vals = e.value
    result = true
    for v in vals.items():
        var check = true
        if contains(ts, v) == false:
            check = false
            result = false
        if check == false:
            echo "------------"
            echo "Following entry field value is not valid:\n"
            echo $(v)
            echo "------------"
    if result == false:
        raise newException(FieldError,
                           "entry field value contains invalid terms")

proc validateEntry(e: Entry,
                   s: Schema,
                   termLstTbl: Table[string, seq[Term]]): bool =
    ## validate entry using schema
    let eid = e.id
    let eids = $(e.id)
    echo "----------"
    echo "Validating entry: " & eids
    echo "----------"
    let infos = e.info
    result = true
    for efield in infos:
        let fname = $(efield.name)
        let tlstname = s.fields[fname]
        let terms = termLstTbl[tlstname]
        for evalue in efield.values:
            result = validateEntryFieldValue(evalue, terms)

proc validateEntryLstTerms(
    elst: seq[Entry],
    s: Schema,
    termLstTbl: Table[string, seq[Term]]
): bool =
    ## validate entry list elements
    for e in elst:
        validateEntry(e, s, termLstTbl)



