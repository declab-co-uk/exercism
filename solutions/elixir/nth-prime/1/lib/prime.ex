defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer

  def nth(count) when count >= 1 do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.transform([], fn x, acc ->
      has_divisor =
        acc
        |> Stream.take_while(fn p -> p * p <= x end)
        |> Enum.any?(fn p -> rem(x, p) == 0 end)

      if has_divisor, do: {[], acc}, else: {[x], acc ++ [x]}
    end)
    |> Enum.at(count - 1)
  end
end
