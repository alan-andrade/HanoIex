defmodule HanoIexTests do
  use ExUnit.Case

  test "alorithm count" do
    assert Hanoi.solve(1) |> Enum.count == :math.pow(2 , 1) - 1
    assert Hanoi.solve(2) |> Enum.count == :math.pow(2 , 2) - 1
    assert Hanoi.solve(3) |> Enum.count == :math.pow(2 , 3) - 1
    assert Hanoi.solve(4) |> Enum.count == :math.pow(2 , 4) - 1
  end
end
