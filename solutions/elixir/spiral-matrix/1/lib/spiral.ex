defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))

  def matrix(0), do: []

  def matrix(dimension) do
    create_matrix_map(dimension)
    |> create_spiral_map({0, 0}, 1, {1, 0}, dimension)
    |> convert_map_to_matrix()
  end

  defp create_matrix_map(dimension) do
    for x <- 0..(dimension - 1), y <- 0..(dimension - 1), into: %{} do
      {{x, y}, :empty}
    end
  end

  defp convert_map_to_matrix(map) do
    map
    |> Enum.group_by(fn {{_, y}, _} -> y end)
    |> Enum.sort_by(fn {y, _} -> y end)
    |> Enum.map(fn {_, cells} ->
      cells
      |> Enum.sort_by(fn {{x, _}, _} -> x end)
      |> Enum.map(fn {_, val} -> val end)
    end)
  end

  defp create_spiral_map(map, _, digit, _, dimension)
       when digit > dimension * dimension, do: map

  defp create_spiral_map(map, {pos_x, pos_y}, digit, {dir_x, dir_y} = vec, dimension) do
    map =
      Map.put(map, {pos_x, pos_y}, digit)

    next_cell = {pos_x + dir_x, pos_y + dir_y}

    case Map.get(map, next_cell) do
      :empty ->
        create_spiral_map(map, next_cell, digit + 1, vec, dimension)

      _ ->
        {new_dir_x, new_dir_y} = new_vec = turn(vec)

        create_spiral_map(
          map,
          {pos_x + new_dir_x, pos_y + new_dir_y},
          digit + 1,
          new_vec,
          dimension
        )
    end
  end

  defp turn({1, 0}), do: {0, 1}
  defp turn({0, 1}), do: {-1, 0}
  defp turn({-1, 0}), do: {0, -1}
  defp turn({0, -1}), do: {1, 0}
end
