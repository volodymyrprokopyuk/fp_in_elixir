defmodule Option do
  @moduledoc false

  defstruct ok: nil, error: :empty

  # data constructors
  def ok(x), do: %Option{ok: x}
  def error(e), do: %Option{error: e}

  def get_or(%Option{ok: x, error: :empty}, _d), do: x
  def get_or(%Option{}, d), do: d

  def or_option(%Option{error: :empty} = o, _d), do: o
  def or_option(%Option{}, %Option{} = d), do: d

  def map(%Option{ok: x, error: :empty}, f), do: Option.ok(f.(x))
  def map(%Option{} = o, _f), do: o

  def flat_map(%Option{ok: x, error: :empty}, f), do: f.(x)
  def flat_map(%Option{} = o, _f), do: o
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
