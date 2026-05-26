defmodule BasketballWebsite do
  defp path_to_list(path), do: String.split(path, ".")

  def extract_from_path(data, path), do: do_extract_from_path(data, path_to_list(path))

  defp do_extract_from_path(nil, _), do: nil
  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(data, [h | t]), do: do_extract_from_path(data[h], t)

  def get_in_path(data, path), do: get_in(data, path_to_list(path))
end
