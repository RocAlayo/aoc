"./full.txt"
  |> File.read!()
  |> String.split("\n")
  |> Enum.map(fn sections -> String.split(sections, ",")
    |> Enum.map(fn section -> String.split(section, "-")
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(fn (sections) -> apply(&Range.new(&1,&2), sections) end)
    |> Enum.map(&Enum.to_list(&1))
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection(&1, &2))
    |> MapSet.to_list
    |> length
  end)
  |> Enum.filter(&(&1 > 0))
  |> Enum.count
  |> IO.inspect
