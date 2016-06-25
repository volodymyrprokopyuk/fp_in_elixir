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

  describe "pattern matching" do
    test "returns the expression of first match" do
      res =
        case L.new([1, 2, 3, 4, 5]) do
          %L{head: x, tail: %L{head: 2, tail: %L{head: 4, tail: _}}} -> x
          %L{tail: :empty} -> 42
          %L{head: x, tail:
            %L{head: y, tail: %L{head: 3, tail: %L{head: 4, tail: _}}}} -> x + y
          %L{head: x, tail: %L{head: y}} -> x + y
          %L{head: h, tail: t} -> h + L.sum(t)
          _ -> 101
        end
      assert res == 3
    end
  end

  describe "L.tail/1" do
    test "returns tail of L" do
      assert [1] |> L.new |> L.tail == L.empty
      assert [1, 2] |> L.new |> L.tail |> L.to_list == [2]
    end

    test "raises ArgumentError on empty L" do
      assert_raise ArgumentError, fn -> [] |> L.new |> L.tail end
    end
  end

  describe "L.drop/2" do
    test "returns L with n elements dropped or empty L" do
      assert [1, 2] |> L.new |> L.drop(0) |> L.to_list == [1, 2]
      assert L.empty |> L.drop(1) == L.empty
      assert [1] |> L.new |> L.drop(1) == L.empty
      assert [1, 2, 3] |> L.new |> L.drop(1) |> L.to_list == [2, 3]
      assert [1, 2, 3, 4] |> L.new |> L.drop(2) |> L.to_list == [3, 4]
    end
  end
end
