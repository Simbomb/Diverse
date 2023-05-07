defmodule Primtal do

  def first(n) do
    list = Enum.to_list(2..n)
    floop(list, [])
  end

  def floop([], primes) do Enum.reverse(primes) end
  def floop(list, primes) do
    [h|t] = f(list)
    primes = [h | primes]
    floop(t, primes)
  end

  def f([]) do end
  def f([h|t]) do [h | Enum.filter(t, fn(x) -> rem(x, h) != 0 end)] end


  def second(n) do
    list = Enum.to_list(2..n)
    sloop(list, [])
  end

  def sloop([], primes) do primes end
  def sloop([h|t], primes) do
    check = s(h, primes)
    if check != 0 do
    primes = primes ++ [check]
    sloop(t, primes)
    else
    sloop(t, primes)
    end
  end

  def s(val, []) do val end
  def s(val, [h|t]) do

    if rem(val, h) == 0 do
    0
    else
    s(val, t)
    end
  end

  def third(n) do
    list = Enum.to_list(2..n)
    tloop(list, [])
  end

  def tloop([], primes) do Enum.reverse(primes) end
  def tloop([h|t], primes) do
    check = th(h, primes)
    if check != 0 do
    primes = [check | primes]
    tloop(t, primes)
    else
    tloop(t, primes)
    end
  end

  def th(val, []) do val end
  def th(val, [h|t]) do

    if rem(val, h) == 0 do
    0
    else
    th(val, t)
    end
  end
end

defmodule Bench do
  def bench(x) do
    tn=time1(x)
    ts=time2(x)
    tx=time3(x)
    :io.format("start1: ~8w us~n start2: ~8w us~n start3: ~8w us~n", [tn, ts, tx])
  end

    def time1(x) do
      start = System.monotonic_time(:milliseconds)
      Primtal.first(x)
      stop = System.monotonic_time(:milliseconds)
      stop - start
    end
    def time2(x) do
      start = System.monotonic_time(:milliseconds)
      Primtal.second(x)
      stop = System.monotonic_time(:milliseconds)
      stop - start
    end
    def time3(x) do
      start = System.monotonic_time(:milliseconds)
      Primtal.third(x)
      stop = System.monotonic_time(:milliseconds)
      stop - start
    end



end
