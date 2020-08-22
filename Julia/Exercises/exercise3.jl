# Comparative Programming Languages
# Arsalan Macknojia

#-------------------------------------FIBS--------------------------------------

# Function 'fib' calculate fibonacci number.
# e.g. fib 20 => 6765

fib_seq=Dict()

function fib(x::Int64)
    global fib_seq

    if x<=1  return x end
    if haskey(fib_seq,x) return fib_seq[x] end

    return fib_seq[x] = fib(x-2) + fib(x-1)
end


#-------------------------------------Main--------------------------------------

function main()
	print("Implementation of fib function from Exercise 5 in Julia! \n\n")

	print("Running function fib \n")
	print("Input value: 20 \n")
	print("Output value: ", fib(20), "\n\n")
end


main()
