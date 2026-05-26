defmodule KitchenCalculator do
  def get_volume({_, volume}) do
    volume
  end

  def to_milliliter(volume_pair) do
    case volume_pair do
      {:cup, volume} -> {:milliliter, volume * 240}
      {:fluid_ounce, volume} -> {:milliliter, volume * 30}
      {:teaspoon, volume} -> {:milliliter, volume * 5}
      {:tablespoon, volume} -> {:milliliter, volume * 15}
      {:milliliter, volume} -> {:milliliter, volume}
    end
  end

  # Just realised this was a function matching test not a case test, keeping both as why not
  def from_milliliter({:milliliter, volume}, :cup), do: {:cup, volume / 240}
  def from_milliliter({:milliliter, volume}, :fluid_ounce), do: {:fluid_ounce, volume / 30}
  def from_milliliter({:milliliter, volume}, :teaspoon), do: {:teaspoon, volume / 5}
  def from_milliliter({:milliliter, volume}, :tablespoon), do: {:tablespoon, volume / 15}
  def from_milliliter({:milliliter, volume}, :milliliter), do: {:milliliter, volume}

  def convert(volume_pair, unit) do
    to_milliliter(volume_pair) |> from_milliliter(unit)
  end
end
