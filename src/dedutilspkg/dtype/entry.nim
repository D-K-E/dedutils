## entry primitif
import "../dtype/term"

## {id : "",
## "info" : {"fieldName": [{
##   "id": "entryId+fieldName-0",
##   "probability": "",
##   "value": ["term-id-3", "term-id-5"],
##          }
##      ]
##   }
## }


type
    EntryFieldName* = object
        value*: string
type
    EntryId* = object
        value*: string

type
    EntryFieldValueId* = object
        fieldName*: EntryFieldName
        entryId*: EntryId
        nb*: int
type
    EntryFieldValue* = object
        id*: EntryFieldValueId
        probability*: float
        value*: seq[TermId]

type
    EntryField* = object
        name*: EntryFieldName
        values*: seq[EntryFieldValue]

type
    Entry* = object
        id*: EntryId
        info*: seq[EntryField]

## Contains declarations
proc contains*(ev: EntryFieldValue, t: TermId): bool
proc contains*(ef: EntryField, t: TermId): bool
proc contains*(vs: seq[EntryFieldValue], v: EntryFieldValue): bool
proc contains*(ef: EntryField, ev: EntryFieldValue): bool
proc contains*(ef: EntryField, evs: seq[EntryFieldValue]): bool

## Equality declarations

proc `==`*(e1, e2: EntryFieldName): bool =
    return e1.value == e2.value

proc `!=`*(e1, e2: EntryFieldName): bool =
    return not (e1 == e2)


proc `==`*(e1, e2: EntryFieldValueId): bool =
    result = true
    if e1.fieldName != e2.fieldName:
        result = false
    if e1.entryId != e2.entryId:
        result = false
    if e1.nb != e2.nb:
        result = false

proc `!=`*(e1, e2: EntryFieldValueId): bool =
    return not (e1 == e2)


proc `==`*(e1, e2: EntryFieldValue): bool =
    result = true
    if e1.id != e2.id:
        result = false
    if e1.value != e2.value:
        result = false

proc `!=`*(e1, e2: EntryFieldValue): bool =
    return not (e1 == e2)


proc `==`*(e1, e2: seq[EntryFieldValue]): bool =
    result = true
    for e in e1:
        if contains(e2, e) == false:
            result = false

proc `!=`*(e1, e2: seq[EntryFieldValue]): bool =
    return not (e1 == e2)


proc `==`*(e1, e2: EntryField): bool =
    result = true
    if e1.name != e2.name:
        result = false
    if e1.values != e2.values:
        result = false

proc `!=`*(e1, e2: EntryField): bool =
    return not (e1 == e2)


## Contains implementations
proc contains(ev: EntryFieldValue, t: TermId): bool =
    ## entry field value contains term id or not ?
    let vs = ev.value
    return contains(vs, t)

proc contains(vs: seq[EntryFieldValue], v: EntryFieldValue): bool =
    result = false
    for c in vs:
        if c == v:
            result = true

proc contains(ef: EntryField, ev: EntryFieldValue): bool =
    result = contains(ef.values, ev)

proc contains(ef: EntryField, t: TermId): bool =
    result = false
    for v in ef.values:
        if contains(v, t) == true:
            result = true


proc contains(ef: EntryField, evs: seq[EntryFieldValue]): bool =
    result = true
    for v in evs:
        if contains(ef, v) == false:
            result = false
