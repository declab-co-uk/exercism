defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors_for(number) |> :lists.reverse() |> IO.inspect()
  end

  def do_factors_for(number, acc \\ [], div \\ 2)
  def do_factors_for(number, acc, _) when number == 1, do: acc

  def do_factors_for(number, acc, div) when rem(number, div) == 0,
    do: do_factors_for(div(number, div), [div | acc], div)

  def do_factors_for(number, acc, div) when div * div > number, do: [number | acc]
  def do_factors_for(number, acc, div), do: do_factors_for(number, acc, div + 1)
end
