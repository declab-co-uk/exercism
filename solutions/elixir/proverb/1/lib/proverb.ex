defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]) do
    ""
  end

  def recite([h | _] = strings) do
    do_recite(strings) <> "And all for the want of a #{h}.\n"
  end

  defp do_recite([_]), do: ""

  defp do_recite([one, two | t]) do
    "For want of a #{one} the #{two} was lost.\n" <> do_recite([two | t])
  end
end
