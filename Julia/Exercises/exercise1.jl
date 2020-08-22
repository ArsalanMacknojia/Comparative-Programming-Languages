# Comparative Programming Languages
# Arsalan Macknojia


#-------------------------------Primes & Divisors-------------------------------

# Function 'divisors' returns the divisors of a number (excluding 1 and the number itself)
# e.g. divisors 30 -> [2,3,5,6,10,15]

function divisors(num)
    last_divisor = round(num/2)
    result = Int[]

    for i = 2:last_divisor
        if(num % i == 0)
           push!(result, i)
        end
    end

    return result
end

# Function 'prime' calculates the list of prime numbers up to the argument.
# e.g. primes 7 => [2,3,5,7]

function primes(num)
    result = Int[]

    for i = 2:num
        if(divisors(i) == [])
            push!(result, i)
        end
    end

    return result
end

#---------------------------------Join Strings----------------------------------

# Function 'join' concatenates the given list with a string (the seprator) in between each element.
# e.g. join "+" ["1","2","3"] => "1+2+3"

function join(seprator, list)
	len = length(list)

	if len == 0
		return ""
	elseif len == 1
		return list[1]
	else
		concatnated = list[1] * seprator
		return concatnated * join(seprator, list[2:len])
	end
end

#---------------------------------Pythagorean-----------------------------------

# Function 'pythagorean' takes one arguments (max. value for c) and returns Pythagorean triples (values a,b,c all integers greater than 0, where a^2 + b^2 = c^2).
# e.g. pythagorean 10 => ([3,4,5],[6,8,10])

function pythagorian(max_c)
	result = []

    for c = 1:max_c, a = 1:c, b = 1:a
        left_side = a^2 + b^2
        right_side = c^2
        if left_side == right_side
            triples = [a b c]
			push!(result, triples)
        end
    end

    return result
end

#-------------------------------------Main--------------------------------------

function main()
	print("Implementation of functions from Exercise 2 in Julia! \n\n")

	print("Running function divisors \n")
	print("Input value: 30 \n")
	print("Output value: ", divisors(30), "\n\n")

	print("Running function primes \n")
	print("Input value: 7 \n")
	print("Output value: ", primes(7), "\n\n")

	print("Running function join \n")
	print("Input value: '+',  ['1','2','3'] \n")
	print("Output value: ", join('+',  ['1','2','3']), "\n\n")

	print("Running function pythagorian \n")
	print("Input values: 10 \n")
	print("Output values: ", pythagorian(10), "\n\n")
end


main()
