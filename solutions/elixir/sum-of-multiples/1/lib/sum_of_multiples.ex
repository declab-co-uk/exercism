defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.reject(&(&1 == 0))
    |> Enum.reduce(MapSet.new(), fn value, acc ->
      MapSet.union(MapSet.new(Range.new(0, limit - 1, value)), acc)
    end)
    |> Enum.sum()
  end
end
