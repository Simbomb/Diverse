defmodule Shunt do

  def find([], _) do [] end
  def find(_, []) do [] end

  def find(train1, train2) do
    find(train1, train2, [])
  end

  def find(_, [], moves) do moves end
  def find(train1, train2, moves) do
    {h1, t1} = split(train1, hd(train2))
    move1 = {:one, length(t1) + 1}
    move2 = {:two, length(h1)}
    move3 = {:one, -length(t1) - 1}
    move4 = {:two, -length(h1)}
    {train1, b, c} = Train.single(move1, {train1, [], []})
    {train1, b, c} = Train.single(move2, {train1, b, c})
    {train1, b, c} = Train.single(move3, {train1, b, c})
    {train1, b, c} = Train.single(move4, {train1, b, c})
    moves = moves ++ [move1, move2, move3, move4]
    find(List.delete(train1, hd(train2)), tl(train2), moves)
  end

  def split(train, wagon) do
    pos = Lists.position(train, wagon)
    {Lists.take(train, pos-1), Lists.drop(train, pos)}
  end


  def few([], _) do [] end
  def few(_, []) do [] end

  def few(train1, train2) do
    few(train1, train2, [])
  end

  def few([], [], moves) do moves end
  def few(train1, train2, moves) do
    if hd(train1) == hd(train2) do few(tl(train1), tl(train2), moves)
  else
    {h1, t1} = split(train1, hd(train2))
    move1 = {:one, length(t1) + 1}
    move2 = {:two, length(h1)}
    move3 = {:one, -length(t1) - 1}
    move4 = {:two, -length(h1)}
    {train1, b, c} = Train.single(move1, {train1, [], []})
    {train1, b, c} = Train.single(move2, {train1, b, c})
    {train1, b, c} = Train.single(move3, {train1, b, c})
    {train1, b, c} = Train.single(move4, {train1, b, c})
    moves = moves ++ [move1, move2, move3, move4]
    few(List.delete(train1, hd(train2)), tl(train2), moves)
  end

  end

end
