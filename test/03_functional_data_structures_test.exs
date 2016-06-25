defmodule LTest do
  use ExUnit.Case
  @moduletag :ch_03

  describe "L.to_list/1" do
    test "converts L to List" do
      for l <- [[], [1, 2, 3, 4]] do
        ll = L.new(l)
        assert L.to_list(ll) == l
      end
    end
  end

  describe "L.sum/1" do
    test "returns 0 for empty L" do
      assert L.empty |> L.sum == 0
    end

    test "returns sum of integer L" do
      l = L.new([1, 2, 3, 4])
      assert L.sum(l) == 10
    end

    test "return sum of float L" do
      l = L.new([1.0, 2.0, 3.0, 4.0])
      assert L.sum(l) == 10.0
    end
  end

  describe "L.product/1" do
    test "returns 1 for empty L" do
      assert L.empty |> L.product == 1
    end

    test "returns product of integer L" do
      l = L.new([1, 2, 3, 4])
      assert L.product(l) == 24
    end

    test "returns product of float L" do
      l = L.new([1.0, 2.0, 3.0, 4.0])
      assert L.product(l) == 24.0
    end
  end
end
