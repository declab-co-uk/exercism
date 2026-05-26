defmodule Matrix do
  defstruct [:rows, :cols]

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    rows =
      input
      |> String.split("\n")
      |> Enum.map(
        &(String.split(&1)
          |> Enum.map(fn x -> String.to_integer(x) end))
      )

    %__MODULE__{rows: rows, cols: Enum.zip_with(rows, & &1)}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{rows: rows}), do: rows |> Enum.map(&Enum.join(&1, " ")) |> Enum.join("\n")

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{rows: rows}), do: rows

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%Matrix{rows: rows}, index), do: Enum.at(rows, index - 1)

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%Matrix{cols: cols}), do: cols

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%Matrix{cols: cols}, index), do: Enum.at(cols, index - 1)
end
