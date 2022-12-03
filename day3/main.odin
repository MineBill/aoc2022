package main

import "core:fmt"
import "core:os"
import "core:strings"

get_score :: proc(r: u8) -> int {
    switch r {
        case 'A'..='Z':
        return cast(int)r - 38
        case 'a'..='z':
        return cast(int)r - 96
    }
    unreachable()
}

main :: proc() {
    data, ok := os.read_entire_file("day3/input.txt")
    if !ok {
        fmt.println("Cannot find file")
        return
    }
    defer delete(data)

    it := string(data)

    total_sum := 0
    for line in strings.split_lines_iterator(&it) {
        half := len(line) / 2
        first := line[0:half]
        second := line[half:]

        score := 0
        have_seen := make(map[rune]bool)
        defer delete(have_seen)

        for i in first {
            if i in have_seen {
                continue
            }
            have_seen[i] = true
            for j in second {
                if i == j {
                    score += get_score(cast(u8)i)
                    break
                }
            }
        }
        total_sum += score
    }

    it = string(data)
    total_sum = 0
    group := 0
    lines := [3]string{}
    for line in strings.split_lines_iterator(&it) {
        if group == 2 {
            lines[group] = line
            group = 0
            score := 0
            have_seen := make(map[rune]bool)
            defer delete(have_seen)
            for i in lines[0] {
                if i in have_seen {
                    continue
                }
                have_seen[i] = true
                have_seen_j := make(map[rune]bool)
                defer delete(have_seen_j)

                for j in lines[1] {
                    if j in have_seen_j {
                        continue
                    }
                    have_seen_j[j] = true
                    for k in lines[2] {
                        if i == j && i == k {
                            score += get_score(cast(u8)i)
                            break
                        }
                    }
                }
            }
            total_sum += score
        } else {
            lines[group] = string(line)
            group += 1
        }
    }
    fmt.print(total_sum)
}
