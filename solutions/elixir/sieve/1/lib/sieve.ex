defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []

  def primes_to(limit) do
    iter = 2..limit

    range_map =
      iter
      |> Map.new(&{&1, true})

    for num <- iter,
        reduce: range_map do
      acc ->
        if Map.get(acc, num) do
          mark_multiples(limit, num, acc)
        else
          acc
        end
    end
    |> Map.filter(fn {_, value} -> value end)
    |> Map.keys()
    |> Enum.sort()
  end

  defp mark_multiples(limit, step, map) do
    for item <- step..limit//step,
        item > step,
        reduce: map do
      acc -> Map.put(acc, item, false)
    end
  end
end
