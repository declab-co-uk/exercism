defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]

  def rows(count) do
    do_rows(count) |> Enum.reverse()
  end

  def do_rows(count, i \\ 0, acc \\ [])
  def do_rows(count, i, acc) when i == count, do: acc
  def do_rows(count, 0, acc), do: do_rows(count, 1, [[1] | acc])

  def do_rows(count, i, [h | _] = acc) do
    row =
      [[0 | h], Enum.reverse([0 | h])]
      |> Enum.zip_with(fn [x, y] -> x + y end)

    do_rows(count, i + 1, [row | acc])
  end
end
