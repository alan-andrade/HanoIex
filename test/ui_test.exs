defmodule UITest do
  use ExUnit.Case

  defmodule UI do
    def frame pegs do
      { _, size } = hd pegs

      IO.inspect size

      for level <- (size-1)..0 do
        Enum.reduce(pegs, "", fn(peg, acc) ->
          draw(peg, level: level) ++ acc
        end)
      end
    end

    def draw pegs, level: level do
      for peg <- pegs, into: "", do: UI.draw_peg(peg, level: level)
    end

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

  test "render peg" do
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

  test "render collection of pegs" do
    pegs = [ { [1], 2},
             { [],  2} ]

    assert UI.draw(pegs, level: 1) == "  |    |  "
    assert UI.draw(pegs, level: 0) == " ###   |  "

    pegs = [ { [1, 2], 2},
             { [],     2} ]

    assert UI.draw(pegs, level: 1) == " ###   |  "
    assert UI.draw(pegs, level: 0) == "#####  |  "
  end

  test "render game" do
    pegs = [ { [1], 2},
             { [],  2} ]

    assert UI.frame(pegs) == "  |    |  " <>
                             " ###   |  "
  end
end
