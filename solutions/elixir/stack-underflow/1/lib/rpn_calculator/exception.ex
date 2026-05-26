defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: #{value}"}
      end
    end
  end

  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide(list) when length(list) < 2, do: raise(StackUnderflowError, "when dividing")
  def divide([x, y]), do: div(y, x)
end
