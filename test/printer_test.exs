defmodule PrinterTest do
  use ExUnit.Case

  test "prints 1" do
    instruction = { :A, :A, [ A: [ 1, 2], B: [], C: [] ] }
    res = Printer.p(instruction)

    assert res == "  ###     |      |    \n" <>
                  " #####  #####  #####  \n" <>
                  "======================\n"
  end

end
