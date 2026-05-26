defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    Enum.map(letter..?A//-1, fn char ->
      for x <- ?A..letter do
        case x do
          val when val == char -> char
          _ -> ?\s
        end
      end
    end)
    |> Enum.map(fn list ->
      mirror_list(list)
      |> to_string()
    end)
    |> mirror_list()
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  defp mirror_list([_ | t] = list), do: Enum.reduce(t, list, fn x, acc -> [x | acc] end)
end
