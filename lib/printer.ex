defmodule Printer do
  def p instruction do
    { from, to, stacks } = instruction
    [ A: a, B: b, C: c ] = stacks

    disks = a ++ b ++ c |>
            Enum.count

  end
end

