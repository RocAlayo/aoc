content = File.read!("./full.txt")
sum = fn x, acc -> x + acc end
reduceToSum = fn array ->  array
  |> Enum.map(&String.to_integer/1)
  |> Enum.reduce(0, sum) end
isNotEmpty = fn b -> String.length(b) > 0 end
arrayNotEmpty = fn (a) -> Enum.all?(a, isNotEmpty) end


num =  content
  |> String.split("\n")
  |> Enum.chunk_by(&(&1 == ""))
  |> Enum.filter(arrayNotEmpty)
  |> Enum.map(reduceToSum)
  |> Enum.sort(&(&1 >= &2))
  |> Enum.slice(0..0)
  |> Enum.reduce(0, sum)


IO.inspect(num)
