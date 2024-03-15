defmodule DiamondTest do
  use ExUnit.Case

  test "simple data" do
    assert :ok = Diamond.initialize(test_data())

    assert Diamond.get(579) == "value"
  end

  defp test_data do
    Enum.map(1..10_000, fn id -> {id, "value"} end)
  end
end
