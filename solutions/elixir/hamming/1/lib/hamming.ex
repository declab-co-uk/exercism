defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    do_hamming_distance(strand1, strand2)
  end

  defp do_hamming_distance([], [_ | _]), do: {:error, "strands must be of equal length"}
  defp do_hamming_distance([_ | _], []), do: {:error, "strands must be of equal length"}
  defp do_hamming_distance([], []), do: {:ok, 0}

  defp do_hamming_distance([h1 | t1], [h2 | t2]) do
    inc = if h1 == h2, do: 0, else: 1

    with {:ok, val} <- do_hamming_distance(t1, t2) do
      {:ok, val + inc}
    end
  end
end
