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
end

defmodule Fibonacci do
  @moduledoc false

  def fibonacci(x), do: do_fibonacci(x, 0, 1)
  defp do_fibonacci(0, prev, _curr), do: prev
  defp do_fibonacci(1, _prev, curr), do: curr
  defp do_fibonacci(x, prev, curr),
    do: do_fibonacci(x - 1, curr, prev + curr)
end
