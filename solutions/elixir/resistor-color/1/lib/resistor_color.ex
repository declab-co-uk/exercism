defmodule ResistorColor do
  @doc """
  Return the value of a color band
  """
  @resistances [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
  @spec code(atom) :: integer()
  def code(color) do
    Enum.find_index(@resistances, &(&1 == color))
  end
end
