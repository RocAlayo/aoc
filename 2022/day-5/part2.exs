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

directions = directionsRaw
  |> String.split("\n")
  |> Enum.map(fn direction -> String.split(direction)
    |> Enum.map(&Integer.parse(&1))
    |> Enum.filter(&(&1 != :error))
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.map(&Enum.at(&1, 0))
  end)

defmodule Recursion do
  def print_multiple_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end

  def tranformStorage(directions, crates) when length(directions) > 0 do
    IO.inspect(directions)
    IO.inspect(crates)
    IO.puts("---------------")
    [number, from, to] = Enum.at(directions, 0)
    transitionCrates = crates
      |> Enum.at(from - 1)
      |> Enum.take(number)
    resultantCrates = crates
      |> List.replace_at(from - 1, Enum.at(crates, from - 1) -- transitionCrates)
      |> List.replace_at(to - 1, transitionCrates ++ Enum.at(crates, to - 1))
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
