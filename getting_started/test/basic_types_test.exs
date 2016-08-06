defmodule BasicTypesTest do
  use ExUnit.Case, async: true
  
  test "it adds two numbers together" do
    assert 1 + 2 == 3
  end

  test "it multiplies two numbers" do
    assert 5 * 5 == 25
  end

  test "it divides two numbers and returns a float" do
    assert 10 / 2 == 5.0
  end

  test "it divides two numbers and returns an integer" do
    assert div(10, 2) == 5
  end

  test "it returns the remainder of two integers" do
    assert rem(10, 3) == 1
  end

  test "it rounds a float" do
    assert round(3.4) == 3
  end

  test "it returns the integer part of a float" do
    assert trunc(3.6) == 3
  end
end
