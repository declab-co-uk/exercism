defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @plants %{
    ?G => :grass,
    ?C => :clover,
    ?R => :radishes,
    ?V => :violets
  }

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    window_plants =
      info_string
      |> String.split("\n")
      |> Enum.map(fn list ->
        list
        |> String.to_charlist()
        |> Enum.chunk_every(2)
      end)
      |> Enum.zip_with(fn [[a, b], [c, d]] ->
        Enum.map([a, b, c, d], fn p -> Map.get(@plants, p) end)
      end)

    Map.merge(
      Map.from_keys(student_names, {}),
      student_names
      |> Enum.sort()
      |> Enum.zip(window_plants)
      |> Map.new(fn {name, plants} ->
        {name, List.to_tuple(plants)}
      end)
    )
  end
end
