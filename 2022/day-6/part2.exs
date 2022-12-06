chars = "./full.txt"
  |> File.read!()

chars
  |> String.graphemes
  |> Enum.reduce({[], 0}, fn
    (_, {array, index}) when is_number(array) -> {array, index}
    (_, {array, index}) when length(array) == 14 -> {index, index}
    (char, {array, index}) ->
      if !(char in array) do
        {array ++ [char], index + 1}
      else
        newArray = array ++ [char]
          |> Enum.drop_while(&(&1 != char))
          |> List.delete_at(0)
        {newArray, index + 1}
      end
  end)
  |> elem(0)
  |> IO.inspect
