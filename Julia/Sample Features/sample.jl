# Comparative Programming Languages
# Arsalan Macknojia

#=------------------Sample 1 - Numerical Computing & Macros---------------------
Julia excels at numerical computing and support special characters such as maths
symbols to derive complex mathematical equations seamlessly.

Julia also allow creating Macros in a very intuitive manner.
Macros are “shortcuts” that can be used to quickly and effectively access functions.
In Julia, you can define a macro by simply using “macro” keyword.
=#

macro quadraticFormula(a, b, c)
    discriminant = (b^2 - 4a*c)
	if discriminant < 0 return("Discriminant has no real roots") end
    α = (-b - discriminant) ÷ 2a
    β = (-b + discriminant) ÷ 2a
    return α, β
end

function test_quadraticFormula()
	println("---------------------------------------")
	println("Running quadraticFormula...")
	println("Input Values: a=4, b=10, c=6")
	println("Output: $(@quadraticFormula 4 10 6)")
end


#=------------------------Sample 2 - Parallel Computing-------------------------
Julia does parallelism really well as it was designed with speed in mind.
It provides built-in primitives for parallel computing.
=#

using Distributed

@everywhere function serial_fib(x)
    if x<=1 return x end
    return serial_fib(x-1) + serial_fib(x-2)
end

@everywhere function parallel_fib(x)
    # Creating a new thread has a non-trivial overhead of around 1µs.
    # Therefore, we are only spawning threads for calculations which takes significantly more than spawning the threads. (Fib >= 45)
    if (x<45) return serial_fib(x) end

    thread_1 = Threads.@spawn parallel_fib(x-1)
    thread_2 = Threads.@spawn parallel_fib(x-2)

    return fetch(thread_1) + fetch(thread_2)
end

function test_parallelism(num=45)
	if Threads.nthreads() == 1
		print("""There is only 1 thread available to Julia.
		Please allocate more threads by setting ENV JULIA_NUM_THREADS=3 to test parallelism.""")
		return
	end

	if num < 45
		print("""Please pass a number greater than 45.
		To benchmark parallelism, calculations must be significant enough to outweight the overhead of creating new threads.""")
		return
	end

	println("---------------------------------------")
    println("Running serial_fib...")
	println("Input value: $num")
	println("Run time of serial_fib function: ")
	@time serial_fib(num)

	println("---------------------------------------")
	println("Running parallel_fib...")
	println("Input value: $num ")
    println("Run time of parallel_fib function: ")
	@time parallel_fib(num)
end


#=------------------------------Sample 3 - Dispatch-----------------------------

Julia offers high-performance dispatch. Using a syntactical expression, users can
create different functions that handle different types with the same methods using parametric polymorphism.
=#

function _int(x, y)
	println("Doing integer multiplication")
	println("Input Value: x=$x, y=$y")
	println("Output: $(x*y)")
end

function _float(x, y)
	println("Doing float multiplication")
	println("Input Value: x=$x, y=$y")
	println("Output: $(x*y)")
end

multiply_func(x::Int64, y::Int64) = _int(x, y)
multiply_func(x::Float64, y::Float64) = _float(x, y)

function test_dispatch(x=10, y=10)
	println("---------------------------------------")
	multiply_func(x, y)

	println("---------------------------------------")
	multiply_func(float(x), float(y))
end


#=----------------------=--Sample 4 - Task/Coroutines---------------------------
In Julia Tasks is an alias for coroutines (Green Threading) which allows computations to be suspended and resumed in a flexible manner.
=#

function fib_producer(c::Channel)
	a = 0
	put!(c, a)
	b = 1
	put!(c, b)
	while true
		a, b = b, a+b
		put!(c, b)
	end
end

function fib_consumer(fib_num)
	chnl = Channel(fib_producer);
	for i = 0:fib_num
    	println(take!(chnl))
    end
end

function test_fib_consumer(fib_num=5)
	println("---------------------------------------")
	println("Running fib_consumer...")
	fib_consumer(fib_num)
end


#-------------------------------------Main--------------------------------------

function main()
	print("Implementation of sample functions highlighting prominent features in Julia! \n\n")
	test_quadraticFormula()
	test_parallelism()
	test_dispatch()
	test_fib_consumer()
end

main()
