defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    have_your_card = collection |> MapSet.member?(your_card)
    have_their_card = collection |> MapSet.member?(their_card)

    {have_your_card and not have_their_card,
     collection |> MapSet.delete(your_card) |> MapSet.put(their_card)}
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    MapSet.new(cards) |> MapSet.to_list() |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection) |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []

  def boring_cards([h | t]) do
    Enum.reduce(t, h, fn collection, acc -> MapSet.intersection(collection, acc) end)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0

  def total_cards([h | t]) do
    Enum.reduce(t, h, fn collection, acc -> MapSet.union(collection, acc) end)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    {shiny, not_shiny} =
      MapSet.split_with(collection, fn x -> String.starts_with?(x, "Shiny") end)

    {shiny |> MapSet.to_list() |> Enum.sort(), not_shiny |> MapSet.to_list() |> Enum.sort()}
  end
end
