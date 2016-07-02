defmodule StatTest do
  use ExUnit.Case
  @moduletag :ch_04

  describe "Stat.mean/1" do
    test "returns mean of list or error on empty list" do
      assert [] |> Stat.mean == {:error, "Stat.mean: empty list"}
      assert [1] |> Stat.mean == {:ok, 1.0}
      assert [1, 2] |> Stat.mean == {:ok, 1.5}
    end
  end
end
