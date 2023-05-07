defmodule Tuples do

	def sum(tup) do
	Tuple.sum(tup)
	end
	
	def product(tup) do
	Tuple.product(tup)
	end
end

defmodule Prime do

	def check_prime(x) do
	if x <= 1 do
	true
	else
	loop(x, x-1)
	end
	
	end

	def loop(x, y) do
	
	if y == 1 do
	true
	else
		if rem(x, y) == 0 do
		false
		else
		loop(x, y-1)
		end
	end
	
	end
end

defmodule Sorted do

	def check(list) do
		if length(list) <= 1 do
			true
			else
			check(list, 0)
		end
	end
	
	def check(list, index) do
		if index + 1 > length(list) do
			true
			else
				if Enum.at(list, index) > Enum.at(list, index + 1) do
					false
				else
					check(list, index + 1)
			end
		end	
	end	
	
	
	
end