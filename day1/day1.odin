package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

main :: proc() {
    data, ok := os.read_entire_file("day1/input.txt")
    if !ok {
        fmt.println("Cannot find file")
        return
    }
    defer delete(data)

    it := string(data)
    /* max := 0 */
    max := [3]int{}

    count := 0
    for line in strings.split_lines_iterator(&it) {
        if line == "" {
            if count > max[0] {
                max[2] = max[1]
                max[1] = max[0]
                max[0] = count
            }
            count = 0
            continue
        }
        calories, _ := strconv.parse_int(line)
        count += calories
    }
    fmt.println(max[0] + max[1] + max[2])
}
