sectionIsFullyContained = fn (sectionA, sectionB) ->
  [a1, a2] = sectionA
  [b1, b2] = sectionB
  (a1 <= b1 and a2 >= b2) or (b1 <= a1 and b2 >= a2)
end


"./full.txt"
  |> File.read!()
  |> String.split("\n")
  |> Enum.map(fn sections -> String.split(sections, ",")
    |> Enum.map(fn section -> String.split(section, "-")
      |> Enum.map(&String.to_integer/1)
    end)
  end)
  |> Enum.filter(&apply(sectionIsFullyContained, &1))
  |> Enum.count
  |> IO.inspect
