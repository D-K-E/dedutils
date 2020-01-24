# test term.nim functions
import unittest
import os
import json

import termfn

suite "term.nim tests":
    
    echo "--------------------------"
    echo "- termfn.nim tests started -"
    echo "--------------------------"

    let cdir: string = os.getCurrentDir()
    let tdir: string = os.joinPath(cdir, "tests")
    let gdir: string = os.joinPath(tdir, "test-data")
    let lstpath: string = os.joinPath(gdir, "term.json")
    assert os.existsFile(lstpath)

    test "parseFile test":
        var j = %* [{
            "id": "term-0",
            "value": "my"
        },
        {
            "id": "term-1",
            "value": "other"
        },
        {
            "id": "term-2",
            "value": "term"
        },
        {
            "id": "term-3",
            "value": "my other term",
            "contain": ["term-0", "term-1", "term-2"]
        }
        ]
        let file = parseFile(lstpath)
        check( file == j )

    test "getTermById test":
        let lst: JsonNode = parseFile(lstpath)
        var term = getTermById(lst, "term-0")
        var j = %* {"id": "term-0", "value": "my"}
        check (term == j)

    test "getTermsFromList test":
        let lst: JsonNode = parseFile(lstpath)
        let fzy: string = "oth"
        var j =  %* [ {"id": "term-1", "value": "other"}, 
                   {"id": "term-3", "value": "my other term",
                        "contain": ["term-0", "term-1", "term-2"]
                    }
                ]
        var res = getTermsFromList(lst, fzy)
        check( j == res )

    test "getTermListFromList test":
        let lst: JsonNode = parseFile(lstpath)
        let fzy = @["oth", "my"]
        var j =  %* [ {"id": "term-1", "value": "other"}, 
                   {"id": "term-3", "value": "my other term",
                        "contain": ["term-0", "term-1", "term-2"]
                    },
                      {"id": "term-0", "value": "my"}
                ]
        var res = getTermListFromList(lst, fzy)
        check( j == res )


    test "addTerm2List test":
        var lst: JsonNode = parseFile(lstpath)
        var j = %* [{
            "id": "term-0",
            "value": "my"
        },
        {
            "id": "term-1",
            "value": "other"
        },
        {
            "id": "term-2",
            "value": "term"
        },
        {
            "id": "term-3",
            "value": "my other term",
            "contain": ["term-0", "term-1", "term-2"]
        }, {"id": "term-4", "value": "my added", "contain": ["term-0"]}
        ]
        var reslst = addTerm2List(lst, term = "my added", lstname = "term",
                contains = @["term-0"])
        check (j == reslst)

    echo "--------------------------"
    echo "-- term.nim tests ended --"
    echo "--------------------------"

