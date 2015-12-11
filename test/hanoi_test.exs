defmodule HanoIexTests do
  use ExUnit.Case

  test "one disk" do
    assert Hanoi.solve(1) |> Enum.count == 1
    assert Hanoi.solve(2) |> Enum.count == 3
    assert Hanoi.solve(3) |> Enum.count == 7
  end
end
