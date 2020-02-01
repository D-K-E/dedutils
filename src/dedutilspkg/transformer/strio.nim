## transform dtype to/from tostring
import strutils
import "../dtype/entry"
import "../dtype/schema"
import "../dtype/separator"
import "../dtype/term"
import "../maker/term"

## to string operations

proc `$`*(t: TermId): string =
    return t.value

proc `$`*(t: Term): string =
    const us = safeSeparators[Seps.US]
    const rs = safeSeparators[Seps.RS]
    let tid = $(t.id)
    let v = t.value
    let cs = t.contain
    result = "Term("
    result = result & "Id(" & tid & ")" & rs
    result = result & "Value(" & v & ")" & rs
    result = result & "Contain("
    for c in cs:
        result = result & c & us
    result = result & ")" & ")"

proc toString*(t: Term): string =
    return $(t)

proc toString*(t: TermId): string =
    return $(t)


proc `$`*(s: SchemaId): string =
    return s.value

proc `$`*(s: SchemaName): string =
    return s.value

proc toString*(s: SchemaId): string =
    return $(s)

proc toString*(s: SchemaName): string =
    return $(s)

proc `$`*(s: Schema): string =
    const us = safeSeparators[Seps.US]
    const rs = safeSeparators[Seps.RS]
    const gs = safeSeparators[Seps.GS]
    let sid = $(s.id)
    let sname = $(s.name)
    result = "Schema(" & "Fields("
    for k, v in s.fields.pairs():
        result = result & k & gs & v & us
    result = result & ")" & rs
    result = result & "Id(" & sid & ")" & rs
    result = result & "Name(" & sname & ")" & ")"

proc toString*(s: Schema): string =
    return $(s)

proc `$`*(e: EntryFieldName): string =
    result = e.value

proc toString*(e: EntryFieldName): string =
    return $(e)

proc `$`*(e: EntryId): string =
    result = e.value

proc toString*(e: EntryId): string =
    return $(e)

proc `$`*(e: EntryFieldValueId): string =
    let fn = $(e.fieldName)
    let ei = $(e.entryId)
    const us = safeSeparators[Seps.US]
    result = "Id(" & fn & us & ei & us & $(e.nb) & ")"

proc toString*(e: EntryFieldValueId): string =
    return $(e)


proc `$`*(e: EntryFieldValue): string =
    const us = safeSeparators[Seps.US]
    const rs = safeSeparators[Seps.RS]
    let id = $(e.id)
    let p = "Probability(" & $(e.probability) & ")"
    result = "Value(" & id & rs & p & rs
    for v in e.value:
        result = result & $(v) & us
    result = result & ")"

proc toString*(e: EntryFieldValue): string =
    return $(e)

proc `$`*(e: EntryField): string =
    const us = safeSeparators[Seps.US]
    const rs = safeSeparators[Seps.RS]
    let n = $(e.name)
    result = "Field(" & n & rs
    for v in e.values:
        result = result & $(v) & us
    result = ")"

proc toString*(e: EntryField): string =
    return $(e)

proc `$`*(e: Entry): string =
    const us = safeSeparators[Seps.US]
    const rs = safeSeparators[Seps.RS]
    let id = $(e.id)
    result = "Entry(" & id & rs
    for v in e.info:
        result = result & $(v) & us
    result = ")"

proc toString*(e: Entry): string =
    return $(e)

## from string functions
