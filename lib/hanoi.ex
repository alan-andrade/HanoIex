defmodule Hanoi do
  def move collector, 0, _ do
    collector
  end

  def move collector, 1, opts do
    {_, _, pegs} = hd(collector)
    [A: a, B: b, C: c] = pegs

    moves = case opts do
      [from: :A, to: :B] when length(a) > 0 ->
        [headA|tailA] = a

        [ A: tailA,
          B: [headA|b],
          C: c ]

      [from: :A, to: :C] when length(a) > 0 ->
        [headA|tailA] = a

        [ A: tailA,
          B: b,
          C: [headA|c] ]

      [from: :B, to: :C] when length(b) > 0 ->
        [headB|tailB] = b

        [ A: a,
          B: tailB,
          C: [headB|c] ]

        _ ->
          [A: a, B: b, C: c]
    end

    [{ opts[:from], opts[:to], moves } | collector ]
  end

  def move collector, n, opts do
    move(collector, n - 1, opts)
  end


  def build_hanoi n do
    pegs = [ A: Enum.to_list(1..n),
             B: [ ],
             C: [ ]]

    [{ :A, :A, pegs }] |>
    move(n - 1, from: :A, to: :B) |>
    move(n    , from: :A, to: :C) |>
    move(n - 1, from: :B, to: :C) |>
    Enum.reverse
  end
end
