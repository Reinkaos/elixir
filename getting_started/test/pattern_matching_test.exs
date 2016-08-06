defmodule PatternMatchingTest do
  use ExUnit.Case, async: true

  test "it matches 1 and x" do
    x = 1
    assert x == 1
  end

  test "it does not match when the value changes on the left" do
    x = 1
    assert 2 != x
  end

  test "it destructures tuples" do
    {a, _b, _c} = {:atom, 2, 3.4}
    assert a == :atom
  end

  test "it destructures lists" do
    [a, _b, _c] = [1, 2, 3]
    assert a == 1
  end

  test "it matches the head" do
    [head| _tail] = [1, 2, 3]
    assert head == 1
  end

  test "it matche the tail" do
    [_head | tail] = [1, 2, 3]
    assert tail == [2, 3]
  end

end
