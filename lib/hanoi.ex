defmodule Hanoi.Solver do
  # Solution
  def solve n do
    moveTower(n, [:A, :C, :B])
  end

  defp moveTower(0, _), do: []
  defp moveTower(n, [source, dest, via]) when n > 0 do
    moveTower(n - 1, [source, via, dest]) ++
    moveDisk([source, dest]) ++
    moveTower(n - 1, [via, dest, source])
  end

  defp moveDisk([a, b]), do: [{ a, b }]
end

defmodule Hanoi.Sequencer do
  import Hanoi.Solver

  # Play sequence
  def play_sequence n do
    start = { {:hanoi, :start }, A: Enum.to_list(1..n),
                                 B: [],
                                 C: [] }

    _play_sequence(solve(n), [start])
  end

  defp _play_sequence( [], state ), do: state
  defp _play_sequence([current_move | moves], states) do
    [ hd(states) | _play_sequence(moves, _play_sequence(current_move, states)) ]
  end

  defp _play_sequence { source, dest }, state do
    { _, pegs } = hd(state)
    spare = hd([:A, :B, :C] -- [source, dest])

    # towers
    source_tower = pegs[source]
    dest_tower   = pegs[dest]
    spare_tower  = pegs[spare]

    result = List.keysort([
      { source, tl(source_tower) },
      { dest, [ hd(source_tower) | dest_tower ] },
      { spare, spare_tower }
    ], 0)

    [ { {source, dest} , result } ]
  end
end

defmodule Hanoi.UI do
  import Hanoi.Sequencer

  def player n do
    play_sequence(n) |>
    Enum.map(&prepare(&1)) |>
    Enum.map(&frame&1)
  end

  def prepare step do
    # { {:A, :C}, A: [ ], B: [], C: [1] }
    { _move, [A: a, B: b, C: c] } = step
    size = Enum.count a ++ b ++ c

    # ignoring move for now, just pegs
    [ {a, size}, {b, size}, {c, size} ]
  end

  def frame pegs do
    { _stack, size } = hd pegs

    (for level <- (size-1..0) do
      for peg <- pegs, into: "" do
        draw_peg(peg, level: level)
      end
    end |> Enum.join("\n")) <> "\n"
  end

  def draw pegs, level: level do
    for peg <- pegs, into: "", do: draw_peg(peg, level: level)
  end

  def draw_peg {stack, height}, level: level do
    size = Enum.reverse(stack) |> Enum.at(level, 0)

    str = if size > 0, do: "#", else: "|"
    disk  = repeat(str, (size * 2 + 1)) # times 2 is both sides, plus one is the center piece.
    space = repeat(" ", height - size)
    space <> disk <> space
  end

  defp repeat(_, 0), do: ""
  defp repeat(str, n), do: for _ <- 1..n, into: "", do: str
end
