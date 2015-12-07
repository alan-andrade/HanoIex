defmodule HanoIexTests do
  use ExUnit.Case

  test "base case" do
    steps = HanoIex.build_hanoi 1

    assert steps ==
    [
      { :A, :A, [ A: [1],
                  B: [ ],
                  C: [ ] ] },
      { :A, :C, [ A: [ ],
                  B: [ ],
                  C: [1] ] }
    ]
  end

  test "2 disks" do
    steps = HanoIex.build_hanoi 2
    assert steps == [
      { :A, :A, [ A: [1, 2],
                  B: [ ],
                  C: [ ] ] },
      { :A, :B, [ A: [2],
                  B: [1],
                  C: [ ] ]
      },
      { :A, :C, [ A: [ ],
                  B: [1],
                  C: [2] ]
      },
      { :B, :C, [ A: [ ],
                  B: [ ],
                  C: [1, 2] ]
      }
    ]
  end
end
