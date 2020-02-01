## term primitive

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

proc `==`*(t1: TermId, t2: TermId): bool =
    return t1.value == t2.value

proc `!=`*(t1, t2: TermId): bool =
    return not (t1 == t2)

proc contains*(ts: seq[TermId], v: TermId): bool =
    ## check if term is contained in term sequence
    result = false
    for t in ts:
        if t == v:
            result = true


proc `==`*(t1: seq[TermId], t2: seq[TermId]): bool =
    result = true
    for t in t1:
        if contains(t2, t) == false:
            result = false

proc `!=`*(t1, t2: seq[TermId]): bool =
    return not (t1 == t2)

type
    Term* = object
        id*: TermId
        value*: string
        contain*: seq[TermId]

proc `==`*(t1: Term, t2: Term): bool =
    ## t1 is same as t2 ?
    result = true
    if t1.id != t2.id:
        result = false
    if t1.value != t2.value:
        result = false
    if t1.contain != t2.contain:
        result = false

proc `!=`*(t1, t2: Term): bool =
    result = not (t1 == t2)

proc contains*(t1: seq[Term], t2: Term): bool =
    result = false
    for t in t1:
        if t == t2:
            result = true

proc `==`*(t1, t2: seq[Term]): bool =
    result = true
    for t in t1:
        if contains(t2, t) == false:
            result = false

proc `!=`*(t1, t2: seq[Term]): bool =
    result = not (t1 == t2)
