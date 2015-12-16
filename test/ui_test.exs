defmodule UITest do
  use ExUnit.Case

  defmodule UI do
    def draw :peg, data do
      # [1]
      # width = magn * 
    end
  end

  test "draw tower" do
    result = UI.draw(:peg, [1, 2])

    IO.puts result
    assert result == '  x  \n' ++
                     ' xxx \n'
  end
end
