## separator primitive

type
    Seps* = enum
        US, RS, GS

const
    safeSeparators* = [
        Seps.US: "", # unit separator:U+001F
        Seps.RS: "", # record separator: U+001E
        Seps.GS: "", # group separator: U+001D
    ]
    readableSeparators* = [
        Seps.US: "-",
        Seps.RS: "_",
        Seps.GS: ":",
    ]
