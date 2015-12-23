defmodule SolverTests do
  use ExUnit.Case
  import Hanoi.Solver

  test "algorithm high level" do
    assert solve(1) |> Enum.count == :math.pow(2 , 1) - 1
    assert solve(2) |> Enum.count == :math.pow(2 , 2) - 1
    assert solve(3) |> Enum.count == :math.pow(2 , 3) - 1
    assert solve(4) |> Enum.count == :math.pow(2 , 4) - 1
  end

  test "algorithm low level" do
    assert solve(1) == [{:A, :C}]
    assert solve(2) == [{:A, :B},
                        {:A, :C},
                        {:B, :C}]
    assert solve(3) == [{:A, :C},
                        {:A, :B},
                        {:C, :B},
                        {:A, :C},
                        {:B, :A},
                        {:B, :C},
                        {:A, :C}]
  end
end
