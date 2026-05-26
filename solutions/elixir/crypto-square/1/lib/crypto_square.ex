defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    str
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.filter(&(&1 in ?a..?z or &1 in ?0..?9))
    |> zip_chars()
  end

  defp zip_chars([]), do: ""

  defp zip_chars(chars) do
    col =
      length(chars)
      |> :math.sqrt()
      |> ceil()

    chars
    |> Enum.chunk_every(col, col, Stream.cycle([?\s]))
    |> Enum.zip_with(& &1)
    |> Enum.map(&to_string(&1))
    |> Enum.join(" ")
  end
end
