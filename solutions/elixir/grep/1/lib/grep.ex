defmodule Grep do
  @available_flags ["-n", "-l", "-i", "-v", "-x"]

  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    flags =
      MapSet.intersection(
        MapSet.new(@available_flags),
        MapSet.new(flags)
      )

    regex_pattern =
      Regex.compile!(
        if(MapSet.member?(flags, "-x"), do: "^#{pattern}$", else: pattern),
        if(MapSet.member?(flags, "-i"), do: "i", else: "")
      )

    matches =
      Enum.flat_map(files, fn file ->
        File.stream!(file)
        |> Enum.with_index()
        |> Enum.map(fn {text, index} ->
          {file, index + 1, text, Regex.match?(regex_pattern, text)}
        end)
      end)
      |> Enum.filter(fn {_, _, _, bool} ->
        if MapSet.member?(flags, "-v"), do: not bool, else: bool
      end)

    if MapSet.member?(flags, "-l") do
      Enum.uniq_by(matches, fn {file, _, _, _} -> file end)
      |> Enum.map(fn {file, _, _, _} -> file <> "\n" end)
      |> Enum.join()
    else
      file_len = length(files)
      require_line_num = MapSet.member?(flags, "-n")

      Enum.map(matches, fn {file, line, text, _} ->
        file_prefix = if file_len > 1, do: file <> ":", else: ""
        line_prefix = if require_line_num, do: Integer.to_string(line) <> ":", else: ""
        "#{file_prefix}#{line_prefix}#{text}"
      end)
      |> Enum.join()
    end
  end
end
