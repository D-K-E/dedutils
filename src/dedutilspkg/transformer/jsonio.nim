## transform dtype to/from json
import "../dtype/entry"
import "../dtype/schema"
import "../dtype/separator"
import "../dtype/term"
import "../maker/term"
import "../maker/schema"
import "../maker/entryfield"
import json

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
    var s = e.fieldName & us & e.entryId & us & $(e.nb)
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
proc getTermId(t: JsonNode): TermId =
    ## get term id
    let tstr = t.getStr()
    return str2id(tstr)

proc getTerm(t: JsonNode): Term =
    ## get term from json
    let tid = getTermId(t["id"])
    let v = t["value"].getStr()
    var cs: seq[TermId]
    for c in t["contain"]:
        cs.add(getTermId(c.getStr()))
    return mkTerm(tid, v, cs)

proc getEntryFieldName(e: JsonNode): EntryFieldName =
    ## get entry field name
    return mkEntryFieldName(e.getStr())

proc getEntryId(e: JsonNode): EntryId =
    ## get entry id
    return mkEntryId(e.getStr())

proc getEntryFieldValueId(e: JsonNode): EntryFieldValueId =
    ## entry field value id from json
    const us = safeSeparators[Seps.US]
    var s = e.getStr()
    s = s.split(us)
    return mkEntryFieldValueId(s[0], s[1], s[2])

proc getEntryFieldValue(e: JsonNode): EntryFieldValue =
    ## get entry field value
    let id = getEntryFieldValueId(e["id"])
    let prob = e["probability"].getFloat()
    var ts: seq[TermId]
    for t in e["value"].items():
        ts.add(getTermId(t))
    return mkEntryFieldValue(id, prob, ts)

proc getEntry(e: JsonNode): Entry =
    ## get entry from json
    let id = getEntryId(e["id"])
    let info = e["info"]
    var es: seq[EntryField]
    for field, vals in info.pairs():
        let name = getEntryFieldName(field)
        var vs: seq[EntryFieldValue]
        for v in vals:
            vs.add(getEntryFieldValue(v))
        #
        let ef = mkEntryField(name, vs)
        es.add(ef)
    return mkEntry(id, es)

