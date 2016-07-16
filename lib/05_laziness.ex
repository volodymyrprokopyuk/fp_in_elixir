defmodule Lazy do
  @moduledoc false

  def new(l), do: l |> Stream.map(&(&1))

  def to_list(s), do: s |> Enum.to_list

  def take(s, n) do
    Stream.unfold({s, n}, fn {s, n} ->
      case s |> Stream.take(1) |> Lazy.to_list do
        [] -> nil
        _ when n == 0 -> nil
        [x] -> {x, {s |> Stream.drop(1), n - 1}}
      end
    end)
  end

  def take_while(s, p) do
    Stream.unfold(s, fn s ->
      case s |> Stream.take(1) |> Lazy.to_list do
        [] -> nil
        [x] -> if p.(x) do {x, s |> Stream.drop(1)} else nil end
      end
    end)
  end

  def map(s, f) do
    Stream.unfold(s, fn s ->
      case s |> Stream.take(1) |> Lazy.to_list do
        [] -> nil
        [x] -> {f.(x), s |> Stream.drop(1)}
      end
    end)
  end

  def constant(x), do: Stream.unfold(x, fn x -> {x, x} end)

  def iterate(x, f), do: Stream.unfold(x, fn x -> {x, f.(x)} end)

  def fibonacci, do:
    Stream.unfold({0, 1}, fn {prev, curr} -> {prev, {curr, prev + curr}} end)
end
