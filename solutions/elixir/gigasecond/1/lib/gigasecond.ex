defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, date} = Date.new(year, month, day)
    {:ok, time} = Time.new(hours, minutes, seconds)
    {:ok, date_time} = DateTime.new(date, time)
    gig_date = DateTime.shift(date_time, second: 10 ** 9)

    {
      {gig_date.year, gig_date.month, gig_date.day},
      {gig_date.hour, gig_date.minute, gig_date.second}
    }
  end
end
