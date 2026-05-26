defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @book_value 8
  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    basket
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
    |> do_total()
    |> elem(0)
  end

  defp do_total(basket, memo \\ %{})
  defp do_total([], memo), do: {0, memo}

  defp do_total(basket, memo) do
    case Map.fetch(memo, basket) do
      {:ok, cache} ->
        {cache, memo}

      :error ->
        {min_price, final_memo} =
          for x <- 1..min(5, length(basket)),
              reduce: {:infinity, memo} do
            {current, acc} ->
              price = calculate_price(x)
              out = decrement_leading(basket, x)

              {recursive_price, next_memo} = do_total(out, acc)
              total_price = price + recursive_price
              {min(current, total_price), next_memo}
          end

        {min_price, Map.put(final_memo, basket, min_price)}
    end
  end

  defp decrement_leading(basket, count) do
    {items, leftover} = Enum.split(basket, count)

    Enum.map(items, &(&1 - 1))
    |> Enum.concat(leftover)
    |> Enum.reject(&(&1 == 0))
    |> Enum.sort(:desc)
  end

  # value of book * quantity * discount
  defp calculate_price(1), do: @book_value * 1 * 100
  defp calculate_price(2), do: @book_value * 2 * 95
  defp calculate_price(3), do: @book_value * 3 * 90
  defp calculate_price(4), do: @book_value * 4 * 80
  defp calculate_price(5), do: @book_value * 5 * 75
end
