## entry field modifier
import dtype.entryfield
from dtype.term
from dtype.entry import EntryId
import maker.entryfield

## Replacer declarations
proc replace(ef: EntryField, n: EntryFieldName): EntryField
proc replace(ef: EntryField, vs: seq[EntryFieldValue]): EntryField
proc replace(ev: EntryFieldValue, id: EntryFieldValue): EntryFieldValue
proc replace(ev: EntryFieldValue, p: float): EntryFieldValue
proc replace(ev: EntryFieldValue, vs: seq[TermId]): EntryFieldValue
proc replace(ei: EntryFieldValueId, fn: EntryFieldName): EntryFieldValueId
proc replace(ei: EntryFieldValueId, e: EntryId): EntryFieldValueId

## Replacer Implementations
proc replace(ef: EntryField, n: EntryFieldName): EntryField =
    ## replace entryfield's name with given entry field name
    return mkEntryField(n, ef.values)

proc replace(ef: EntryField, vs: seq[EntryFieldValue]): EntryField =
    ## replace entry field's values with given values
    return mkEntryField(ef.name, vs)

proc replace(ev: EntryFieldValue, id: EntryFieldValue): EntryFieldValue =
    ## replace entry field value's id
    return mkEntryFieldValue(id, ev.probability, ev.value)

proc replace(ev: EntryFieldValue, p: float): EntryFieldValue =
    ## replace entry field value's probability
    return mkEntryFieldValue(ev.id, p, ev.value)

proc replace(ev: EntryFieldValue, vs: seq[TermId]): EntryFieldValue =
    ## replace entry field value's value to vs
    return mkEntryFieldValue(ev.id, ev.probability, vs)

proc replace(ei: EntryFieldValueId, fn: EntryFieldName): EntryFieldValueId =
    ## replace entry field value id's fieldName with fn
    return mkEntryFieldValueId(fn, ei.entryId, ei.nb)

proc replace(ei: EntryFieldValueId, e: EntryId): EntryFieldValueId =
    ## replace entry field value id's entryId with e
    return mkEntryFieldValueId(ei.fieldName, e, ei.nb)


## Add/Remove declarations
proc add(ef: EntryField, v: EntryFieldValue): EntryField
proc add(ef: EntryField, vs: seq[EntryFieldValue]): EntryField
proc add(ev: EntryFieldValue, v: TermId): EntryFieldValue
proc add(ev: EntryFieldValue, vs: seq[TermId]): EntryFieldValue

## Add/Remove implementations

proc add(ef: EntryField, v: EntryFieldValue): EntryField =
    ## add entry field value to entry field
    var vs: ef.values
    if contains(ef, v) == false:
        vs.add(v)
    return replace(ef, vs)

proc add(ef: EntryField, vs: seq[EntryFieldValue]): EntryField =
    ## add entry field value to entry field
    var ovs: seq[EntryFieldValue] = ef.values
    var evs: seq[EntryFieldValue]
    for v in ovs:
        if contains(vs, v) == false:
            evs.add(v)
    return replace(ef, evs)

proc add(ev: EntryFieldValue, t: TermId): EntryFieldValue =
    ## add term id to entry field value
    var vs = ev.value
    if contains(EntryFieldValue, t) == false:
        vs.add(t)
    return replace(ev, vs)

proc add(ev: EntryFieldValue, ts: seq[TermId]): EntryFieldValue =
    ## add term ids to entry field value
    var vs: seq[TermId] = ev.value
    var nv: seq[TermId]
    for v in vs:
        if contains(ts, v) == false:
            nv.add(v)
    return replace(ev, nv)
