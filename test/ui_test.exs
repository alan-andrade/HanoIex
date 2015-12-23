defmodule UITest do
  use ExUnit.Case

  defmodule UI do
    def draw_peg({ [], height }, level: _) do
      space = for _c <- 1..height, into: "", do: " "
      space <> "|" <> space
    end

    def draw_peg peg, level: level do
      { stack, height } = peg

      val = Enum.at(Enum.reverse(stack), level)

      if is_nil val do
        draw_peg({[], height}, level: level)
      else
        w = height - val
        space = if w > 0 do
          for _c <- 1..w, into: "", do: " "
        else
          ""
        end

        side = for _c <- 1..val, into: "", do: "#"
        disk = "#"
        space <> side <> disk <> side <> space
      end
    end

  end

  test "render frame" do
    peg = { [], 2 }
    assert UI.draw_peg(peg, level: 1) == "  |  "
    assert UI.draw_peg(peg, level: 0) == "  |  "

    peg = { [1], 2 }
    assert UI.draw_peg(peg, level: 1) == "  |  "
    assert UI.draw_peg(peg, level: 0) == " ### "

    peg = { [2], 2 }
    assert UI.draw_peg(peg, level: 1) == "  |  "
    assert UI.draw_peg(peg, level: 0) == "#####"

    peg = { [1, 2], 2 }
    assert UI.draw_peg(peg, level: 1) == " ### "
    assert UI.draw_peg(peg, level: 0) == "#####"

    peg = { [1, 2], 2 }
    assert UI.draw_peg(peg, level: 1) == " ### "
    assert UI.draw_peg(peg, level: 0) == "#####"

    peg = { [1, 2, 3], 3 }
    assert UI.draw_peg(peg, level: 2) == "  ###  "
    assert UI.draw_peg(peg, level: 1) == " ##### "
    assert UI.draw_peg(peg, level: 0) == "#######"

    peg = { [2], 3 }
    assert UI.draw_peg(peg, level: 2) == "   |   "
    assert UI.draw_peg(peg, level: 1) == "   |   "
    assert UI.draw_peg(peg, level: 0) == " ##### "
  end
end
