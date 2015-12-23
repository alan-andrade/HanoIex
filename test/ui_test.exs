defmodule UITest do
  use ExUnit.Case

  defmodule UI do
    def draw [], n do
      ' | '
    end

    def draw disk, n do
      spaces = if disk > n, do: 1..n - disk, else: []
      fill   = 1..(disk * 2 + 1)

      "" |>
      Enum.map(fn (x) -> for _c <- spaces, do: x <> " " end) |>
      Enum.map(fn (x) -> for _c <- fill, do: x <> "#" end)
      #for _c <- spaces, into: collector, do: " "
    end
  end

  test "render frame" do
    assert UI.draw([], 1 ) == ' | '
    assert UI.draw(1, 1) == "###"
    assert UI.draw(1, 2) == " ### "
    assert UI.draw(2, 2) == "#####"
    assert UI.draw(1, 3) == "  ###  "
    assert UI.draw(2, 3) == " ##### "
  end
end
