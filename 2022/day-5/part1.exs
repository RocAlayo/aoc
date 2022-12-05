[cratesRaw, directionsRaw] = "./full.txt"
  |> File.read!()
  |> String.split("\n\n")

crates = cratesRaw
  |> String.split("\n")
  |> Enum.drop(-1)
  |> Enum.map(fn line -> String.graphemes(line)
    |> Enum.chunk_every(4)
    |> Enum.map(fn row -> row
      |> Enum.filter(&(&1 != " "))
      |> Enum.filter(&(&1 != "]"))
      |> Enum.filter(&(&1 != "["))
    end)
  end)
  |> List.zip
  |> Enum.map(&Tuple.to_list/1)
  |> Enum.map(&List.flatten/1)

tranformDirections = fn ({number, cratePositions}) ->
  cratePositions
    |> Enum.map(&(&1 - 1))
    |> List.duplicate(number)
end

directions = directionsRaw
  |> String.split("\n")
  |> Enum.map(fn direction -> String.split(direction)
    |> Enum.map(&Integer.parse(&1))
    |> Enum.filter(&(&1 != :error))
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.map(&Enum.at(&1, 0))
    |> List.pop_at(0)
    |> tranformDirections.()
  end)
  |> List.flatten
  |> Enum.chunk_every(2)

defmodule Recursion do
  def print_multiple_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end

  def tranformStorage(directions, crates) when length(directions) > 0 do
    IO.inspect(directions)
    IO.inspect(crates)
    IO.puts("---------------")
    [from, to] = Enum.at(directions, 0)
    {transitionCrate, newStack} = crates
      |> Enum.at(from)
      |> List.pop_at(0)
    resultantCrates = crates
      |> List.replace_at(from, newStack)
      |> List.replace_at(to, [transitionCrate] ++ Enum.at(crates, to))
    tranformStorage(List.delete_at(directions, 0), resultantCrates)
  end

  def tranformStorage(_, crates) do
    IO.puts("---------------")
    crates
      |> Enum.map(&Enum.at(&1, 0))
      |> Enum.join
      |> IO.puts
  end
end

Recursion.tranformStorage(directions, crates)
