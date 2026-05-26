defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    do_slices(s, size, [])
  end

  defp do_slices(_, size, _) when size <= 0, do: []

  defp do_slices(s, size, acc) do
    case s do
      <<head::binary-size(size), _::bitstring>> ->
        <<_::binary-size(1), next::bitstring>> = s
        do_slices(next, size, [head | acc])

      _ ->
        :lists.reverse(acc)
    end
  end
end
