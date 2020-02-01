## schema primitive
from tables import Table

## Entry Schema Structure
## -----------------------
##
## The entry schema should be unique per project.
## It should contain the following associations
## For info field of an entry each subfield should
## be associated to a term list so that
## the vocabulary used within that field could
## be validated. None is an allowed value
## which simply means no validation is done for
## the content.
##
## .. code-block:: json
##
##     {"fields" :{"field-name-1": "term-list-name-1",
##      "field-name-2": "term-list-name-2"}
##      "id": "", "name": ""}
##
##

type
    SchemaId* = object
        value*: string

proc `==`*(s1, s2: SchemaId): bool =
    return s1.value == s2.value

proc `!=`*(s1, s2: SchemaId): bool =
    return not(s1 == s2)

type
    SchemaName* = object
        value*: string

proc `==`*(s1, s2: SchemaName): bool =
    return s1.value == s2.value

proc `!=`*(s1, s2: SchemaName): bool =
    return not(s1 == s2)


type
    Schema* = object
        fields*: Table
        id*: SchemaId
        name*: SchemaName

proc `==`*(s1, s2: Schema): bool =
    result = true
    if s1.fields != s2.fields:
        result = false
    if s1.id != s2.id:
        result = false
    if s1.name != s2.name:
        result = false
