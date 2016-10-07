defmodule MyEnum do

  # all? returns trhe when all elements in the collection return true to a given function

  def all?([], _func), do: true

  def all?([ head | tail ], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

end
