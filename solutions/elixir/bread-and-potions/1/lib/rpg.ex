defmodule RPG do
  defprotocol Edible do
    def eat(item, character)
  end

  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defimpl Edible, for: LoafOfBread do
    def eat(%RPG.LoafOfBread{}, %Character{health: health} = character) do
      {nil, %Character{character | health: health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%RPG.ManaPotion{strength: strength}, %RPG.Character{mana: mana} = character) do
      {%RPG.EmptyBottle{}, %RPG.Character{character | mana: mana + strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(%RPG.Poison{}, %Character{} = character) do
      {%RPG.EmptyBottle{}, %RPG.Character{character | health: 0}}
    end
  end
end
