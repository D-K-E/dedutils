## separator primitive
type 
    Seps = enum
        US, RS, GS

const 
    safeSeparators = [
        US: "", # unit separator:U+001F
        RS: "", # record separator: U+001E
        GS: "", # group separator: U+001D
    ]
    readableSeparators = [
        US: "-",
        RS: "_",
        GS: ":",
    ]
