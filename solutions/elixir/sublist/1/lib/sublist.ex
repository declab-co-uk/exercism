defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(a, a), do: :equal

  def compare(a, b) do
    len_a = length(a)
    len_b = length(b)

    sublist = if len_a < len_b, do: contains_sublist?(a, b), else: false
    superlist = if len_a > len_b, do: contains_sublist?(b, a), else: false

    cond do
      sublist -> :sublist
      superlist -> :superlist
      true -> :unequal
    end
  end

  defp contains_sublist?(_, []), do: false

  defp contains_sublist?(a, [_ | bt] = b) do
    if match_first?(a, b), do: true, else: contains_sublist?(a, bt)
  end

  defp match_first?([], _), do: true
  defp match_first?([x | at], [x | bt]), do: match_first?(at, bt)
  defp match_first?(_, _), do: false
end
