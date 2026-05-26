defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    get_bit_size(0, 1, color_count)
  end

  defp get_bit_size(bits, count, color_count) when count >= color_count do
    bits
  end

  defp get_bit_size(bits, count, color_count) do
    get_bit_size(bits + 1, count * 2, color_count)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bits = palette_bit_size(color_count)
    <<pixel_color_index::size(bits), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _) do
    nil
  end

  def get_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    <<first::size(bits), _::bitstring>> = picture
    first
  end

  def drop_first_pixel(<<>>, _) do
    <<>>
  end

  def drop_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    <<_::size(bits), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
