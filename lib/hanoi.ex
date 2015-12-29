defmodule Hanoi.UI do
  import Hanoi.Generator

  def player n do
    gen(n) |>
    Enum.map(&prepare(&1)) |>
    Enum.map(&frame&1)
  end

  def prepare step do
    # { {:A, :C}, A: [ ], B: [], C: [1] }
    { _move, [A: a, B: b, C: c] } = step
    mag = Enum.count a ++ b ++ c

    # ignoring move for now, just pegs
    [ {a, mag}, {b, mag}, {c, mag} ]
  end

  def frame pegs do
    { _stack, mag } = hd pegs

    (for level <- (mag..0) do
      for peg <- pegs, into: "" do
        draw_peg(peg, level: level)
      end
    end |> Enum.join("\n")) <> "\n"
  end

  def draw pegs, level: level do
    for peg <- pegs, into: "", do: draw_peg(peg, level: level)
  end

  def draw_peg {stack, height}, level: level do
    mag = Enum.reverse(stack) |> Enum.at(level, 0)
    draw_peg(mag, height)
  end

  def draw_peg 0, height do
    stem = repeat("|", 1)
    space = repeat(" ", height - 1)
    space <> stem <> space
  end

  def draw_peg mag, height do
    disk  = repeat("#", (mag - 1) * 2 + 1)
    space = repeat(" ", height - mag)
    space <> disk <> space
  end

  defp repeat(_, 0), do: ""
  defp repeat(str, n), do: for _ <- 1..n, into: "", do: str

  def run do
    _run(player(4), 0)
  end

  def _run player, pos do
    IO.puts IO.ANSI.clear <> IO.ANSI.home <> Enum.at(player, pos)

    case String.strip(IO.read(:line)) do
      "k" -> _run(player, pos+1)
      "j" -> _run(player, pos-1)
    end
  end
end
