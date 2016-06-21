defmodule Player do
  @moduledoc false

  defstruct name: "", score: 0

  def print_winner(player), do: "#{player.name} is the winner!"

  def get_winner(p1, p2), do: (if p1.score > p2.score do p1 else p2 end)

  def declare_winner(p1, p2), do: p1 |> get_winner(p2) |> print_winner
end
