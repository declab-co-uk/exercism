defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([_ | t] = _) do
    t
  end

  def first([h | _] = _) do
    h
  end

  def count(list) do
    Enum.count(list)
  end

  def functional_list?(list) do
    has_elixir = Enum.find(list, false, fn x -> x == "Elixir" end)
    !!has_elixir
  end
end
