defmodule NameBadge do
  def print(id, name, department) do
    formatted_dept = if department, do: String.upcase(department), else: "OWNER"

    if id,
      do: "[#{id}] - #{name} - #{formatted_dept}",
      else: "#{name} - #{formatted_dept}"
  end
end
