defmodule CaptainsLog do
  @planetary_classes {"D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"}

  def random_planet_class() do
    elem(@planetary_classes, :rand.uniform(10) - 1)
  end

  def random_ship_registry_number() do
    "NCC-#{999 + :rand.uniform(9000)}"
  end

  def random_stardate() do
    40000 + (:rand.uniform() + 1) * 1000
  end

  def format_stardate(stardate) do
    "~.1f"
    |> :io_lib.format([stardate])
    |> to_string()
  end
end
