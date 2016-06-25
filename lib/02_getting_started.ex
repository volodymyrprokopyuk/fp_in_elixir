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
      {[], [{v, i}]} -> if v == x do i else -1 end
      {left, [{v, i} | right]} ->
      cond do
        v == x -> i
        v < x -> do_find(right, x)
        true -> do_find(left, x)
      end
    end
  end
end

defmodule Sort do
  @moduledoc false

  def sorted?([], _p), do: true
  def sorted?([_], _p), do: true
  def sorted?([a, b | r], p),
    do: (if p.(a, b) do sorted?([b | r], p) else false end)
end

defmodule Partial do
  @moduledoc false

  # partial1(f :: (A, B) -> C, a :: A) :: B -> C
  def partial1(f, a), do: fn b -> f.(a, b) end
  # curry(f :: (A, B) -> C) :: A -> B -> C
  def curry(f), do: fn a -> fn b -> f.(a, b) end end
  # uncurry(f :: A -> B -> C) :: (A, B) -> C
  def uncurry(f), do: fn a, b -> f.(a).(b) end
end

defmodule Composition do
  @moduledoc false

  # compose(f :: A -> B, g :: B -> C) :: A -> C
  def compose(f, g), do: fn a -> a |> f.() |> g.() end
end
