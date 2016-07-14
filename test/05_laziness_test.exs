defmodule LazyTest do
  use ExUnit.Case
  @moduletag :ch_05

  describe "fibonacci/0" do
    test "returns Fibonacci sequence stream" do
      assert Lazy.fibonacci |> Enum.take(10) ==
        [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    end
  end
end
