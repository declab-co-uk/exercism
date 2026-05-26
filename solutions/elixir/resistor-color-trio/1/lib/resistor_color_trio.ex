defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @resistances [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([a, b, c | _]) do
    string_base_num =
      Integer.to_string(Enum.find_index(@resistances, &(a == &1))) <>
        Integer.to_string(Enum.find_index(@resistances, &(b == &1)))

    int_res =
      (String.to_integer(string_base_num) *
         :math.pow(10, Enum.find_index(@resistances, &(c == &1))))
      |> trunc()

    cond do
      int_res == 0 -> {0, :ohms}
      rem(int_res, 1_000_000_000) == 0 -> {div(int_res, 1_000_000_000), :gigaohms}
      rem(int_res, 1_000_000) == 0 -> {div(int_res, 1_000_000), :megaohms}
      rem(int_res, 1_000) == 0 -> {div(int_res, 1_000), :kiloohms}
      true -> {int_res, :ohms}
    end
  end
end
