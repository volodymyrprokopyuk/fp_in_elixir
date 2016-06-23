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

defmodule FactorialTest do
  use ExUnit.Case
  @moduletag :ch_02

  describe "Factorial.factorial/1" do
    test "returns factorial of positive numbers" do
      assert Factorial.factorial(0) == 1
      assert Factorial.factorial(1) == 1
      assert Factorial.factorial(2) == 2
      assert Factorial.factorial(3) == 6
      assert Factorial.factorial(4) == 24
      assert Factorial.factorial(5) == 120
    end
  end

  describe "Factorial.format_result/3" do
    test "returns absolute value for Abs.abs/1" do
      assert Factorial.format_result("The absolute value", -4,
        &Abs.abs/1) == "The absolute value of -4 is 4"
    end

    test "returns factorial for Factorial.factorial" do
      assert Factorial.format_result("The factorial", 4,
        &Factorial.factorial/1) == "The factorial of 4 is 24"
    end

    test "returns the incremented value for anonymous function" do
      assert Factorial.format_result("The increment", 1,
        &(&1 + 1)) == "The increment of 1 is 2"
    end
  end
end

defmodule FibonacciTest do
  use ExUnit.Case
  @moduledoc :ch_02

  describe "Fibonacci.fibonacci/1" do
    test "returns nth Fibonacci number" do
      assert Fibonacci.fibonacci(0) == 0
      assert Fibonacci.fibonacci(1) == 1
      assert Fibonacci.fibonacci(2) == 1
      assert Fibonacci.fibonacci(3) == 2
      assert Fibonacci.fibonacci(4) == 3
      assert Fibonacci.fibonacci(5) == 5
      assert Fibonacci.fibonacci(6) == 8
    end
  end
end

defmodule BinarySearchTest do
  use ExUnit.Case
  @moduletag :ch_02

  describe "BinarySearch.find/2" do
    test "returns found element index or -1" do
      assert BinarySearch.find([], 10) == -1
      assert BinarySearch.find([1], 10) == -1
      assert BinarySearch.find([1, 2], 10) == -1
      assert BinarySearch.find([1, 2, 3], 10) == -1
      assert BinarySearch.find([1], 1) == 0
      assert BinarySearch.find([1, 2], 1) == 0
      assert BinarySearch.find([1, 2], 2) == 1
      assert BinarySearch.find([1, 2, 3], 1) == 0
      assert BinarySearch.find([1, 2, 3], 2) == 1
      assert BinarySearch.find([1, 2, 3], 3) == 2
      assert BinarySearch.find([1, 2, 3, 4], 2) == 1
      assert BinarySearch.find([1, 2, 3, 4], 3) == 2
      assert BinarySearch.find([1.0, 2.0, 3.0, 4.0], 1.0) == 0
      assert BinarySearch.find(["a", "b", "c", "d"], "b") == 1
      assert BinarySearch.find([:a, :b, :c, :d], :c) == 2
    end
  end
end

defmodule SortTest do
  use ExUnit.Case
  @moduletag :ch_02

  describe "Sort.sorted?/2" do
    test "checks if a list is sorted or not for given comparison function" do
      assert Sort.sorted?([], &</2) == true
      assert Sort.sorted?([1], &</2) == true
      assert Sort.sorted?([1, 2], &</2) == true
      assert Sort.sorted?([1, 2, 3], &</2) == true
      assert Sort.sorted?([1, 2, 10, 3], &</2) == false
      assert Sort.sorted?([4, 3, 2, 1], &>/2) == true
      assert Sort.sorted?([4.0, 4.0, 1.0, 1.0], &>=/2) == true
      assert Sort.sorted?([4.0, 4.0, 10.0, 1.0, 1.0], &>=/2) == false
      assert Sort.sorted?(["a", "b", "c"], &</2) == true
      assert Sort.sorted?([:c, :b, :a], &>/2) == true
    end
  end
end

defmodule PartialTest do
  use ExUnit.Case
  @moduletag :ch_02

  describe "Partial.partial1/2" do
    test "for 2-arity funciton returns a function with one argument applied" do
      f = Partial.partial1(&+/2, 1)
      assert f.(2) == 3
    end

    test "for 1-arity function raises BadArityError" do
      f = Partial.partial1(&String.length/1, "abcd")
      assert_raise BadArityError, fn -> f.("x") end
    end

    test "for 3-arity function raises BadArityError" do
      f = Partial.partial1(&String.split/3, " a b c ")
      assert_raise BadArityError, fn -> f.(" ") end
    end
  end
end
