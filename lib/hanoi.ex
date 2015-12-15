defmodule Hanoi do
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

  # play sequence

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
