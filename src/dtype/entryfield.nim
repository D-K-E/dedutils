## entry field primitive
import dtype.term
import dtype.entry # EntryId and == op

## {"fieldName": [{
##   "id": "entryId+fieldName-0",
##   "probability": "",
##   "value": ["term-id-3", "term-id-5"],
## }]}


type
    EntryFieldName* = object
        value*: string

proc `==`(e1, e2: EntryFieldName): bool =
    return e1.value == e2.value

proc `!=`(e1, e2: EntryFieldName): bool =
    return not (e1 == e2)

type
    EntryFieldValueId* = object
        fieldName*: EntryFieldName
        entryId*: EntryId
        nb*: int

proc `==`(e1, e2: EntryFieldValueId): bool =
    result = true
    if e1.fieldName != e2.fieldName:
        result = false
    if e1.entryId != e2.entryId:
        result = false
    if e1.nb != e2.nb:
        result = false

proc `!=`(e1, e2: EntryFieldValueId): bool =
    return not (e1 == e2)

type
    EntryFieldValue* = object
        id*: EntryFieldValueId
        probability*: float
        value*: seq[TermId]

proc `==`(e1, e2: EntryFieldValue): bool =
    result = true
    if e1.id != e2.id:
        result = false
    if e1.value != e2.value:
        result = false

proc `!=`(e1, e2: EntryFieldValue): bool =
    return not (e1 == e2)

proc contains(vs: seq[EntryFieldValue], v: EntryFieldValue): bool =
    result = false
    for c in vs:
        if c == v:
            result = true

proc `==`(e1, e2: seq[EntryFieldValue]): bool =
    result = true
    for e in e1:
        if contains(e2, e) == false:
            result = false

proc `!=`(e1, e2: seq[EntryFieldValue]): bool =
    return not (e1 == e2)

type
    EntryField* = object
        name*: EntryFieldName
        values*: seq[EntryFieldValue]

proc `==`(e1, e2: EntryField): bool =
    result = true
    if e1.name != e2.name:
        result = false
    if e1.values != e2.values:
        result = false

proc `!=`(e1, e2: EntryField): bool =
    return not (e1 == e2)
