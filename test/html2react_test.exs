defmodule Html2reactTest do
  use ExUnit.Case
  doctest Html2react

  test "correctly parses html to react" do
    assert Html2react.parse("<div class='test'>Hello</div>") ==
             "<div className='test'>Hello</div>"
  end
end
