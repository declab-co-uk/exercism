defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> do_transpose([])
    |> clean_trailing()
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  defp do_transpose([], acc), do: acc

  defp do_transpose(lists, acc) do
    validated =
      lists
      |> tails()
      |> all_empty()

    do_transpose(validated, [heads(lists) | acc])
  end

  defp heads(enumerable) do
    Enum.map(enumerable, fn
      [h | _] -> h
      [] -> :pad
    end)
  end

  defp tails(enumerable) do
    Enum.map(enumerable, fn
      [_ | t] -> t
      [] -> []
    end)
  end

  defp all_empty(list), do: if(Enum.all?(list, &(&1 == [])), do: [], else: list)

  defp clean_trailing(lists) do
    for list <- lists do
      list
      |> Enum.reverse()
      |> Enum.drop_while(&(&1 == :pad))
      |> Enum.reverse()
      |> Enum.map_join(fn
        :pad -> "\s"
        x -> x
      end)
    end
  end
end
