defmodule Moves do

  def move(moves, train) do
    states = List.insert_at([], 0, train)
    move(moves, train, states, 1) end
    def move([], train, states, index) do states end

  def move([h|t], train, states, index) do
    if length(t) < 1 do move([], train, states, index) end
    states = List.insert_at(states, index, Train.single(h, train))
    train = Train.single(h, train)
    move(t, train, states, index + 1)
  end

end
