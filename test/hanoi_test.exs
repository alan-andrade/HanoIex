defmodule HanoIexTests do
  use ExUnit.Case

  test "algorithm high level" do
    assert Hanoi.solve(1) |> Enum.count == :math.pow(2 , 1) - 1
    assert Hanoi.solve(2) |> Enum.count == :math.pow(2 , 2) - 1
    assert Hanoi.solve(3) |> Enum.count == :math.pow(2 , 3) - 1
    assert Hanoi.solve(4) |> Enum.count == :math.pow(2 , 4) - 1
  end

  test "algorithm low level" do
    assert Hanoi.solve(1) == [{:A, :C}]
    assert Hanoi.solve(2) == [{:A, :B},
                              {:A, :C},
                              {:B, :C}]
    assert Hanoi.solve(3) == [{:A, :C},
                              {:A, :B},
                              {:C, :B},
                              {:A, :C},
                              {:B, :A},
                              {:B, :C},
                              {:A, :C}]
  end

  test "play_sequence" do
    assert Hanoi.play_sequence(1) == [{ {:hanoi, :start},  A: [1], B: [], C: [ ] },
                                      { {:A, :C},          A: [ ], B: [], C: [1] } ]

    assert Hanoi.play_sequence(2) == [{ {:hanoi, :start},  A: [1, 2], B: [],  C: [ ]    },
                                      { {:A, :B},          A: [2],    B: [1], C: [ ]    },
                                      { {:A, :C},          A: [ ],    B: [1], C: [2]    },
                                      { {:B, :C},          A: [ ],    B: [ ], C: [1, 2] } ]

    assert Hanoi.play_sequence(3) ==
    [ { {:hanoi, :start},  A: [1, 2, 3], B: [ ],    C: [ ]       },
      { {:A, :C},          A: [2, 3],    B: [ ],    C: [1]       },
      { {:A, :B},          A: [3],       B: [2],    C: [1]       },
      { {:C, :B},          A: [3],       B: [1, 2], C: [ ]       },
      { {:A, :C},          A: [ ],       B: [1, 2], C: [3]       },
      { {:B, :A},          A: [1],       B: [2],    C: [3]       },
      { {:B, :C},          A: [1],       B: [ ],    C: [2, 3]    },
      { {:A, :C},          A: [ ],       B: [ ],    C: [1, 2, 3] } ]
  end
end
