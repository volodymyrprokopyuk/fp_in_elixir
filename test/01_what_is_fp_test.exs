defmodule PlayerTest do
  use ExUnit.Case

  test "get_winner returns the player with higher score" do
    p1 = %Player{name: "Svitlana", score: 14}
    p2 = %Player{name: "Volodymyr", score: 10}
    assert Player.get_winner(p1, p2) == p1
  end

  test "declare_winner returns a string with winner name" do
    p1 = %Player{name: "Svitlana", score: 14}
    p2 = %Player{name: "Volodymyr", score: 10}
    assert Player.declare_winner(p1, p2) == "#{p1.name} is the winner!"
  end

  test "reduce over list of palyers with get_winner returns absolute winner" do
    p1 = %Player{name: "Svitlana", score: 14}
    p2 = %Player{name: "Volodymyr", score: 10}
    p3 = %Player{name: "Igor", score: 15}
    assert Enum.reduce([p1, p2, p3], &Player.get_winner/2) == p3
  end
end
