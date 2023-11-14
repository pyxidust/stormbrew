defmodule StormbrewTest do
  use ExUnit.Case
  doctest Stormbrew

  test "greets the world" do
    assert Stormbrew.hello() == :world
  end
end
