## maker for entry field primitive
import dtype.entryfield
from dtype.entry import EntryId
from dtype.separator import US, RS, GS

proc mkEntryFieldName*(v: string): EntryFieldName =
    ## make entry field name from string
    return EntryFieldName(value: v)

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

proc makeEntryField*(name: EntryFieldName,
                     vs: seq[EntryFieldValue]): EntryField =
    ## make entry field
    return EntryField(name: name, values: vs)
