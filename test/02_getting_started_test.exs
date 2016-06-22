defmodule AbsTest do
  use ExUnit.Case
  @moduletag :ch_02

  describe "Abs.abs/1" do
    test "returns its non-negative argument as is" do
      for x <- [1, 0] do
        assert Abs.abs(x) == x
      end
    end

    test "returns its negative argument as positive value" do
      assert Abs.abs(-1) == 1
    end
  end

  describe "Abs.format_abs/1" do
    test "returns formatted message with absolute value" do
      assert Abs.format_abs(-10) ==  "The absolute value of -10 is 10"
    end
  end
end
