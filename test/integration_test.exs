defmodule IntegrationTest do
  use ExUnit.Case

  import Hanoi.UI

  test "integration test: player/1 generates expected number of frames" do
    # For n=3, there are 2^3 - 1 = 7 moves, so 8 frames total (start + 7 moves)
    n = 3
    frames = player(n)

    assert length(frames) == 8

    # Ensure the first frame has all disks on the first peg (A)
    # The last frame has all disks on the last peg (C)

    first_frame = Enum.at(frames, 0)
    last_frame = Enum.at(frames, -1)

    # Frame 1 has all disks on peg A (leftmost)
    assert first_frame == "  |    |    |  \n  #    |    |  \n ###   |    |  \n#####  |    |  \n"

    # Last frame has all disks on peg C (rightmost)
    assert last_frame == "  |    |    |  \n  |    |    #  \n  |    |   ### \n  |    |  #####\n"
  end
end
