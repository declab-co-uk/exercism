defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({a, _}), do: a

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_, b}), do: b

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(x, y) do
    {a, b} = to_complex(x)
    {c, d} = to_complex(y)
    {a * c - b * d, b * c + a * d}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(x, y) do
    {a, b} = to_complex(x)
    {c, d} = to_complex(y)
    {a + c, b + d}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(x, y) do
    {a, b} = to_complex(x)
    {c, d} = to_complex(y)

    {a - c, b - d}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(x, y) do
    {a, b} = to_complex(x)
    {c, d} = to_complex(y)
    {(a * c + b * d) / (c ** 2 + d ** 2), (b * c - a * d) / (c ** 2 + d ** 2)}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs(x) do
    {a, b} = to_complex(x)
    :math.sqrt(a ** 2 + b ** 2)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate(x) do
    {a, b} = to_complex(x)
    {a, -b}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp(x) do
    {a, b} = to_complex(x)
    {:math.exp(a) * :math.cos(b), :math.exp(a) * :math.sin(b)}
  end

  defp to_complex({a, b}), do: {a, b}
  defp to_complex(a) when is_number(a), do: {a, 0}
end
