"./full.txt"
  |> File.read!()
  |> String.split("\n")
  |> Enum.chunk_by(&(&1 == ""))
  |> Enum.filter(
      fn array ->
        Enum.all?(array, &(String.length(&1) > 0))
      end
   )
  |> Enum.map(
      fn array ->
        array
          |> Enum.map(&String.to_integer/1)
          |> Enum.reduce(0, &(&1 + &2))
      end
    )
  |> Enum.sort(&(&1 >= &2))
  |> Enum.slice(0..2)
  |> Enum.reduce(0, &(&1 + &2))
  |> IO.inspect
