import std/[tables]

let testStr: string = "thisisahelloworld"
let pattern: string = "is"

proc search_table(pattern: string): OrderedTable[char, int] =
    var table: OrderedTable[char, int]
    for i in 0..<len(pattern):
        if len(pattern) - 1 == i:
            table['*'] = len(pattern)
            break
        table[pattern[i]] = len(pattern) - i - 1
    return table


proc grep(search_str: string, pattern_str: string) =
    var i = 0
    var count = 0
    let search_last_char = pattern_str.len - 1

    while i < len(search_str):
        var table = search_table(pattern_str)

        if len(pattern_str) > len(search_str):
            echo "skipping. no results"
            break

        elif search_str[i + search_last_char] == pattern_str[^1]:
            count += 1
            echo "Pattern found ", count, "at ", i
            continue
        
        elif search_str[i + pattern_str.len - 1] != pattern_str[^1]:
            let badChar = search_str[ i + search_last_char]

            if badChar in table:
                let shift = table[badChar]
                i += shift
            else:
                i += table['*']
        else:
            echo "Pattern not found"
            break
        
        
grep(testStr, pattern)