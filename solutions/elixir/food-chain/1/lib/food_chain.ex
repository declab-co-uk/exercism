defmodule FoodChain do
  @animals ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"]

  @uniq_lines %{
    "spider" => "It wriggled and jiggled and tickled inside her.",
    "bird" => "How absurd to swallow a bird!",
    "cat" => "Imagine that, to swallow a cat!",
    "dog" => "What a hog, to swallow a dog!",
    "goat" => "Just opened her throat and swallowed a goat!",
    "cow" => "I don't know how she swallowed a cow!",
    "horse" => "She's dead, of course!"
  }

  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    do_recite() |> Enum.reverse() |> Enum.slice((start - 1)..(stop - 1)) |> Enum.join("\n")
  end

  def do_recite(animals \\ @animals, prev_animal \\ "", swallowed_acc \\ "", output_acc \\ [])

  def do_recite(["fly" | t], _, swallowed_acc, output_acc) do
    output =
      "I know an old lady who swallowed a fly.\n" <>
        "I don't know why she swallowed the fly. Perhaps she'll die.\n"

    do_recite(t, "fly", swallowed_acc, [output | output_acc])
  end

  def do_recite(["horse" | _], _, _, output_acc),
    do: ["I know an old lady who swallowed a horse.\n" <> "She's dead, of course!\n" | output_acc]

  def do_recite([animal | t], prev_animal, swallowed_acc, output_acc) do
    start_line = "I know an old lady who swallowed a #{animal}.\n"

    uniq_line = Map.get(@uniq_lines, animal, "") <> "\n"

    swallowed_acc =
      if animal == "bird" do
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n"
      else
        "She swallowed the #{animal} to catch the #{prev_animal}.\n"
      end <> swallowed_acc

    fin = "I don't know why she swallowed the fly. Perhaps she'll die.\n"

    output = start_line <> uniq_line <> swallowed_acc <> fin

    do_recite(t, animal, swallowed_acc, [output | output_acc])
  end
end
