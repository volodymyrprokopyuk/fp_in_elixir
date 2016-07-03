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

  describe "Option.filter/2" do
    test "returns error if predicate returns false" do
      t = fn _x -> true end
      f = fn _x -> false end
      assert Option.error("oh") |> Option.filter(t) == Option.error("oh")
      assert Option.error("oh") |> Option.filter(f) == Option.error("oh")
      assert Option.ok(1) |> Option.filter(t) == Option.ok(1)
      assert Option.ok(1) |> Option.filter(f) ==
        Option.error("Option.filter: predicate does not match")
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

defmodule RegExpTest do
  use ExUnit.Case
  @moduletag :ch_04

  describe "RegExp.match?/2" do
    test "matches pattern on string and returns boolean" do
      assert "*[ae]" |> RegExp.match?("xyz") ==
        Option.error({'nothing to repeat', 0})
      assert "[ae]" |> RegExp.match?("xyz") == Option.ok(false)
      assert "[ae]" |> RegExp.match?("xyza") == Option.ok(true)
    end
  end

  describe "RegExp.match2?/2" do
    test "matches pattern on string and returns boolean" do
      assert "*[ae]" |> RegExp.match2?("xyz") ==
        Option.error({'nothing to repeat', 0})
      assert "[ae]" |> RegExp.match2?("xyz") == Option.ok(false)
      assert "[ae]" |> RegExp.match2?("xyza") == Option.ok(true)
    end
  end
end
