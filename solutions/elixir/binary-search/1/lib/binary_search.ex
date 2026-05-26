defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, _key) when is_tuple(numbers) and tuple_size(numbers) == 0 do
    :not_found
  end

  def search(numbers, key) when is_tuple(numbers) do
    bin_search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp bin_search(_numbers, _key, b_pointer, t_pointer) when b_pointer > t_pointer do
    :not_found
  end

  defp bin_search(numbers, key, b_pointer, t_pointer) do
    mid_point = b_pointer + div(t_pointer - b_pointer, 2)

    case elem(numbers, mid_point) do
      value when value == key -> {:ok, mid_point}
      value when value < key -> bin_search(numbers, key, mid_point + 1, t_pointer)
      value when value > key -> bin_search(numbers, key, b_pointer, mid_point - 1)
    end
  end
end
