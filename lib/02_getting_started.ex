defmodule Abs do
  @moduledoc false

  def abs(x), do: (if x < 0 do -x else x end)

  def format_abs(x), do: "The absolute value of #{x} is #{Abs.abs(x)}"
end
