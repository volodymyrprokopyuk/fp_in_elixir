defmodule Stat do
  @moduledoc false

  def mean([]), do: {:error, "Stat.mean: empty list"}
  def mean(l), do: {:ok, Enum.sum(l) / length(l)}
end
