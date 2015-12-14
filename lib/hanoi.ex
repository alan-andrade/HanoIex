defmodule Hanoi do
  def solve n do
    moveTower(n, [:A, :B, :C])
  end

  def steps n do
    [ size: n, moves: solve(n) ]
  end

  defp moveTower(0, _), do: []
  defp moveTower(n, [source, dest, via]) when n > 0 do
    moveTower(n - 1, [source, via, dest]) ++
    moveDisk([source, dest]) ++
    moveTower(n - 1, [via, dest, source])
  end

  defp moveDisk([a, b]), do: [[a, b]]

  def inject_data size: n, moves: moves do
    # [
    # [:A, :b]  [{:A, a}, {:B, b}, {:C, b}]
    moves |>
    inject_data( A: Enum.to_list(1..n),
                 B: [],
                 C: [])
  end

  def inject_data moves, pegs do
    moves |>
    Enum.reduce(pegs, fn (move, acc) ->
      [source | dest] = move
      via = ([:A, :B, :C] -- [source, dest])

      IO.inspect via
      IO.inspect [source, dest, via]

      [ { ^source, source_tower },
        { ^dest, dest_tower },
        { ^via, via_tower }
      ] = pegs

      if length(pegs[source]) > 0 do
        [
          { source, tl(source_tower) },
          { dest, [ hd(source_tower) | dest_tower ] },
          { via, via_tower }
        ]
      else
        [
          { source, source_tower },
          { dest, dest_tower },
          { via, via_tower }
        ]
      end
    end) |> Enum.map(fn (move, [A: a, B: b, C: c ]) ->
      { move, a, b, c }
    end)
  end
end
