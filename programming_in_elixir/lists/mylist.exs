defmodule MyList do

  # Called like MyList.len([1,2,3])

  def len([]), do: 0
  def len([_head|tail]), do: 1 + len(tail)

  # Called like MyList.square([1,2,3])

  def square([]), do: []
  def square([ head | tail ]), do: [ head * head | square(tail) ]

  # Called like MyList.map([2,3,4,5], &(&1 * &1))

  def map([], _func), do: []
  def map([ head | tail], func), do: [ func.(head) | map(tail, func) ]

  # Called like MyList.sum([2,3,4])
  # The idea with this is so that we do not have to call sum with the starting 0

  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head + total)

  # Sum without the accumulator

  def sum_without_acc([]), do: 0
  def sum_without_acc([ head | tail]), do: head + sum_without_acc(tail)

  # MyList.sum_without_acc([1,2,3,4])

  def reduce([], value, _) do
    value
  end

  def reduce([ head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def mapsum([], _fun),             do: 0
  def mapsum([ head | tail ], fun), do: fun.(head) + mapsum(tail, fun)

  # IO.puts MyList.mapsum([1, 2, 3], &(&1 * &1))  #=> 14

  def max(list) do
    _max(list, 0)
  end

  defp _max([], max_val) do
    max_val
  end

  defp _max([ head | tail ], max_val) when head > max_val do
    _max(tail, head)
  end

  defp _max([ head | tail ], max_val) when head < max_val do
    _max(tail, max_val)
  end

  IO.puts MyList.max([1,2,3,4,7,8,2,3])

  # More elegant of the above function

  # max([]) is undefined...

  # max of a single element list is that element

  def maxx([x]), do: x

  # else recurse
  def maxx([ head | tail ]), do: Kernel.max(head, maxx(tail))


  # I don't understand this one.

  def caesar([], _n), do: []

  def caesar([ head | tail ], n)
    when head + n <= ?z,
    do: [ head+n | caesar(tail, n) ]

  def caesar([ head | tail ], n),
    do: [ head + n - 26 | caesar(tail, n) ]

  # IO.puts MyList.ceaser('rvkve', 13)

  # This will give you the numbers between a range
  def span(from, to) when from > to, do: []

  def span(from, to) do
    # So span(from + 1), to) returns a []
    # Then the + combines them
    [ from | span(from + 1, to) ]
  end



end
