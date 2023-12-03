package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
)

func main() {
	file, err := os.Open("./input-1.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	var sum int = 0

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		r := regexp.MustCompile(`[0-9]`)
		matches := r.FindAllString(scanner.Text(), -1)
		first, err1 := strconv.Atoi(matches[0])
		if err1 != nil {
			panic(err1)
		}
		last, err2 := strconv.Atoi(matches[len(matches)-1])
		if err2 != nil {
			panic(err2)
		}
		sum += (first * 10) + last
	}
	fmt.Println("total:", sum)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
