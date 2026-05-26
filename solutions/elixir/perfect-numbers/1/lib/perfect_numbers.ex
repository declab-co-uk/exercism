defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number <= 0,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) do
    case do_get_divisors(number) |> Enum.sum() do
      out when out == number -> {:ok, :perfect}
      out when out > number -> {:ok, :abundant}
      out when out < number -> {:ok, :deficient}
    end
  end

  defp do_get_divisors(number, x \\ 1)

  defp do_get_divisors(1, _), do: []

  defp do_get_divisors(number, x) when x * x <= number do
    case rem(number, x) do
      0 when x * x == number -> [x | do_get_divisors(number, x + 1)]
      0 when x == 1 -> [x | do_get_divisors(number, x + 1)]
      0 -> [x, div(number, x) | do_get_divisors(number, x + 1)]
      _ -> do_get_divisors(number, x + 1)
    end
  end

  defp do_get_divisors(_, _), do: []
end
