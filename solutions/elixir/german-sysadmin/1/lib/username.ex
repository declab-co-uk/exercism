defmodule Username do
  def sanitize(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

    username
    |> Stream.flat_map(fn x ->
      case x do
        228 -> ~c"ae"
        246 -> ~c"oe"
        252 -> ~c"ue"
        223 -> ~c"ss"
        val -> [val]
      end
    end)
    |> Enum.filter(&((&1 <= 122 and &1 >= 97) or &1 == 95))
  end
end
