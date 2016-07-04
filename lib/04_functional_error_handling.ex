defmodule Option do
  @moduledoc false

  defstruct ok: nil, error: :empty

  # data constructors
  def ok(x), do: %Option{ok: x}
  def error(e), do: %Option{error: e}

  # get Option value or provide a default value
  def get_or(%Option{ok: x, error: :empty}, _d), do: x
  def get_or(%Option{}, d), do: d

  # chain together possibly failing computations
  # trying the second if the first is not succeded
  def or_else(%Option{error: :empty} = o, _d), do: o
  def or_else(%Option{}, %Option{} = d), do: d

  # apply f inside Option
  # returns Option
  def map(%Option{ok: x, error: :empty}, f), do: Option.ok(f.(x))
  def map(%Option{} = o, _f), do: o

  def map2(%Option{} = a, %Option{} = b, f) do
    with %Option{ok: x, error: :empty} <- a,
         %Option{ok: y, error: :empty} <- b,
      do: Option.ok(f.(x, y))
  end

  # apply f inside Option, when f itself returns Option
  def flat_map(%Option{ok: x, error: :empty}, f), do: f.(x)
  def flat_map(%Option{} = o, _f), do: o

  # convert Option.ok into Option.error based on predicate
  def filter(%Option{ok: x, error: :empty} = o, p) do
    if p.(x) do o
    else Option.error("Option.filter: predicate does not match") end
  end
  def filter(%Option{} = o, _p), do: o

  # lift f :: A -> B into ff :: Option[A] -> Option[B]
  # returns new function over Option
  def lift(f), do: fn %Option{} = o -> Option.map(o, f) end

  # sequence :: List[Option] -> Option[List]
  def sequence(l) do
    case do_sequence(l, []) do
      %Option{} = e -> e
      x -> x |> Enum.reverse |> Option.ok
    end
  end
  defp do_sequence([], acc), do: acc
  defp do_sequence([%Option{ok: x, error: :empty} | t], acc),
    do: do_sequence(t, [x | acc])
  defp do_sequence([e | _t], _acc), do: e

  def traverse(l, f) do
    case do_traverse(l, [], f) do
      %Option{} = e -> e
      x -> x |> Enum.reverse |> Option.ok
    end
  end
  defp do_traverse([], acc, _f), do: acc
  defp do_traverse([%Option{ok: x, error: :empty} | t], acc, f) do
    case f.(x) do
      %Option{ok: y, error: :empty} -> do_traverse(t, [y | acc], f)
      e -> e
    end
  end
  defp do_traverse([e | _t], _acc, _f), do: e

  def sequence2(l), do: Option.traverse(l, &Option.ok/1)
end

defmodule Stat do
  @moduledoc false

  def mean([]), do: Option.error("Stat.mean: empty list")
  def mean(l), do: Option.ok(Enum.sum(l) / length(l))

  def variance(l) do
    with %Option{ok: m, error: :empty} <- Stat.mean(l) do
      l |> Enum.map(&(:math.pow(&1 - m, 2))) |> Stat.mean
    end
  end
end

defmodule RegExp do
  @moduledoc false

  def compile(p) do
    case Regex.compile(p) do
      {:ok, r} -> Option.ok(r)
      {:error, m} -> Option.error(m)
    end
  end

  def match?(p, s),
    do: p |> RegExp.compile |> Option.map(fn r -> Regex.match?(r, s) end)

  def match2?(p, s) do
    match = Option.lift(fn r -> Regex.match?(r, s) end)
    p |> RegExp.compile |> match.()
  end

  def match_both(p1, p2, s),
    do: Option.map2(RegExp.match?(p1, s), RegExp.match?(p2, s), &(&&/2))
end
