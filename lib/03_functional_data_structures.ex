defmodule L do
  @moduledoc false

  defstruct head: nil, tail: :empty

  def empty, do: %L{}
  def cons(head, tail), do: %L{head: head, tail: tail}

  def new(l) when is_list(l), do: do_new(l, empty)
  defp do_new([], acc), do: acc
  defp do_new([h | t], acc), do: do_new(t, cons(h, acc))

  def to_list(l), do: do_to_list(l, [])
  defp do_to_list(%L{tail: :empty}, acc), do: acc
  defp do_to_list(%L{head: h, tail: t}, acc), do: do_to_list(t, [h | acc])

  def sum(l), do: do_sum(l, 0)
  defp do_sum(%L{tail: :empty}, acc), do: acc
  defp do_sum(%L{head: h, tail: t}, acc), do: do_sum(t, acc + h)

  def product(l), do: do_product(l, 1)
  defp do_product(%L{tail: :empty}, acc), do: acc
  defp do_product(%L{head: h, tail: t}, acc), do: do_product(t, acc * h)
end
