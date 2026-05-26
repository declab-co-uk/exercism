defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
    to_binary(number)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def to_binary(number) when number == 0 do
    []
  end

  def to_binary(number) when number > 0 do
    n = div(number, 2)
    b = rem(number, 2)
    [b | to_binary(n)]
  end
end
