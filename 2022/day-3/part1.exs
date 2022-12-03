
<<number_upper_a::utf8>> = "A"
<<number_down_a::utf8>> = "a"

convertToPriority = fn letter ->
  <<letter_number::utf8>> = letter
  if letter_number >= number_down_a do
    (letter_number - number_down_a) + 1
  else
    (letter_number - number_upper_a) + 27
  end
end


"./full.txt"
  |> File.read!()
  |> String.split("\n")
  |> Enum.map(&String.split_at(&1, trunc(String.length(&1)/2)))
  |> Enum.map(fn (rucksack) -> Tuple.to_list(rucksack)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&MapSet.new/1)
  end)
  |> Enum.map(&apply(fn (a,b) -> MapSet.intersection(a, b) end, &1))
  |> Enum.map(&MapSet.to_list/1)
  |> List.flatten
  |> Enum.map(&(convertToPriority.(&1)))
  |> Enum.reduce(0, &(&1 + &2))
  |> IO.inspect
