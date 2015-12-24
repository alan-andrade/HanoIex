defmodule UITest do
  use ExUnit.Case

  import Hanoi.UI

  test "draw peg" do
    peg = { [], 2 }
    assert draw_peg(peg, level: 2) == " | "
    assert draw_peg(peg, level: 1) == " | "
    assert draw_peg(peg, level: 0) == " | "

    peg = { [1], 2 }
    assert draw_peg(peg, level: 2) == " | "
    assert draw_peg(peg, level: 1) == " | "
    assert draw_peg(peg, level: 0) == " # "

    peg = { [2], 2 }
    assert draw_peg(peg, level: 2) == " | "
    assert draw_peg(peg, level: 1) == " | "
    assert draw_peg(peg, level: 0) == "###"

    peg = { [1, 2], 2 }
    assert draw_peg(peg, level: 2) == " | "
    assert draw_peg(peg, level: 1) == " # "
    assert draw_peg(peg, level: 0) == "###"

    peg = { [1, 2], 2 }
    assert draw_peg(peg, level: 2) == " | "
    assert draw_peg(peg, level: 1) == " # "
    assert draw_peg(peg, level: 0) == "###"

    peg = { [1, 2, 3], 3 }
    assert draw_peg(peg, level: 3) == "  |  "
    assert draw_peg(peg, level: 2) == "  #  "
    assert draw_peg(peg, level: 1) == " ### "
    assert draw_peg(peg, level: 0) == "#####"

    peg = { [2], 3 }
    assert draw_peg(peg, level: 2) == "  |  "
    assert draw_peg(peg, level: 2) == "  |  "
    assert draw_peg(peg, level: 1) == "  |  "
    assert draw_peg(peg, level: 0) == " ### "
  end

  test "render collection of pegs" do
    pegs = [ { [1], 2},
             { [],  2} ]

    assert draw(pegs, level: 2) == " |  | "
    assert draw(pegs, level: 1) == " |  | "
    assert draw(pegs, level: 0) == " #  | "

    pegs = [ { [1, 2], 2},
             { [],     2} ]

    assert draw(pegs, level: 2) == " |  | "
    assert draw(pegs, level: 1) == " #  | "
    assert draw(pegs, level: 0) == "### | "
  end

  test "render frame" do
    pegs = [ { [1], 2},
             { [],  2} ]

    assert frame(pegs) == " |  | \n" <>
                          " |  | \n" <>
                          " #  | \n"
    pegs = [ { [1], 2},
             { [2], 2} ]

    assert frame(pegs) == " |  | \n" <>
                          " |  | \n" <>
                          " # ###\n"
  end

  test "integration" do
    import Hanoi.Sequencer
    step = hd(play_sequence(1))
    assert prepare(step) == [{[1], 1}, {[], 1}, {[], 1}]
  end

  test "run" do
    # Hanoi.UI.run
  end
end
