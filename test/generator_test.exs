defmodule GeneratorTest do
  use ExUnit.Case

  test "generator" do
    import Hanoi.Generator

    assert gen(3) ==
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
