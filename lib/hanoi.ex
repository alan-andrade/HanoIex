defmodule Hanoi do
  def solve n do
    IO.puts "Hanoi of : #{n}"
    moveTower(n, [:A, :B, :C])
  end

  def moveTower(n, [source, dest, via]) do
    if n > 0 do
      moveTower(n - 1, [source, via, dest]) ++
      moveDisk([source, dest]) ++
      moveTower(n - 1, [via, dest, source])
    else
      []
    end
  end

  def moveDisk [a, b] do
    IO.puts "#{a} -> #{b}"
    [[a, b]]
  end


end
