defmodule Secrets do
  require Bitwise

  def secret_add(secret) do
    fn x -> x + secret end
  end

  def secret_subtract(secret) do
    fn x -> x - secret end
  end

  def secret_multiply(secret) do
    fn x -> x * secret end
  end

  def secret_divide(secret) do
    &div(&1, secret)
  end

  def secret_and(secret) do
    &Bitwise.band(secret, &1)
  end

  def secret_xor(secret) do
    &Bitwise.bxor(secret, &1)
  end

  def secret_combine(secret_function1, secret_function2) do
    fn input -> input |> secret_function1.() |> secret_function2.() end
  end
end
