defmodule AnonymousFunctionsTest do
  use ExUnit.Case, async: true

  # Functions are delimited by the keywords fn and end:

  test "it adds 2 numbers together" do
    add = fn (a, b) -> a + b end
    assert add.(1, 2) == 3
  end

  test "it adds 2 numbers together in a shorthand fn" do
    add = &(&1 + &2)
    assert add.(2, 3) == 5
  end

  test "it doubles a number by calling add inside of itself" do
    add = &(&1 + &2)
    double = fn (a) -> add.(a, a) end
    assert double.(2) == 4
  end
end
