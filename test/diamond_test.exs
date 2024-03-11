defmodule DiamondTest do
  use ExUnit.Case

  test "put/1" do
    assert :ok = Diamond.initialize(test_data())

    Diamond.put(bar: 2, baz: 3)
    assert Diamond.get(:bar) == 2
    assert Diamond.get(:baz) == 3
  end

  test "put/2" do
    assert :ok = Diamond.initialize(test_data())

    Diamond.put(:foo, 1)
    assert Diamond.get(:foo) == 1
  end

  defp test_data do
    Enum.map(1..10_000, fn id -> {id, "value"} end)
  end
end
