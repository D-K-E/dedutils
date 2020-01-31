## entry field primitive
from dtype.term import TermId
from dtype.entry import EntryId

## {
##   "id": "entry-list-name-1+-field-name-0",
##   "probability": "",
##   "value": ["term-id-3", "term-id-5"],
## }


type
    EntryFieldName* = object
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
