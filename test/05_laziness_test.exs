defmodule LazyTest do
  use ExUnit.Case
  @moduletag :ch_05

  describe "Lazy.map/2" do
    test "maps lazily over list with a function that returns value" do
      assert [] |> Lazy.map(&(&1 * 10)) |> Enum.to_list == []
      assert [1, 2, 3, 4] |> Lazy.map(&(&1 * 10)) |> Enum.to_list ==
        [10, 20, 30, 40]
    end
  end

  describe "Lazy.fibonacci/0" do
    test "returns lazy Fibonacci sequence stream" do
      assert Lazy.fibonacci |> Enum.take(10) ==
        [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    end
  end

  describe "Lazy.constant/1" do
    test "returns infinite lazy stream of constant values" do
      assert :a |> Lazy.constant |> Enum.take(4) == [:a, :a, :a, :a]
    end
  end
end
