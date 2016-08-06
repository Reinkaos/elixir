defmodule CaseCondAndIfTest do
  use ExUnit.Case, async: true

  test "binds to the matching option in the case statement" do
    x = case {1, 2, 3} do
      {4, 5, 6} -> "This does not match"
      {1, _x, 3} -> "This will match and bind x to 2"
      _ -> "This is the fall back matcher"
    end

    assert x == "This will match and bind x to 2"
  end

  test "a sensible case statement" do
    test = fn (truth) ->
      case truth do
        {:truth, :is, :here} -> "The truth is here"
        {:no, _x} -> "Not this one"
      end
    end

    assert test.({:truth, :is, :here}) == "The truth is here"
  end
end
