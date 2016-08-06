defmodule TuplesTest do
  use ExUnit.Case, async: true

  test "it returns the size of a tuple" do
    assert tuple_size({:ok, "hello"}) == 2
  end

  test "it displays information via index" do
    assert elem({:ok, "hello"}, 1) == "hello"
  end

  test "it puts an element in a specifc key" do
    tuple = {:ok, "hello"}
    assert put_elem(tuple, 1, :atom) == {:ok, :atom}
  end

end
