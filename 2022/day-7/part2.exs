transformToArray = fn (path) ->
  path
    |> Path.split
    |> Enum.reduce({[], path}, fn
      (partOfPath, {filePaths, currentPath}) when partOfPath == "/" -> {filePaths, currentPath}
      (_partOfPath, {filePaths, currentPath}) ->
        {filePaths ++ [Path.dirname(currentPath)], Path.dirname(currentPath)}
    end)
    |> elem(0)
end

folders = "./full.txt"
  |> File.read!()
  |> String.split("\n$")
  |> Enum.map(&String.trim(&1, "$"))
  |> Enum.map(&String.trim(&1))
  |> Enum.map(&String.split(&1, "\n"))
  |> Enum.reduce({[], []}, fn (line, {currentDir, files}) ->
      command = line
        |> Enum.at(0)
        |> String.split
      case command do
        ["cd", dir] when dir == ".." -> {List.delete_at(currentDir, -1), files}
        ["cd", dir] -> {currentDir ++ [dir], files}
        _ ->
          newFiles = line
            |> Enum.filter(&(&1 != "ls" and !String.contains?(&1, "dir ")))
            |> Enum.map(fn fileString ->
              fileArray = fileString
                |> String.split
              {String.to_integer(Enum.at(fileArray, 0)), currentDir ++ [Enum.at(fileArray, 1)]
                |> Enum.join("/")
                |> String.replace("//", "/")
              }
            end)
          {currentDir, files ++ newFiles}
      end
  end)
  |> elem(1)
  |> Enum.reduce(%{}, fn ({size, filePath}, folderMap) ->
    folders = filePath
      |> transformToArray.()

    newFolderMap = Map.new(folders, fn x -> {x, size} end)
    Map.merge(folderMap, newFolderMap, fn (_k, v1, v2) ->
      v1 + v2
    end)
  end)

total_space = 70000000
needed_unused_space = 30000000
maximum_space_occupied = total_space - needed_unused_space
space_to_free = Map.get(folders, "/") - maximum_space_occupied

folders
  |> Map.values
  |> Enum.filter(&(&1 >= space_to_free))
  |> Enum.sort
  |> List.first
  |> IO.inspect
