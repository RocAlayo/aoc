
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
  |> Enum.map(&String.graphemes/1)
  |> Enum.map(&MapSet.new/1)
  |> Enum.chunk_every(3)
  |> Enum.map(fn rucksack -> rucksack
    |> Enum.reduce(&MapSet.intersection(&1, &2))
  end)
  |> Enum.map(&MapSet.to_list/1)
  |> List.flatten
  |> Enum.map(&(convertToPriority.(&1)))
  |> Enum.reduce(0, &(&1 + &2))
  |> IO.inspect
