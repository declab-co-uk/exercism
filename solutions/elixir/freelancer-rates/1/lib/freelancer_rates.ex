defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    percent = before_discount / 100
    discount_amount = percent * discount
    before_discount - discount_amount
  end

  def monthly_rate(hourly_rate, discount) do
    # Please implement the monthly_rate/2 function
    (22 * daily_rate(hourly_rate)) |> apply_discount(discount) |> Float.ceil() |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    # Please implement the days_in_budget/3 function
    rate = daily_rate(hourly_rate)
    rate_after_discount = apply_discount(rate, discount)

    (budget / rate_after_discount) |> Float.floor(1)
  end
end
