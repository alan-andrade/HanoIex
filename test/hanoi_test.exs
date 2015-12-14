defmodule HanoIexTests do
  use ExUnit.Case

  test "alorithm tests" do
    assert Hanoi.solve(1) |> Enum.count == :math.pow(2 , 1) - 1
    assert Hanoi.solve(2) |> Enum.count == :math.pow(2 , 2) - 1
    assert Hanoi.solve(3) |> Enum.count == :math.pow(2 , 3) - 1
    assert Hanoi.solve(4) |> Enum.count == :math.pow(2 , 4) - 1
  end

  test "moves" do
    assert Hanoi.steps(2) |>
           Hanoi.inject_data == [
             { [:start], [1], [ ], [ ] },
             { [:A, :C], [ ], [ ], [1] }]
  end
end
