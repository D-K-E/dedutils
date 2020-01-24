## term.nim interface for command line usage
import termfn
import rdstdin  # readLineFromStdin
import strutils  # split
import json  # pretty
import streams  # write file
import os

echo "Welcome to term interface!"
let tname = readLineFromStdin(
    "Please enter the name of term list without extension: "
    )

let tlst = getTermList(tname)

let choice = readLineFromStdin(
    "What would you like to do with " & tname & " [add/check] ? ")

if choice == "add":
    let term = readLineFromStdin("Please enter term: ")
    let contterm = readLineFromStdin("Does term contain other terms [Y/n] ? ")
    var nlst: JsonNode
    if contterm == "n":
        nlst = addTerm2List(tlst, term, tname)
    else:
        let otherpart = readLineFromStdin(
        "Enter other term parts separated by ; as in my;other;term;part : ")
        var others = otherpart.split(";")
        var otherMatches = getTermListFromList(tlst, others)
        echo "Here are terms that matches other term parts you had provided\n"
        echo pretty(otherMatches)
        echo "\n"
        let contained = readLineFromStdin(
        "Now enter id values of other terms separated by ; as in above: ")
        nlst = addTerm2List(tlst, term, tname, contained.split(";"))
    var tdir = joinPath($(CurDir), "data")
    tdir = joinPath(tdir, "term-list")
    let tpath = joinPath(tdir, tname & ".json")
    var strm = newFileStream(tpath, fmWrite)
    if not isNil(strm):
        strm.write(pretty(nlst))
        strm.close()
elif choice == "check":
    let term = readLineFromStdin("Please enter term: ")
    let terms = getTermsFromList(tlst, term)
    echo "Here is the required check information:\n"
    echo pretty(terms)
    echo "\n"

