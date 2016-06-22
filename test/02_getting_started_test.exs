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
      assert Factorial.factorial(5) == 120
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
