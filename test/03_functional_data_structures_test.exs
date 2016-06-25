defmodule LTest do
  use ExUnit.Case
  @moduletag :ch_03

  describe "L.to_list/1" do
    test "converts L to List" do
      l = [1, 2, 3, 4]
      ll = L.new(l)
      assert L.to_list(ll) == l
    end
  end
end
