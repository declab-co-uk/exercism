defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) do
    encode_binary(message)
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data) do
    case decode_binary(received_data) do
      :error ->
        {:error, "wrong parity"}

      val ->
        size = div(bit_size(val), 8)
        <<h::binary-size(size), _::bitstring>> = val
        {:ok, h}
    end
  end

  def encode_binary(bits, acc \\ "")

  def encode_binary("", acc), do: acc

  def encode_binary(<<h::size(7), t::bits>>, acc) do
    encode_binary(t, acc <> set_parity_bit(h))
  end

  def encode_binary(bits, acc) do
    <<h::7>> = <<bits::bitstring, 0::size(7 - bit_size(bits))>>
    acc <> set_parity_bit(h)
  end

  defp set_parity_bit(bits) do
    bits
    |> Integer.digits(2)
    |> Enum.count(&(&1 == 1))
    |> rem(2)
    |> then(fn bit -> <<bits::size(7), bit::size(1)>> end)
  end

  def decode_binary(bits, acc \\ "")

  def decode_binary(_, :error), do: :error

  def decode_binary(<<h::8, t::binary>>, acc) do
    <<bits::size(7), _::size(1)>> = <<h>>

    acc = if validate_parity_bit(h), do: <<acc::bitstring, bits::size(7)>>, else: :error

    decode_binary(t, acc)
  end

  def decode_binary(_, acc), do: acc

  defp validate_parity_bit(byte) do
    0 ==
      byte
      |> Integer.digits(2)
      |> Enum.count(&(&1 == 1))
      |> rem(2)
  end
end
