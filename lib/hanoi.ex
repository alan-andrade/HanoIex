defmodule Hanoi do
  #def move collector, 0, _ do
    #collector
  #end

  #def move collector, 1, opts do
    #{_, _, pegs} = hd(collector)
    #[A: a, B: b, C: c] = pegs

    #moves = case opts do
      #[from: :A, to: :B] when length(a) > 0 ->
        #[headA|tailA] = a

        #[ A: tailA,
          #B: [headA|b],
          #C: c ]

      #[from: :A, to: :C] when length(a) > 0 ->
        #[headA|tailA] = a

        #[ A: tailA,
          #B: b,
          #C: [headA|c] ]

      #[from: :B, to: :C] when length(b) > 0 ->
        #[headB|tailB] = b

        #[ A: a,
          #B: tailB,
          #C: [headB|c] ]

        #_ ->
          #[A: a, B: b, C: c]
    #end

    #[{ opts[:from], opts[:to], moves } | collector ]
  #end

  #def move collector, n, opts do
    #move(collector, n - 1, opts)
  #end

  ##def build_hanoi pegs, n, opts do
  ##end

  #def build_hanoi n do
    #pegs = [ A: Enum.to_list(1..n),
             #B: [ ],
             #C: [ ]]

    ## build_hanoi(n - 1, from: :A, to: :B)
    #[{ :A, :A, pegs }] |>
    #move(n - 1, from: :A, to: :B) |>
    #move(n    , from: :A, to: :C) |>
    #move(n - 1, from: :B, to: :C) |>
    #Enum.reverse
  #end

  #def solve({ [a, b, c], history }, 0, moves) do
    #result = case moves do
      #[from: :A, to: :B] when length(a) > 0 -> [ tl(a), c ++ [hd(a)], c ]
      #[from: :A, to: :C] when length(a) > 0 -> [ tl(a), b, c ++ [hd(a)] ]
      #[from: :B, to: :C] when length(b) > 0 -> [ a, tl(b), c ++ [hd(b)] ]
      #_ -> [a, b, c]
    #end

    #{ result, [history | moves] }
  #end

  def solve({ pegs, history }, n, moves) do
    if n == 0 do
      [a, b, c] = pegs

      result = case moves do
        [from: :A, to: :B] when length(a) > 0 -> [ tl(a), c ++ [hd(a)], c ]
        [from: :A, to: :C] when length(a) > 0 -> [ tl(a), b, c ++ [hd(a)] ]
        [from: :B, to: :C] when length(b) > 0 -> [ a, tl(b), c ++ [hd(b)] ]
        _ -> pegs
      end

      { result, [moves | history] }
    else
      { pegs, history } |>
      solve(n - 1, from: :A, to: :B) |>
      solve(0,     from: :A, to: :C) |>
      solve(n - 1, from: :B, to: :C)
    end
  end

  def solve pegs, n do
    input = { pegs, [] }
    input |> solve(n, from: :A, to: :C)
  end


  def solve [a, b, c] do
    solve [a, b, c], Enum.count a ++ b ++ c
  end

end
