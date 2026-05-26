defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer() | :error
  def count(strand, nucleotide) do
    with {:ok, val} <- do_count(strand, nucleotide) do
      val
    end
  end

  defp do_count([], _), do: {:ok, 0}
  defp do_count([h | _], _) when h not in @nucleotides, do: :error

  defp do_count([h | t], nucleotide) when h == nucleotide do
    with {:ok, val} <- do_count(t, nucleotide) do
      {:ok, val + 1}
    end
  end

  defp do_count([_ | t], nucleotide) do
    with {:ok, val} <- do_count(t, nucleotide) do
      {:ok, val}
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map() | :error
  def histogram(strand) do
    with {:ok, val} <- do_histogram(strand) do
      val
    end
  end

  defp do_histogram([]), do: {:ok, %{?A => 0, ?T => 0, ?C => 0, ?G => 0}}
  defp do_histogram([h | _]) when h not in @nucleotides, do: :error

  defp do_histogram([h | t]) do
    with {:ok, val} <- do_histogram(t) do
      {:ok, Map.update(val, h, 1, fn val -> val + 1 end)}
    end
  end
end
