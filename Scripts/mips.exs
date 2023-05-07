defmodule Emulator do
  def run(code, data) do
    out = Out.new()
    reg = Register.new()
    run(0, code, reg, data, out)
  end
  def run(pc, code, reg, data, out) do
    next = Program.read_instruction(code, pc)
   case next do
     {:halt} ->
     IO.inspect(Map.to_list(data), label: "Map")
     Out.close(out)

     {:out, rs} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        out = Out.put(out, s)
        run(pc, code, reg, data, out)

      {:add, rd, rs, rt} ->
        pc = pc + 4
        val1 = Register.read(reg, rs)
        val2 = Register.read(reg, rt)
        reg = Register.write(reg, rd, val1 + val2)
        run(pc, code, reg, data, out)

      {:sub, rd, rs, rt} ->
        pc = pc + 4
        val1 = Register.read(reg, rs)
        val2 = Register.read(reg, rt)
        reg = Register.write(reg, rd, val1 - val2)
        run(pc, code, reg, data, out)

      {:addi, rd, rs, imm} ->
          pc = pc + 4
          val1 = Register.read(reg, rs)
          reg = Register.write(reg, rd, val1 + imm)
          run(pc, code, reg, data, out)

      {:lw, rt, imm, rs} ->
            pc = pc + 4
            valrs = Register.read(reg, rs)
            address = valrs + imm
            val = Program.read(data, address)
            reg = Register.write(reg, rt, val)
            run(pc, code, reg, data, out)

      {:sw, rt, imm, rs} ->
            pc = pc + 4
            val1 = Register.read(reg, rs)
            val2 = Register.read(reg, rt)
            address = val2 + imm
            data = Program.write(data, address, val1)
            run(pc, code, reg, data, out)

      {:beq, rs, rt, imm} ->
        val1 = Register.read(reg, rs)
        val2 = Register.read(reg, rt)
        if true == is_integer(imm) do
          if val1 == val2 do
         pc = pc + imm*4
         else
          pc = pc + 4
          end
        else
          if val1 == val2 do
            pc = Map.fetch(data, imm)
            else
            pc = pc + 4
            end
        end
        run(pc, code, reg, data, out)

      {:bne, rs, rt, imm} ->
        val1 = Register.read(reg, rs)
        val2 = Register.read(reg, rt)
        pc = if true == is_integer(imm) do
          if val1 != val2 do
          pc + imm*4
         else
          pc + 4
          end
        else
          if val1 != val2 do
            {:ok, newpc} = Map.fetch(data, imm)
            newpc
            else
            pc + 4
            end
        end
        run(pc, code, reg, data, out)

      {:label, _} ->
        pc = pc + 4
        run(pc, code, reg, data, out)
     end
  end
end



defmodule Program do

def read_instruction(code, pc) do
Enum.at(code, div(pc, 4)) #div = integer division
end

def new() do
  Map.new()
end

def read(data, i) do
  case Map.get(data, i) do
    nil -> 0
    val -> val
  end
end

def write(data, i, v) do
  Map.put(data, v, i)
end

def labels(code, data) do labels(code, data, 0) end
def labels(code, data, pc) do
  next = Program.read_instruction(code, pc)
  case next do
  {:label, label} ->
  data = Map.put(data, label, pc)
  labels(code, data, pc + 4)
  {:halt} ->
    {code, data}

    {:addi, rt, rs, imm} when is_atom(imm) ->
    code = List.replace_at(code, div(pc, 4), {:addi, rt, rs, Map.get(data, imm)})
    labels(code, data, pc + 4)

    {:lw, rt, imm, rs} when is_atom(imm) ->
    code = List.replace_at(code, div(pc, 4), {:lw, rt, Map.get(data, imm)}, rs)
    labels(code, data, pc + 4)

    {:sw, rt, imm, rs} when is_atom(imm) ->
    code = List.replace_at(code, div(pc, 4), {:sw, rt, Map.get(data, imm)}, rs)
    labels(code, data, pc + 4)

    _ ->
      labels(code, data, pc + 4)
  end

end


end




defmodule Register do

def new() do
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0}
end


def read(_, 0) do 0 end
def read(reg, r) do
elem(reg, r)
end

def write(reg, 0, _) do reg end
def write(reg, rd, value) do put_elem(reg, rd, value)
end

end

defmodule Out do

def new() do [] end

def put(out, s) do
[s | out]
end

def close(out) do
Enum.reverse(out)
end


end



defmodule Test do

  def test() do
  code =
    [{:addi, 1, 0, 10},    # $1 <- 10
     {:addi, 2, 0, :arg},     # $2 <- 5
     {:add, 3, 1, 2},      # $3 <- $1 + $2
     {:sw, 3, 0, 7},       # mem[0 + 7] <- $3
     {:lw, 4, 0, 7},       # $4 <- mem[0+7]
     {:label, :foo},
     {:addi, 5, 0, 1},     # $5 <- 1
     {:sub, 4, 4, 5},      # $4 <- $4 - $5
     {:out, 4},            # out $4
     {:bne, 4, 0, :foo},
     {:halt}]
  data = Program.new()
  data = Program.write(data, 5, :arg) #insert data
  {code, data} = Program.labels(code, data)
  Emulator.run(code, data)

end
end
