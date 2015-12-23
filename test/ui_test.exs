defmodule UITest do
  use ExUnit.Case

  defmodule UI do
    def draw_peg {stack, height}, level: level do
      size = Enum.reverse(stack) |> Enum.at(level, 0)

      str = if size > 0, do: "#", else: "|"
      disk  = repeat(str, (size * 2 + 1)) # times 2 is both sides, plus one is the center piece.
      space = repeat(" ", height - size)
      space <> disk <> space
    end

    defp repeat(str, 0), do: ""
    defp repeat(str, n), do: for _ <- 1..n, into: "", do: str
  end

  test "render frame" do
    peg = { [], 2 }
    assert UI.draw_peg(peg, level: 1) == "  |  "
    assert UI.draw_peg(peg, level: 0) == "  |  "

    peg = { [1], 2 }
    assert UI.draw_peg(peg, level: 1) == "  |  "
    assert UI.draw_peg(peg, level: 0) == " ### "

    peg = { [2], 2 }
    assert UI.draw_peg(peg, level: 1) == "  |  "
    assert UI.draw_peg(peg, level: 0) == "#####"

    peg = { [1, 2], 2 }
    assert UI.draw_peg(peg, level: 1) == " ### "
    assert UI.draw_peg(peg, level: 0) == "#####"

    peg = { [1, 2], 2 }
    assert UI.draw_peg(peg, level: 1) == " ### "
    assert UI.draw_peg(peg, level: 0) == "#####"

    peg = { [1, 2, 3], 3 }
    assert UI.draw_peg(peg, level: 2) == "  ###  "
    assert UI.draw_peg(peg, level: 1) == " ##### "
    assert UI.draw_peg(peg, level: 0) == "#######"

    peg = { [2], 3 }
    assert UI.draw_peg(peg, level: 2) == "   |   "
    assert UI.draw_peg(peg, level: 1) == "   |   "
    assert UI.draw_peg(peg, level: 0) == " ##### "
  end
end
