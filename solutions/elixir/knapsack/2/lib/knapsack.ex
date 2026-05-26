defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(items, maximum_weight) do
    {val, _} = take_or_leave(items, maximum_weight)
    val
  end

  defp take_or_leave(items, capacity, memo \\ %{})

  defp take_or_leave([], _, memo), do: {0, memo}

  defp take_or_leave([h | _], capacity, memo) when capacity - h.weight < 0, do: {0, memo}

  defp take_or_leave([h | t], capacity, memo) do
    case Map.get(memo, {capacity, t}) do
      nil ->
        {take_value, memo} = take_or_leave(t, capacity - h.weight, memo)
        {leave_value, memo} = take_or_leave(t, capacity, memo)
        value = max(take_value + h.value, leave_value)
        memo = Map.put(memo, {capacity, t}, value)
        {value, memo}

      cache ->
        {cache, memo}
    end
  end
end
