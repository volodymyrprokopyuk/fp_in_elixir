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
end
