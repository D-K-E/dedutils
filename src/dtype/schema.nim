## schema primitive
from json import JsonNode

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

type
    SchemaName* = object
        value*: string

type
    Schema* = object
        fields*: JsonNode
        id*: SchemaId
        name*: SchemaName
