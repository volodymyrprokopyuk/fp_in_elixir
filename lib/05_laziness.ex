defmodule Lazy do
  @moduledoc false

  def map(l, f), do:
    Stream.unfold(l, fn [] -> nil; [h | t] -> {f.(h), t} end)

  def fibonacci, do: Stream.unfold({0, 1},
    fn {prev, curr} -> {prev, {curr, prev + curr}} end)

  def constant(x), do: Stream.unfold(x, fn x -> {x, x} end)
end
