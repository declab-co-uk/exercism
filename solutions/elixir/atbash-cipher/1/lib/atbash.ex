defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.filter(&(&1 in ?a..?z or &1 in ?0..?9))
    |> Enum.map(&swap/1)
    |> Enum.chunk_every(5)
    |> Enum.map(&to_string/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.to_charlist()
    |> Enum.reject(&(&1 == ?\s))
    |> Enum.map(&swap/1)
    |> to_string()
  end

  def swap(char) when char in ?a..?z, do: ?a + ?z - char
  def swap(char), do: char
end
