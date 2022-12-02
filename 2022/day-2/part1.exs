decidePoints = fn (turn) ->
  case turn do
    ["A", "X"] -> 1 + 3
    ["A", "Y"] -> 2 + 6
    ["A", "Z"] -> 3 + 0
    ["B", "X"] -> 1 + 0
    ["B", "Y"] -> 2 + 3
    ["B", "Z"] -> 3 + 6
    ["C", "X"] -> 1 + 6
    ["C", "Y"] -> 2 + 0
    ["C", "Z"] -> 3 + 3
  end
end

"./full.txt"
  |> File.read!()
  |> String.split("\n")
  |> Enum.map(&String.split/1)
  |> Enum.map(decidePoints)
  |> Enum.reduce(0, &(&1 + &2))
  |> IO.inspect
