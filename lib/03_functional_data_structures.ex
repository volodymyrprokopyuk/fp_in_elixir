defmodule L do
  @moduledoc false

  defstruct head: nil, tail: :empty

  def empty, do: %L{}
  def cons(head, tail), do: %L{head: head, tail: tail}

  def reverse(%L{} = l), do: do_reverse(l, L.empty)
  defp do_reverse(%L{tail: :empty}, acc), do: acc
  defp do_reverse(%L{head: h, tail: tail}, acc),
    do: do_reverse(tail, L.cons(h, acc))

  def new(l) when is_list(l), do: l |> do_new(L.empty) |> L.reverse
  defp do_new([], acc), do: acc
  defp do_new([h | t], acc), do: do_new(t, L.cons(h, acc))

  def to_list(l), do: l |> L.reverse |> do_to_list([])
  defp do_to_list(%L{tail: :empty}, acc), do: acc
  defp do_to_list(%L{head: h, tail: t}, acc), do: do_to_list(t, [h | acc])

  def sum(%L{} = l), do: do_sum(l, 0)
  defp do_sum(%L{tail: :empty}, acc), do: acc
  defp do_sum(%L{head: h, tail: t}, acc), do: do_sum(t, acc + h)

  def product(%L{} = l), do: do_product(l, 1)
  defp do_product(%L{tail: :empty}, acc), do: acc
  defp do_product(%L{head: 0}, _acc), do: 0
  defp do_product(%L{head: h, tail: t}, acc), do: do_product(t, acc * h)

  def tail(%L{tail: :empty}), do: raise ArgumentError, "L.tail: empty list"
  def tail(%L{head: _, tail: t}), do: t

  def drop(%L{tail: :empty}, _n), do: L.empty
  def drop(%L{} = l, 0), do: l
  def drop(%L{head: _h, tail: t}, n), do: drop(t, n - 1)

  def dropWhile(%L{tail: :empty}, _p), do: L.empty
  def dropWhile(%L{head: h, tail: t}, p),
    do: (if p.(h) do dropWhile(t, p) else %L{head: h, tail: t} end)

  def setHead(%L{tail: :empty}, _x), do: raise ArgumentError,
    "L.setHead: empty list"
  def setHead(%L{head: _h, tail: t}, x), do: L.cons(x, t)

  def append(%L{} = l1, %L{} = l2), do: l1 |> L.reverse |> do_append(l2)
  defp do_append(%L{tail: :empty}, %L{} = l2), do: l2
  defp do_append(%L{head: h, tail: t}, %L{} = l2),
    do: do_append(t, L.cons(h, l2))

  def init(%L{} = l), do: l |> do_init(L.empty) |> L.reverse
  defp do_init(%L{tail: :empty}, acc), do: acc
  defp do_init(%L{head: _h, tail: %L{tail: :empty}}, acc), do: acc
  defp do_init(%L{head: h, tail: t}, acc), do: do_init(t, L.cons(h, acc))

  def foldLeft(%L{tail: :empty}, acc, _f), do: acc
  def foldLeft(%L{head: h, tail: t}, acc, f),
    do: foldLeft(t, f.(h, acc), f)

  # no TCO
  def foldRight(%L{tail: :empty}, acc, _f), do: acc
  def foldRight(%L{head: h, tail: t}, acc, f),
    do: f.(h, foldRight(t, acc, f))

  def sum2(%L{} = l), do: L.foldLeft(l, 0, &+/2)
  def product2(%L{} = l), do: L.foldLeft(l, 1, &*/2)
  def length(%L{} = l), do: L.foldLeft(l, 0, fn _, len -> len + 1 end)
  def reverse2(%L{} = l), do: L.foldLeft(l, L.empty, &L.cons/2)
  def append2(%L{} = l1, %L{} = l2), do: L.foldRight(l1, l2, &L.cons/2)

  # TODO: EXERCISE: 13, 15
end
