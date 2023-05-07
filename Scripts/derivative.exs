defmodule Derivative do

@type literal() :: {:num, number()} | {:var, atom()}

@type expr() :: literal()
| {:add, expr(), expr()}
| {:mul, expr(), expr()}
| {:exp, expr(), literal()}
| {:ln, expr()}
| {:sin, expr()}
| {:cos, expr()}

def ln() do

e =  {:ln, {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 5}}}
d = der(e, :x)
IO.write("expression: #{pprint(e)}\n")
IO.write("derivative: #{pprint(d)}\n")
IO.write("simplified: #{pprint(simplify(d))}\n")

end

def test() do
  e = {:add,{:add,{:mul,{:num,4},{:exp,{:var, :x},{:num,2}}}, {:mul,{:num, 2},{:var, :x}}},{:num, 5}}
  d = der(e, :x)
  c = calc(d, :x, 2)
  IO.write("expression: #{pprint(e)}\n")
  IO.write("derivative: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")-
  IO.write("calculated: #{pprint(simplify(c))}\n")
  :ok
  end


def minexp() do
e = {:exp, {:mul, {:num, 5}, {:var, :x}}, {:num, -3}}
d = der(e, :x)
c = calc(d, :x, 4)
IO.write("expression: #{pprint(e)}\n")
IO.write("derivative: #{pprint(d)}\n")
IO.write("simplified: #{pprint(simplify(d))}\n")
IO.write("calculated: #{pprint(simplify(c))}\n")
:ok
end

def sqr() do
  e = {:exp, {:mul, {:num, 5}, {:var, :x}}, {:num, 0.5}}
  d = der(e, :x)
  c = calc(d, :x, 4)
  IO.write("expression: #{pprint(e)}\n")
  IO.write("derivative: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  IO.write("calculated: #{pprint(simplify(c))}\n")
  :ok
end

def sincos() do
  e = {:sin, {:cos, {:mul, {:var, :x}, {:num, 5}}}}
  d = der(e, :x)
  c = calc(d, :x, :math.pi/4)
  IO.write("expression: #{pprint(e)}\n")
  IO.write("derivative: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  IO.write("calculated: #{pprint(simplify(c))}\n")
  :ok
end


def der({:num, _}, _) do {:num, 0} end
def der({:var, v}, v) do {:num, 1} end
def der({:var, _}, _) do {:num, 0} end
def der({:add, e1, e2}, v) do {:add, der(e1,v), der(e2, v)}
end
def der({:mul, e1, e2}, v) do {:add, {:mul, der(e1, v), e2}, {:mul, e1, der(e2, v)}}
end
def der({:exp, e, {:num, n}}, v) do {:mul, {:mul, {:num, n}, {:exp, e, {:num, n-1}}}, der(e,v)}
end
def der({:ln, e}, v) do {:mul, der(e, v), {:exp, e, {:num, -1}}}  end
def der({:sin, e}, v) do {:mul, der(e, v), {:cos, e}} end
def der({:cos, e}, v) do {:mul, {:num, -1}, {:mul, der(e, v), {:sin, e}}} end



def calc({:num, n}, _, _) do {:num, n} end
def calc({:var, v}, v, n) do {:num, n} end
def calc({:var, v}, _, _) do {:var, v} end
def calc({:add, e1, e2}, v, n) do {:add, calc(e1, v, n), calc(e2, v, n)} end
def calc({:mul, e1, e2}, v, n) do {:mul, calc(e1, v, n), calc(e2, v, n)} end
def calc({:exp, e1, e2}, v, n) do {:exp, calc(e1, v, n), calc(e2, v, n)} end
def calc({:sin, e1}, v, n) do {:sin, calc(e1, v, n)} end
def calc({:cos, e1}, v, n) do {:cos, calc(e1, v, n)} end


def simplify({:add, e1, e2}) do simplify_add(simplify(e1), simplify(e2)) end
def simplify({:mul, e1, e2}) do simplify_mul(simplify(e1), simplify(e2)) end
def simplify({:exp, e1, e2}) do simplify_exp(simplify(e1), simplify(e2)) end
def simplify({:sin, e}) do simplify_sin(simplify(e)) end
def simplify({:cos, e}) do simplify_cos(simplify(e)) end
def simplify(e) do e end

def simplify_add({:num, 0}, e2) do e2 end
def simplify_add(e1, {:num, 0}) do e1 end
def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
def simplify_add(e1, e2) do {:add, e1, e2} end

def simplify_mul({:num, 0}, _) do {:num, 0} end
def simplify_mul(_, {:num, 0}) do {:num, 0} end
def simplify_mul({:num, 1}, e2) do e2 end
def simplify_mul(e1, {:num, 1}) do e1 end
def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
def simplify_mul(e1, e2) do {:mul, e1, e2} end

def simplify_exp(_, {:num, 0}) do {:num, 1} end
def simplify_exp(e1, 1) do e1 end
def simplify_exp({:num, n1}, {:num, n2}) do {:num, :math.pow(n1, n2)} end
def simplify_exp(e1, e2) do {:exp, e1, e2} end


def simplify_sin( {:num, n}) do {:num, :math.sin(n)} end
def simplify_sin(e) do {:sin, e} end
def simplify_cos({:num, n}) do {:num, :math.cos(n)} end
def simplify_cos(e) do {:cos, e} end

def pprint({:num, n}) do "#{n}" end
def pprint({:var, v}) do "#{v}" end
def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
def pprint({:mul, e1, e2}) do "#{pprint(e1)} * #{pprint(e2)}" end
-
def pprint({:sin, e}) do "sin(#{pprint(e)})" end
def pprint({:cos, e}) do "cos(#{pprint(e)})" end


end
