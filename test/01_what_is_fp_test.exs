defmodule PlayerTest do
  use ExUnit.Case
  @moduletag :ch_01

  describe "Player.get_winner/2" do
    test "returns the player with higher score" do
      p1 = %Player{name: "Svitlana", score: 14}
      p2 = %Player{name: "Volodymyr", score: 10}
      assert Player.get_winner(p1, p2) == p1
    end

    test "reduce over list of palyers returns absolute winner" do
      p1 = %Player{name: "Svitlana", score: 14}
      p2 = %Player{name: "Volodymyr", score: 10}
      p3 = %Player{name: "Igor", score: 15}
      assert Enum.reduce([p1, p2, p3], &Player.get_winner/2) == p3
    end
  end

  describe "Player.declare_winner/2" do
    test "returns a string with winner name" do
      p1 = %Player{name: "Svitlana", score: 14}
      p2 = %Player{name: "Volodymyr", score: 10}
      assert Player.declare_winner(p1, p2) ==
        "#{p1.name} is the winner!"
    end
  end
end
