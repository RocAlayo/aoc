package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
)

var mapToInt = map[string]int{
	"one":   1,
	"two":   2,
	"three": 3,
	"four":  4,
	"five":  5,
	"six":   6,
	"seven": 7,
	"eight": 8,
	"nine":  9,
	"zero":  0,
	"0":     0,
	"1":     1,
	"2":     2,
	"3":     3,
	"4":     4,
	"5":     5,
	"6":     6,
	"7":     7,
	"8":     8,
	"9":     9,
}

func getAllMatches(text string) []int {
	var array []int = make([]int, len(text))
	for i := range array {
		array[i] = -1
	}

	for k := range mapToInt {
		r := regexp.MustCompile(k)
		indexes := r.FindAllStringIndex(text, -1)
		for _, index := range indexes {
			array[index[0]] = mapToInt[k]
		}
	}

	final := []int{}

	for i := range array {
		if array[i] >= 0 {
			final = append(final, array[i])
		}
	}

	return final
}

func main() {
	file, err := os.Open("./input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	var sum int = 0

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		matches := getAllMatches(scanner.Text())
		sum += (matches[0] * 10) + matches[len(matches)-1]
	}
	fmt.Println("total:", sum)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
