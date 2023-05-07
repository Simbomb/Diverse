defmodule Train do

  def single({_, 0}, tuple) do
    tuple
  end
  def single({:one, x},{a,b,c}) do
    if x > 0 do
    if length(a) > x do
    {Lists.take(a, x), Lists.append(Lists.drop(a, x), b), c}
    else
      {Lists.drop(a, x), Lists.append(a, b), c}
    end
    else
      x = abs(x)
      {Lists.append(a, Lists.take(b, x)), Lists.drop(b, x), c}
    end
  end
  def single({:two, x},{a,b,c}) do

    if x > 0 do
      if length(a) > x do
      {Lists.take(a, x), b , Lists.append(Lists.drop(a, x), c)}
      else
        {Lists.drop(a, x), b ,Lists.append(a, c)}
      end
    else
        x = abs(x)
        {Lists.append(a, Lists.take(c, x)), b , Lists.drop(c, x)}
      end
  end

end
