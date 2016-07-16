defmodule LazyTest do
  use ExUnit.Case
  @moduletag :ch_05

  describe "Lazy.take/2" do
    test "takes n first elements form a list" do
      assert [] |> Lazy.new |> Lazy.take(1) |> Lazy.to_list == []
      assert [1, 2, 3] |> Lazy.new |> Lazy.take(0) |> Lazy.to_list == []
      assert [1, 2, 3] |> Lazy.new |> Lazy.take(1) |> Lazy.to_list == [1]
      assert [1, 2, 3] |> Lazy.new |> Lazy.take(2) |> Lazy.to_list == [1, 2]
      assert [1, 2, 3] |> Lazy.new |> Lazy.take(3) |> Lazy.to_list == [1, 2, 3]
      assert [1, 2, 3] |> Lazy.new |> Lazy.take(4) |> Lazy.to_list == [1, 2, 3]
    end
  end

  describe "Lazy.take_while/2" do
    test "takes n first elements form a list based on predicate" do
      p = fn x -> x < 3 end
      assert [] |> Lazy.new |> Lazy.take_while(p) |> Lazy.to_list == []
      assert [1] |> Lazy.new |> Lazy.take_while(p) |> Lazy.to_list == [1]
      assert [1, 2] |> Lazy.new |> Lazy.take_while(p) |> Lazy.to_list == [1, 2]
      assert [1, 2, 3] |> Lazy.new |> Lazy.take_while(p) |> Lazy.to_list ==
        [1, 2]
      assert [1, 2, 3] |> Lazy.new |> Lazy.take_while(fn _ -> false end)
      |> Lazy.to_list == []
    end
  end

  describe "Lazy.map/2" do
    test "maps lazily over list with a function that returns value" do
      f = fn x -> x * 10 end
      assert [] |> Lazy.new |> Lazy.map(f) |> Lazy.to_list == []
      assert [1, 2, 3, 4] |> Lazy.map(f) |> Lazy.to_list == [10, 20, 30, 40]
    end
  end

  describe "Lazy.constant/1" do
    test "returns infinite lazy stream of constant values" do
      assert :a |> Lazy.constant |> Enum.take(4) == [:a, :a, :a, :a]
    end
  end

  describe "Lazy.iterate/s" do
    test "iterates lazly from initial value applying a function" do
      f = fn x -> x + 1 end
      assert 0 |> Lazy.iterate(f) |> Enum.take(4) == [0, 1, 2, 3]
    end
  end

  describe "Lazy.fibonacci/0" do
    test "returns lazy Fibonacci sequence stream" do
      assert Lazy.fibonacci |> Enum.take(9) == [0, 1, 1, 2, 3, 5, 8, 13, 21]
    end
  end
end
