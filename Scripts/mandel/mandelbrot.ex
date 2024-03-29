defmodule Brot do

def mandelbrot(c, iteration) do
  comp = Cmplx.new(0, 0)
  test(0, comp, c, iteration)

end

def test(i, comp, c, 0) do 0 end
def test(i, comp, c, iteration) do
if Cmplx.abs(comp) <= 2 do
  comp = Cmplx.add(Cmplx.sqr(comp), c)
  test(i + 1, comp, c, iteration - 1)
else
  i
end
end


end


defmodule Cmplx do

  def new(r, i) do
    {r, i}
  end

  def add({r1, i1}, {r2, i2}) do
    {r1 + r2, i1 + i2}
  end

  def sqr({r, i}) do
    {r * r - i * i, 2 * r * i}
  end

  def abs({r, i}) do
    :math.sqrt(r * r + i * i)
  end

end


defmodule Color do

  def convert(depth, max) do
  a = depth/max * 4
  x = trunc(a)
  y = trunc(255 * (a - x))

  case x do
    0 -> {:rgb,0, y, 0}
    1 -> {:rgb,255, 0, y}
    2 -> {:rgb,255, 255 - y, 0}
    3 -> {:rgb,255, 0, y}
    4 -> {:rgb,255-y, 0, 255}
  end

  end

end

defmodule Mandel do

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) -> Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end
    rows(width, height, trans, depth, [])
  end

  def rows(width, 0, trans, depth, list) do
    list
  end
  def rows(width, height, trans, depth, list) do
    add = newrow(width, height, trans, depth, [])
    rows(width, height - 1, trans, depth, [add | list])
  end

  def newrow(0, h, t, d, list) do list end
  def newrow(w, h, t, depth, list) do
    mandel = Brot.mandelbrot(t.(w, h), depth)
    color = Color.convert(mandel, depth)
    newrow(w - 1, h, t, depth, [color | list])
  end


end


defmodule PPM do

  # write(name, image) The image is a list of rows, each row a list of
  # tuples {R,G,B}. The RGB values are 0-255.

  def write(name, image) do
    height = length(image)
    width = length(List.first(image))
    {:ok, fd} = File.open(name, [:write])
    IO.puts(fd, "P6")
    IO.puts(fd, "#generated by ppm.ex")
    IO.puts(fd, "#{width} #{height}")
    IO.puts(fd, "255")
    rows(image, fd)
    File.close(fd)
  end

  defp rows(rows, fd) do
    Enum.each(rows, fn(r) ->
      colors = row(r)
      IO.write(fd, colors)
    end)
  end

  defp row(row) do
    List.foldr(row, [], fn({:rgb, r, g, b}, a) ->
      [r, g, b | a]
    end)
  end

end

defmodule Test do

  def demo() do
    small(-0.745428, 1.0405, 0.032)
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", image)
  end

end
