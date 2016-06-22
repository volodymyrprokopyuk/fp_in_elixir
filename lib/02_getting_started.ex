defmodule Abs do
  @moduledoc false

  def abs(x), do: (if x < 0 do -x else x end)

  def format_abs(x), do: "The absolute value of #{x} is #{Abs.abs(x)}"
end

defmodule Factorial do
  @moduledoc false

  def factorial(x), do: do_factorial(x, 1)
  defp do_factorial(0, fac), do: fac
  defp do_factorial(x, fac), do: do_factorial(x - 1, fac * x)

  def format_result(m, x, f), do: "#{m} of #{x} is #{f.(x)}"
end

defmodule Fibonacci do
  @moduledoc false

  def fibonacci(x), do: do_fibonacci(x, 0, 1)
  defp do_fibonacci(0, prev, _curr), do: prev
  defp do_fibonacci(1, _prev, curr), do: curr
  defp do_fibonacci(x, prev, curr),
    do: do_fibonacci(x - 1, curr, prev + curr)
end

defmodule BinarySearch do
  @moduledoc false

  def find(l, x), do: do_find(Enum.with_index(l), x)
  defp do_find(l, x) do
    case Enum.split(l, l |> length |> div(2)) do
      {[], []} -> -1
      {_left, [{v, i}]} -> if v == x do i else -1 end
      {left, [{v, i} | right]} ->
      cond do
        v == x -> i
        v < x -> do_find(right, x)
        true -> do_find(left, x)
      end
    end
  end
end
