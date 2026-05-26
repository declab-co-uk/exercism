defmodule CustomSet do
  defstruct map: :sets.new()
  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    set =
      enumerable
      |> Enum.to_list()
      |> :sets.from_list()

    %__MODULE__{map: set}
  end

  @spec empty?(t) :: boolean
  def empty?(%__MODULE__{map: set}) when set == %{}, do: true
  def empty?(_), do: false

  @spec contains?(t, any) :: boolean
  def contains?(%__MODULE__{map: set}, element), do: :sets.is_element(element, set)

  @spec subset?(t, t) :: boolean
  def subset?(%__MODULE__{map: set1}, %__MODULE__{map: set2}), do: :sets.is_subset(set1, set2)

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%__MODULE__{map: set1}, %__MODULE__{map: set2}), do: :sets.is_disjoint(set1, set2)

  @spec equal?(t, t) :: boolean
  def equal?(%__MODULE__{map: set1}, %__MODULE__{map: set2}) when set1 == set2, do: true
  def equal?(_, _), do: false

  @spec add(t, any) :: t
  def add(%__MODULE__{map: set} = custom_set, element),
    do: %{custom_set | map: :sets.add_element(element, set)}

  @spec intersection(t, t) :: t
  def intersection(%__MODULE__{map: set1} = custom_set, %__MODULE__{map: set2}),
    do: %{custom_set | map: :sets.intersection(set1, set2)}

  @spec difference(t, t) :: t
  def difference(%__MODULE__{map: set1} = custom_set, %__MODULE__{map: set2}),
    do: %{custom_set | map: :sets.subtract(set1, set2)}

  @spec union(t, t) :: t
  def union(%__MODULE__{map: set1} = custom_set, %__MODULE__{map: set2}),
    do: %{custom_set | map: :sets.union(set1, set2)}
end
