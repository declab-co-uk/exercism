defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence |> String.graphemes() |> do_isogram(MapSet.new())
  end

  defp do_isogram([], _), do: true

  defp do_isogram([h | t], map) when h == " " or h == "-", do: do_isogram(t, map)

  defp do_isogram([h | t], map) do
    h = String.upcase(h)

    if MapSet.member?(map, h) do
      false
    else
      do_isogram(t, MapSet.put(map, h))
    end
  end
end
