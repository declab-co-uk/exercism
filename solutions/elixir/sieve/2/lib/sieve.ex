defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []

  def primes_to(limit), do: sieve(Enum.to_list(2..limit))

  defp sieve([]), do: []

  defp sieve([h | t]) do
    might_be_prime = Enum.reject(t, &(rem(&1, h) == 0))
    [h | sieve(might_be_prime)]
  end
end
