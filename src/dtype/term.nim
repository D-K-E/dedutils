## term primitive
import json

## Term List Structure
## --------------------
##
## A term list has the following structure
##
## .. code-block:: json
##
##     [{"id": "term-list-name-0", "value": string,
##       "contain/optional": ["term-id"]}
##     ]
##

type
    TermId* = object
        value*: string

type
    Term* = object
        id*: TermId
        value*: string
        contain*: seq[TermId]
