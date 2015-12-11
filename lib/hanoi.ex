defmodule Hanoi do
  def solve n do
    IO.puts "Hanoi of : #{n}"
    moveTower(n, [:A, :B, :C])
  end

  def moveTower(0, _), do: []

  def moveTower(n, [source, dest, via]) when n > 0 do
    moveTower(n - 1, [source, via, dest]) ++
    moveDisk([source, dest]) ++
    moveTower(n - 1, [via, dest, source])
  end

  def moveDisk [a, b] do
    IO.puts "#{a} -> #{b}"
    [[a, b]]
  end


end
