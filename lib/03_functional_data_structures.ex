defmodule L do
  @moduledoc false

  defstruct head: nil, tail: :empty

  # data constructors
  def empty, do: %L{}
  def cons(head, %L{} = tail), do: %L{head: head, tail: tail}

  def reverse(%L{} = l), do: do_reverse(l, L.empty)
  defp do_reverse(%L{tail: :empty}, acc), do: acc
  defp do_reverse(%L{head: h, tail: tail}, acc),
    do: do_reverse(tail, L.cons(h, acc))

  def new(l) when is_list(l), do: l |> do_new(L.empty) |> L.reverse
  defp do_new([], acc), do: acc
  defp do_new([h | t], acc), do: do_new(t, L.cons(h, acc))

  def to_list(%L{} = l), do: l |> L.reverse |> do_to_list([])
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

  def drop_while(%L{tail: :empty}, _p), do: L.empty
  def drop_while(%L{head: h, tail: t}, p),
    do: (if p.(h) do drop_while(t, p) else %L{head: h, tail: t} end)

  def set_head(%L{tail: :empty}, _x), do: raise ArgumentError,
    "L.setHead: empty list"
  def set_head(%L{head: _h, tail: t}, x), do: L.cons(x, t)

  def append(%L{} = l1, %L{} = l2), do: l1 |> L.reverse |> do_append(l2)
  defp do_append(%L{tail: :empty}, %L{} = l2), do: l2
  defp do_append(%L{head: h, tail: t}, %L{} = l2),
    do: do_append(t, L.cons(h, l2))

  def init(%L{} = l), do: l |> do_init(L.empty) |> L.reverse
  defp do_init(%L{tail: :empty}, acc), do: acc
  defp do_init(%L{head: _h, tail: %L{tail: :empty}}, acc), do: acc
  defp do_init(%L{head: h, tail: t}, acc), do: do_init(t, L.cons(h, acc))

  def fold_left(%L{tail: :empty}, acc, _f), do: acc
  def fold_left(%L{head: h, tail: t}, acc, f),
    do: fold_left(t, f.(h, acc), f)

  # no tail-recursive
  def fold_right(%L{tail: :empty}, acc, _f), do: acc
  def fold_right(%L{head: h, tail: t}, acc, f),
    do: f.(h, fold_right(t, acc, f))

  def sum2(%L{} = l), do: L.fold_left(l, 0, &+/2)
  def product2(%L{} = l), do: L.fold_left(l, 1, &*/2)
  def length(%L{} = l), do: L.fold_left(l, 0, fn _, len -> len + 1 end)
  def reverse2(%L{} = l), do: L.fold_left(l, L.empty, &L.cons/2)
  def append2(%L{} = l1, %L{} = l2), do: L.fold_right(l1, l2, &L.cons/2)

  def map(%L{} = l, f), do: l |> do_map(%L{}, f) |> L.reverse
  defp do_map(%L{tail: :empty}, acc, _f), do: acc
  defp do_map(%L{head: h, tail: t}, acc, f),
    do: do_map(t, %L{head: f.(h), tail: acc}, f)

  def filter(%L{} = l, p), do: l |> do_filter(%L{}, p) |> L.reverse
  defp do_filter(%L{tail: :empty}, acc, _p), do: acc
  defp do_filter(%L{head: h, tail: t}, acc, p) do
    if p.(h) do do_filter(t, %L{head: h, tail: acc}, p)
    else do_filter(t, acc, p) end
  end

  def flat_map(%L{} = l, f) do
    l |> L.reverse |> L.map(f) |> L.fold_left(%L{},
    fn ll, acc -> ll |> L.reverse |> L.fold_left(acc, &L.cons/2) end)
  end

  def zip(%L{} = l1, %L{} = l2), do: l1 |> do_zip(l2, %L{}) |> L.reverse
  defp do_zip(%L{tail: :empty}, _l2, acc), do: acc
  defp do_zip(_l1, %L{tail: :empty}, acc), do: acc
  defp do_zip(%L{head: h1, tail: t1}, %L{head: h2, tail: t2}, acc),
    do: do_zip(t1, t2, L.cons({h1, h2}, acc))

  def zip_with(%L{} = l1, %L{} = l2, f),
    do: l1 |> L.zip(l2) |> L.map(fn {a, b} -> f.(a, b) end)
end

defmodule T do
  @moduledoc false

  defstruct leaf: nil, left: :empty, right: :empty

  # data constructors
  def empty, do: %T{}
  def node(x, %T{} = l, %T{} = r), do: %T{leaf: x, left: l, right: r}

  # no tail-recursive
  def new({}), do: T.empty
  def new({x}), do: T.node(x, T.empty, T.empty)
  def new({x, l, r}), do: T.node(x, new(l), new(r))

  # no tail-recursive
  def to_tuple(%T{leaf: nil}), do: {}
  def to_tuple(%T{leaf: x, left: %T{leaf: nil}, right: %T{leaf: nil}}),
    do: {x}
  def to_tuple(%T{leaf: x, left: %T{} = l, right: %T{} = r}),
    do: {x, to_tuple(l), to_tuple(r)}
end
