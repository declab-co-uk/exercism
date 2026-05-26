defmodule LogParser do
  def valid_line?(line), do: line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  def split_line(line), do: String.split(line, ~r/<[\~\*\=\-]*>/)
  def remove_artifacts(line), do: String.replace(line, ~r/end-of-line\d+/i, "")

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(\S+)/iu, line) do
      [_, name] -> "[USER] #{name} " <> line
      nil -> line
    end
  end
end
