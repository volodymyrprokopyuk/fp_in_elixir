defmodule Lazy do
  @moduledoc false

  def fibonacci, do: Stream.unfold([0, 1],
        fn [prev, curr] -> {prev, [curr, prev + curr]} end)
end
