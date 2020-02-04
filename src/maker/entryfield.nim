## maker for entry field primitive
import "../dtype/entry"
import "../dtype/term"

proc mkEntryFieldName*(v: string): EntryFieldName =
    ## make entry field name from string
    return EntryFieldName(value: v)

proc mkEntryId*(v: string): EntryId =
    ## make entry id
    return EntryId(value: v)

proc mkEntryFieldValueId*(name: EntryFieldName,
                         eid: EntryId,
                         nb: int): EntryFieldValueId =
    ## make entry field value id
    return EntryFieldValueId(fieldName: name, entryId: eid, nb: nb)

proc mkEntryFieldValue*(id: EntryFieldValueId,
                        probability: float,
                        value: seq[TermId]): EntryFieldValue =
    ## make entry field value
    return EntryFieldValue(id: id, probability: probability, value: value)

proc mkEntryField*(name: EntryFieldName,
                     vs: seq[EntryFieldValue]): EntryField =
    ## make entry field
    return EntryField(name: name, values: vs)

proc mkEntry*(id: EntryId, info: seq[EntryField]): Entry =
    ## make entry
    return Entry(id: id, info: info)
