defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """

  # Using recursion
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    graphemes = String.graphemes(string)
    do_encode(graphemes)
  end

  defp do_encode(graphemes, current \\ "", count \\ 0, output \\ "")

  defp do_encode([], current, count, output),
    do: format_output(output, count, current)

  defp do_encode([h | t], current, count, output) when h == current,
    do: do_encode(t, h, count + 1, output)

  defp do_encode([h | t], current, count, output),
    do: do_encode(t, h, 1, format_output(output, count, current))

  defp format_output(output, count, current),
    do: if(count <= 1, do: "#{output}#{current}", else: "#{output}#{count}#{current}")

  # Using stdlib and regex to mix things up from the recursion above
  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.split(~r/\d+\D/, include_captures: true, trim: true)
    |> Enum.map_join(fn x ->
      Regex.replace(~r/(\d+)(\D)/, x, fn _, count, letter ->
        "#{String.duplicate(letter, String.to_integer(count))}"
      end)
    end)
  end
end
