defmodule OptionTest do
  use ExUnit.Case
  @moduletag :ch_04

  describe "Option.map/2" do
    test "maps over Option or returns error as is" do
      assert Option.error("oh") |> Option.map(&String.upcase/1) ==
        Option.error("oh")
      assert Option.ok("ok") |> Option.map(&String.upcase/1)
      |> Option.get_or(:error) == "OK"
    end
  end

  describe "Option.flat_map/2" do
    test "flat maps over Option or returns flattened error" do
      ok = fn x -> Option.ok(x * 10) end
      err = fn _ -> Option.error("err") end
      assert Option.error("oh") |> Option.flat_map(ok) == Option.error("oh")
      assert Option.error("oh") |> Option.flat_map(err) == Option.error("oh")
      assert Option.ok(1) |> Option.flat_map(ok) == Option.ok(10)
      assert Option.ok(1) |> Option.flat_map(err) == Option.error("err")
    end
  end
end

defmodule StatTest do
  use ExUnit.Case
  @moduletag :ch_04

  describe "Stat.mean/1" do
    test "returns mean of list or error on empty list" do
      assert [] |> Stat.mean == Option.error("Stat.mean: empty list")
      assert [1] |> Stat.mean == Option.ok(1.0)
      assert [1, 2] |> Stat.mean == Option.ok(1.5)
    end
  end

  describe "Stata.variance/1" do
    test "return variance of list or error on empty list" do
      assert [] |> Stat.variance == Option.error("Stat.mean: empty list")
      assert [1] |> Stat.variance == Option.ok(0.0)
      assert [1, 2, 3, 4] |> Stat.variance == Option.ok(1.25)
    end
  end
end
