package main

import "core:fmt"
import "core:os"
import "core:strings"

score_table := map[u8]int {
    'A' = 1,
    'B' = 2,
    'C' = 3,
}

Outcome :: enum {
    Draw,
    Won,
    Lost,
}

outcome :: proc(p1, p2: u8) -> Outcome {
    switch p1 {
        case 'A':
        switch p2 {
            case 'X':
            return .Draw
            case 'Y':
            return .Won
            case 'Z':
            return .Lost
        }
        case 'B':
        switch p2 {
            case 'X':
            return .Lost
            case 'Y':
            return .Draw
            case 'Z':
            return .Won
        }
        case 'C':
        switch p2 {
            case 'X':
            return .Won
            case 'Y':
            return .Lost
            case 'Z':
            return .Draw
        }
    }
    return .Draw
}

get_score_from_outcome :: proc(p1, p2: u8) -> int {
    switch p1 {
        case 'A':
        switch p2 {
            case 'X':
            return score_table['C']
            case 'Y':
            return score_table['A']
            case 'Z':
            return score_table['B']
        }
        case 'B':
        switch p2 {
            case 'X':
            return score_table['A']
            case 'Y':
            return score_table['B']
            case 'Z':
            return score_table['C']
        }
        case 'C':
        switch p2 {
            case 'X':
            return score_table['B']
            case 'Y':
            return score_table['C']
            case 'Z':
            return score_table['A']
        }
    }
    return 0
}

round_score_table := map[u8]int {
    'X' = 0,
    'Y' = 3,
    'Z' = 6,
}

main :: proc() {
    data, ok := os.read_entire_file("day2/input.txt")
    if !ok {
        fmt.println("Cannot find file")
        return
    }
    defer delete(data)

    it := string(data)

    score := 0
    for line in strings.split_lines_iterator(&it) {
        if line == "" {
            continue
        }
        enemy := line[0]
        mine := line[2]
        score += round_score_table[mine]
        score += get_score_from_outcome(enemy, mine)
    }

    fmt.println(score)
}
