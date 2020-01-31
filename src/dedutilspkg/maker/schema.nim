## schema primitive maker
import "../dtype/schema"
import json

proc mkSchemaId(v: string): SchemaId =
    ## make schema id from string
    return SchemaId(value: v)

proc mkSchemaName(v: string): SchemaName =
    ## make schema name from string
    return SchemaName(value: v)

proc mkSchema(fs: JsonNode, id: SchemaId, name: SchemaName): Schema =
    ## make schema
    return Schema(fields: fs, id: id, name: name)

proc mkSchema(fs: JsonNode, id: string, name: string): Schema =
    ## make schema from id and name string
    return Schema(fields: fs, id: mkSchemaId(id), name: mkSchemaName(name))
