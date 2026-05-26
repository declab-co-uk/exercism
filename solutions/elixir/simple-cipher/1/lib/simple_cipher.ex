defmodule SimpleCipher do
  defp cipher(input, key, function) do
    f =
      case function do
        :decode -> &-/2
        _ -> &+/2
      end

    key
    |> to_charlist()
    |> Stream.cycle()
    |> Enum.zip_with(
      to_charlist(input),
      fn x, y ->
        f.(y - ?a, x - ?a)
        |> Integer.mod(26)
        |> then(&(&1 + ?a))
      end
    )
    |> to_string()
  end

  def encode(plaintext, key) do
    cipher(plaintext, key, :encode)
  end

  def decode(ciphertext, key) do
    cipher(ciphertext, key, :decode)
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length \\ 100) do
    for _ <- 0..(length - 1), into: "" do
      <<:rand.uniform(26) - 1 + ?a>>
    end
  end
end
