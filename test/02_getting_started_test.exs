defmodule AbsTest do
  use ExUnit.Case

  test "abs returns its non-negative argument as is" do
    for x <- [1, 0] do
      assert Abs.abs(x) == x, "ERROR: #{x}"
    end
  end

  test "abs return its negative argument as positive value" do
    assert Abs.abs(-1) == 1
  end

  test "format_abs return formatted message with absolute value" do
    assert Abs.format_abs(-10) ==  "The absolute value of -10 is 10"
  end
end
