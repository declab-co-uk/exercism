defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]

  def rows(""), do: []

  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn row ->
      String.split(row, " ")
      |> Enum.map(fn char -> String.to_integer(char) end)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows()
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    MapSet.intersection(
      MapSet.new(create_saddle_maps(rows(str))),
      MapSet.new(create_saddle_maps(columns(str), :col))
    )
    |> MapSet.to_list()
  end

  defp create_saddle_maps(matrix, axis \\ :row) do
    matrix
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y_index} ->
      target = if(axis == :row, do: Enum.max(row), else: Enum.min(row))

      row
      |> Enum.with_index()
      |> Enum.filter(fn {val, _} -> val == target end)
      |> Enum.map(fn {_, x_index} ->
        if axis == :row,
          do: {y_index + 1, x_index + 1},
          else: {x_index + 1, y_index + 1}
      end)
    end)
  end
end
