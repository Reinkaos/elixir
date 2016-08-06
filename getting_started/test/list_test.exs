defmodule ListTest do
  use ExUnit.Case, async: true

  test "it concatinates 2 lists" do
    list_a = [1, 2, 3]
    list_b = [4, 5, 6]
    assert list_a ++ list_b == [1, 2, 3, 4, 5, 6]
  end

  test "it subtracts elements from a list" do
    list = [1, 2, 3, 4, 5, 6]
    assert list -- [1, 4, 6] == [2, 3, 5]
  end

  test "it returns the head of a list" do
    list = [1, 2, 3, 4]
    assert hd(list) == 1
  end

  test "it returns the tail of a list" do
    list = [1, 2, 3, 4]
    assert tl(list) == [2, 3, 4]
  end

end
