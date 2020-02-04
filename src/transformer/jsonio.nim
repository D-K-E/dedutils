## transform dtype to/from json
import dtype/entry
import dtype/schema
import dtype/separator
import dtype/term
import maker/term as tmaker
import maker/schema as smaker
import maker/entryfield as emaker
import transformer/strio
import json
import tables
from strutils import split, parseInt

proc `%`*(t: TermId): JsonNode =
    return % t.value

proc `%`*(t: Term): JsonNode =
    ## term to json
    let cs = t.contain
    result = newJObject()
    result["id"] = % t.id.value
    result["value"] = % t.value
    result["contain"] = newJArray()
    for c in cs:
        result["contain"].add( % t)

proc `%`*(s: SchemaId): JsonNode =
    return % s.value

proc `%`*(s: SchemaName): JsonNode =
    return % s.value

proc `%`*(s: Schema): JsonNode =
    result = newJObject()
    result["fields"] = % s.fields
    result["id"] = % s.id
    result["name"] = % s.name

proc `%`*(e: EntryFieldName): JsonNode =
    result = % e.value

proc `%`*(e: EntryId): JsonNode =
    result = % e.value

proc `%`*(e: EntryFieldValueId): JsonNode =
    const us = safeSeparators[Seps.US]
    let fname = $(e.fieldName)
    var s = fname & us & $(e.entryId) & us & $(e.nb)
    result = % s

proc `%`*(e: EntryFieldValue): JsonNode =
    result = newJObject()
    result["id"] = % e.id
    result["probability"] = % e.probability
    result["value"] = newJArray()
    for v in e.value:
        result["value"].add( % v)

proc `%`*(e: EntryField): JsonNode =
    result = newJObject()
    result[e.name.value] = newJArray()
    for v in e.values:
        result[e.name.value].add( % v)

proc `%`*(e: Entry): JsonNode =
    result = newJObject()
    result["id"] = % e.id
    result["info"] = newJArray()
    for v in e.info:
        result["info"].add( % v)

## parse json output
proc getTermId*(t: JsonNode): TermId =
    ## get term id
    let tstr = t.getStr()
    return tmaker.str2id(tstr)

proc getTerm*(t: JsonNode): Term =
    ## get term from json
    let tid = getTermId(t["id"])
    let v = t["value"].getStr()
    var cs: seq[TermId]
    for c in t["contain"]:
        cs.add(getTermId(c))
    return tmaker.mkTerm(tid, v, cs)

proc getTermList*(tlst: JsonNode): seq[Term] =
    ## get term list from json node
    var ts: seq[Term]
    for t in tlst.items():
        ts.add(getTerm(t))
    return ts


proc getEntryFieldName*(e: JsonNode): EntryFieldName =
    ## get entry field name
    return emaker.mkEntryFieldName(e.getStr())

proc getEntryId*(e: JsonNode): EntryId =
    ## get entry id
    return emaker.mkEntryId(e.getStr())

proc getEntryFieldValueId*(e: JsonNode): EntryFieldValueId =
    ## entry field value id from json
    const us = safeSeparators[Seps.US]
    let si = e.getStr()
    let s = si.split(us)
    let name = emaker.mkEntryFieldName(s[0])
    let id = emaker.mkEntryId(s[1])
    return emaker.mkEntryFieldValueId(name, id,
        parseInt(s[2])
    )

proc getEntryFieldValue*(e: JsonNode): EntryFieldValue =
    ## get entry field value
    let id = getEntryFieldValueId(e["id"])
    let prob = e["probability"].getFloat()
    var ts: seq[TermId]
    for t in e["value"].items():
        ts.add(getTermId(t))
    return emaker.mkEntryFieldValue(id, prob, ts)

proc getEntry*(e: JsonNode): Entry =
    ## get entry from json
    let id = getEntryId(e["id"])
    let info = e["info"]
    var es: seq[EntryField]
    for field, vals in info.pairs():
        let name = mkEntryFieldName(field)
        var vs: seq[EntryFieldValue]
        for v in vals:
            vs.add(getEntryFieldValue(v))
        #
        let ef = emaker.mkEntryField(name, vs)
        es.add(ef)
    return emaker.mkEntry(id, es)

proc getSchema*(s: JsonNode): Schema =
    ## get schema from json
    var fields = initTable[string, string]()
    for k, val in s["fields"].pairs:
        fields[k] = val.getStr()
    let id = s["id"].getStr()
    let name = s["name"].getStr()
    return smaker.mkSchema(fields, id, name)
