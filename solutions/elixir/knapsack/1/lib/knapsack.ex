defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(items, maximum_weight) do
    take_or_leave(items, maximum_weight)
  end

  defp take_or_leave(items, maximum_weight, weight \\ 0, value \\ 0)

  defp take_or_leave([], maximum_weight, weight, value) do
    if(weight <= maximum_weight, do: value, else: 0)
  end

  defp take_or_leave([h | t], maximum_weight, weight, value) do
    max(
      take_or_leave(t, maximum_weight, weight + h.weight, value + h.value),
      take_or_leave(t, maximum_weight, weight, value)
    )
  end
end
