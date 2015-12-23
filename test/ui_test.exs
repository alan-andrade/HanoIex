defmodule UITest do
  use ExUnit.Case

  defmodule UI do
    def player n do
      Hanoi.play_sequence(n) |>
      Enum.map(&UI.prepare(&1)) |>
      Enum.map(&UI.frame&1)
    end

    def prepare step do
      # { {:A, :C}, A: [ ], B: [], C: [1] }
      { move, [A: a, B: b, C: c] } = step
      size = Enum.count a ++ b ++ c

      # ignoring move for now, just pegs
      [ {a, size}, {b, size}, {c, size} ]
    end

    def frame pegs do
      { stack, size } = hd pegs

      (for level <- (size-1..0) do
        for peg <- pegs, into: "" do
          draw_peg(peg, level: level)
        end
      end |> Enum.join("\n")) <> "\n"
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

  test "render frame" do
    pegs = [ { [1], 2},
             { [],  2} ]

    assert UI.frame(pegs) == "  |    |  \n" <>
                             " ###   |  \n"

    pegs = [ { [1], 2},
             { [2], 2} ]

    assert UI.frame(pegs) == "  |    |  \n" <>
                             " ### #####\n"
  end

  test "integration" do
    step = hd(Hanoi.play_sequence(1))
    assert UI.prepare(step) == [{[1], 1}, {[], 1}, {[], 1}]
  end
end
