defmodule LTest do
  use ExUnit.Case
  @moduletag :ch_03

  describe "L.reverse/1" do
    test "reverses L" do
      assert L.empty |> L.reverse == L.empty
      assert [1] |> L.new |> L.reverse |> L.to_list == [1]
      assert [1,2] |> L.new |> L.reverse |> L.to_list == [2,1]
      assert [1,2,3] |> L.new |> L.reverse |> L.to_list == [3,2,1]
    end
  end

  describe "L.to_list/1" do
    test "converts L to List" do
      for l <- [[], [1, 2, 3, 4]] do
        ll = L.new(l)
        assert L.to_list(ll) == l
      end
    end
  end

  describe "L.sum/1" do
    test "returns sum of L" do
      assert L.empty |> L.sum == 0
      assert [1, 2, 3, 4] |> L.new |> L.sum == 10
      assert [1.0, 2.0, 3.0, 4.0] |> L.new |> L.sum == 10.0
    end
  end

  describe "L.product/1" do
    test "returns product of L" do
      assert L.empty |> L.product == 1
      assert [1, 2, 3, 4] |> L.new |> L.product == 24
      assert [1.0, 2.0, 3.0, 4.0] |> L.new |> L.product == 24.0
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

  describe "L.drop_while/2" do
    test "return L without elements on which predicate returned true" do
      assert L.empty |> L.drop_while(&(&1 < 3)) == L.empty
      assert [1, 2, 3] |> L.new |> L.drop_while(&(&1 < 3)) |> L.to_list == [3]
      assert [1, 2] |> L.new |> L.drop_while(&(&1 < 3)) == L.empty
    end
  end

  describe "L.set_head/2" do
    test "sets head of L or raises ArgumentError on empty list" do
      assert [1, 2] |> L.new |> L.set_head(10) |> L.to_list == [10, 2]
      assert_raise ArgumentError, fn -> L.empty |> L.set_head(10) end
    end
  end

  describe "L.append/2" do
    test "appends second list to the end of first list" do
      l1 = [1, 2] |> L.new
      l2 = [10, 20] |> L.new
      assert L.empty |> L.append(l1) == l1
      assert l1 |> L.append(l2) |> L.to_list == [1, 2, 10, 20]
    end
  end

  describe "L.init/1" do
    test "return all but last elements of L" do
      assert L.empty |> L.init == L.empty
      assert [1] |> L.new |> L.init == L.empty
      assert [1, 2] |> L.new |> L.init |> L.to_list == [1]
      assert [1, 2, 3, 4] |> L.new |> L.init |> L.to_list == [1, 2, 3]
    end
  end

  describe "L.fold_left/3" do
    test "folds left L" do
      assert L.empty |> L.fold_left(0, &+/2) == 0
      assert [1] |> L.new |> L.fold_left(0, &+/2) == 1
      assert [1, 2, 3] |> L.new |> L.fold_left(0, &+/2) == 6
      assert ~w{a b c} |> L.new |> L.fold_left("", &<>/2) == "cba"
    end
  end

  describe "L.fold_right/3" do
    test "folds right L" do
      assert L.empty |> L.fold_right(0, &+/2) == 0
      assert [1] |> L.new |> L.fold_right(0, &+/2) == 1
      assert [1, 2, 3] |> L.new |> L.fold_right(0, &+/2) == 6
      assert ~w{a b c} |> L.new |> L.fold_right("", &<>/2) == "abc"
    end

    test "returns the same L for L.empty and L.cons" do
      l = [1, 2, 3, 4] |> L.new
      assert L.fold_right(l, L.empty, &L.cons/2) == l
    end
  end

  describe "L.sum2/1" do
    test "returns sum2 of L" do
      assert L.empty |> L.sum2 == 0
      assert [1, 2, 3, 4] |> L.new |> L.sum2 == 10
      assert [1.0, 2.0, 3.0, 4.0] |> L.new |> L.sum2 == 10.0
    end
  end

  describe "L.product2/1" do
    test "returns product2 of L" do
      assert L.empty |> L.product2 == 1
      assert [1, 2, 3, 4] |> L.new |> L.product2 == 24
      assert [1.0, 2.0, 3.0, 4.0] |> L.new |> L.product2 == 24.0
    end
  end

  describe "L.length/1" do
    test "return lentgh of L" do
      assert L.empty |> L.length == 0
      assert [1, 2, 3] |> L.new |> L.length == 3
    end
  end

  describe "L.fold_right/3 vs L.fold_left/3" do
    test "L.fold_right stack overflows raising error" do
      #l = 1..9999999 |> Enum.to_list |> L.new
      #assert l |> L.fold_right(0, &+/2) == 1234
    end

    test "L.fold_left returns result without raising error" do
      #l = 1..9999999 |> Enum.to_list |> L.new
      #assert l |> L.fold_left(0, &+/2) == 1234
    end
  end

  describe "L.reverse2/1" do
    test "reverses L" do
      assert L.empty |> L.reverse2 == L.empty
      assert [1] |> L.new |> L.reverse2 |> L.to_list == [1]
      assert [1,2] |> L.new |> L.reverse2 |> L.to_list == [2,1]
      assert [1,2,3] |> L.new |> L.reverse2 |> L.to_list == [3,2,1]
    end
  end

  describe "L.append2/2" do
    test "append2s second list to the end of first list" do
      l1 = [1, 2] |> L.new
      l2 = [10, 20] |> L.new
      assert L.empty |> L.append2(l1) == l1
      assert l1 |> L.append2(l2) |> L.to_list == [1, 2, 10, 20]
    end
  end

  describe "L.map/2" do
    test "maps a function over L and returns a new mapped L" do
      assert L.empty |> L.map(&(&1 + 1)) == L.empty
      assert [1, 2, 3] |> L.new |> L.map(&(&1 + 1)) |> L.to_list ==
        [2, 3, 4]
      assert [1.0, 2.0, 3.0] |> L.new |> L.map(&to_string/1)
      |> L.to_list == ["1.0", "2.0", "3.0"]
    end
  end

  describe "L.filter/2" do
    test "filters L with predicate and returns a new filtered L" do
      assert L.empty |> L.filter(&(rem(&1, 2) == 0)) == L.empty
      assert 1..5 |> Enum.to_list |> L.new
      |> L.filter(&(rem(&1, 2) == 0)) |> L.to_list == [2, 4]
    end
  end

  describe "L.flat_map/2" do
    test "flats mapped L and return a new flattened L " do
      assert [1, 2, 3] |> L.new
      |> L.flat_map(fn x -> [x, x * 10] |> L.new end)
      |> L.to_list == [1, 10, 2, 20, 3, 30]
    end
  end

  describe "L.zip/2" do
    test "zips two Ls and returns new L of pairs" do
      l1 = [1, 2, 3] |> L.new
      l2 = [:a, :b, :c, :d] |> L.new
      assert l1 |> L.zip(L.empty) == L.empty
      assert l1 |> L.zip(l1) |> L.to_list == [{1, 1}, {2, 2}, {3, 3}]
      assert l1 |> L.zip(l2) |> L.to_list == [{1, :a}, {2, :b}, {3, :c}]
    end
  end

  describe "L.zip_with/3" do
    test "zips two Ls with f and returns new L" do
      l1 = [1, 2, 3] |> L.new
      l2 = [10, 20, 30] |> L.new
      assert l1 |> L.zip_with(l2, &+/2) |> L.to_list == [11, 22, 33]
    end
  end
end

defmodule TTest do
  use ExUnit.Case
  @moduletag :ch_03
end
