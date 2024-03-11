defmodule DiamondTest do
  use ExUnit.Case
  doctest Diamond

  test "greets the world" do
    assert Diamond.hello() == :world
  end
end
