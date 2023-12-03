package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func open_file(path string) *os.File {
	file, err := os.Open(path)
	if err != nil {
		log.Fatal(err)
	}
	return file
}

func color_to_index(color string) int {
	switch color {
	case "red":
		return 0
	case "green":
		return 1
	case "blue":
		return 2
	}
	return -1
}

func parse_game(line string) [][]int {
	string_sets := strings.Split(line, ": ")
	sets := strings.Split(string_sets[1], "; ")
	var game = make([][]int, len(sets))
	for index, set := range sets {
		cubes := strings.Split(set, ", ")
		game[index] = []int{0, 0, 0}
		for _, cube := range cubes {
			parsed_cube := strings.Split(cube, " ")
			num, err := strconv.Atoi(parsed_cube[0])
			if err != nil {
				panic(err)
			}
			game[index][color_to_index(parsed_cube[1])] = num
		}
	}
	return game
}

func get_power(game [][]int) int {
	maximum := []int{0, 0, 0}
	for _, set := range game {
		for index, number := range set {
			if number > maximum[index] {
				maximum[index] = number
			}
		}
	}

	power := 1
	for _, number := range maximum {
		power *= number
	}
	return power
}

func main() {
	file := open_file("./input.txt")
	scanner := bufio.NewScanner(file)
	var sum int = 0
	for scanner.Scan() {
		line := scanner.Text()
		var game = parse_game(line)
		sum += get_power(game)
	}
	fmt.Println("total:", sum)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
