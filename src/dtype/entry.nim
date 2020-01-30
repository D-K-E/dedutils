## entry primitif
import json
import dtype.entryfield import EntryField

type
    EntryId* = object
        value*: string

type
    Entry* = object
        id*: EntryId
        info*: seq[EntryField]
