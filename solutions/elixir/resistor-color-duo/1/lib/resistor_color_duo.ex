defmodule ResistorColorDuo do
  @resistances [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([a, b | _]) do
    (Integer.to_string(value([a])) <> Integer.to_string(value([b]))) |> String.to_integer()
  end

  def value([a]) do
    Enum.find_index(@resistances, &(&1 == a))
  end
end
