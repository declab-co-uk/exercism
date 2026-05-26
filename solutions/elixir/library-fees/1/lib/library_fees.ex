defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, date_time} = NaiveDateTime.from_iso8601(string)
    date_time
  end

  def before_noon?(datetime) do
    if datetime.hour < 12, do: true, else: false
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime),
      do: Date.shift(checkout_datetime, day: 28),
      else: Date.shift(checkout_datetime, day: 29)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    case Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date) do
      days_late when days_late > 0 -> days_late
      _ -> 0
    end
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime) |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return_naive = datetime_from_string(return)
    late_by = datetime_from_string(checkout) |> return_date() |> days_late(return_naive)

    if monday?(return_naive), do: div(late_by * rate, 2), else: late_by * rate
  end
end
