defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    if is_valid_keys?(a) do
      message
      |> String.downcase()
      |> String.to_charlist()
      |> Enum.filter(fn char ->
        char in ?a..?z or char in ?0..?9
      end)
      |> Enum.map(fn
        char when char in ?0..?9 -> char
        char -> Integer.mod(a * (char - ?a) + b, 26) + ?a
      end)
      |> Enum.chunk_every(5)
      |> Enum.map_join(" ", fn cl -> to_string(cl) end)
      |> then(&{:ok, &1})
    else
      {:error, "a and m must be coprime."}
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), encrypted :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    if is_valid_keys?(a) do
      mmi = Enum.find(1..25, fn n -> Integer.mod(a * n, 26) == 1 end)

      encrypted
      |> String.to_charlist()
      |> Enum.reject(&(&1 == ?\s))
      |> Enum.map(fn
        char when char in ?0..?9 -> char
        char -> Integer.mod(mmi * (char - ?a - b), 26) + ?a
      end)
      |> to_string()
      |> then(&{:ok, &1})
    else
      {:error, "a and m must be coprime."}
    end
  end

  defp is_valid_keys?(a) do
    Integer.gcd(a, 26) == 1
  end
end
