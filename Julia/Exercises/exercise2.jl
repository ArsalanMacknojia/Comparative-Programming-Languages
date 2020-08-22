# Comparative Programming Languages
# Arsalan Macknojia

#-----------------------------------Hailstone-----------------------------------

# Function 'hailstone' returns the next element in the hailstone sequence.
# e.g. hailstone 14 => 7

function hailstone(n)
    if (n % 2) == 0 return Int64(n/2) end
    return Int64(3*n + 1)
end

#-------------------------------Hailstone Sequence------------------------------

# Function 'hailSeq' returns a hailstone sequence starting wih the given argument and ending with one. (Recursive Function)
# e.g. hailSeq 11 => [11,34,17,52,26,13,40,20,10,5,16,8,4,2,1]

function hailSeq(n)
    if n == 0
        return []
    elseif n == 1
        return [1]
    else
        return vcat([n], hailSeq(hailstone(n)))
    end
end

#-----------------------------------Merge Sort----------------------------------

# Function 'mergeFun' take two already sorted lists and returns a single sorted list
# e.g. merge [2,4,6,8] [1,3,5,7] => [1,2,3,4,5,6,7,8]

function mergeFunc(left::Vector, right::Vector)
  size = length(left) + length(right)
  sorted = Array{Int64,1}(undef, size)

  for i = 1:size
    if first(left) <= first(right)
      sorted[i] = popfirst!(left)
    else
      sorted[i] = popfirst!(right)
    end

    if isempty(left)
      for i = (i+1):(i+length(right))
        sorted[i] = popfirst!(right)
      end
      return sorted
    end

    if isempty(right)
      for i = (i+1):(i+length(left))
        sorted[i] = popfirst!(left)
      end
      return sorted
    end
  end
end

# Function 'mergeSort' takes an unsorted list as an argument and returns a sorted list.
# e.g. mergeSort [1,9,3,2,7,6,4,8,5] => [1,2,3,4,5,6,7,8,9]

function mergeSort(unsorted::Vector)
  len = length(unsorted)
  if len <= 1 return unsorted end

  mid = len÷2
  left = unsorted[1:mid]
  right = unsorted[mid+1:end]

  return mergeFunc(mergeSort(left), mergeSort(right))
end


#-------------------------------------Main--------------------------------------

function main()
	print("Implementation of functions from Exercise 4 in Julia! \n\n")

	print("Running function hailstone \n")
	print("Input value: 14 \n")
	print("Output value: ", hailstone(14), "\n\n")

	print("Running function hailSeq \n")
	print("Input value: 11 \n")
	print("Output value: ", hailSeq(11), "\n\n")

	print("Running function mergeSort \n")
	print("Input value: [] \n")
	print("Output value: ", mergeSort([]), "\n\n")

	print("Running function mergeSort \n")
	print("Input value: [10] \n")
	print("Output value: ", mergeSort([10]), "\n\n")

	print("Running function mergeSort \n")
	print("Input value: [10, 2, 6, 1, 15, 7, 8] \n")
	print("Output value: ", mergeSort([10, 2, 6, 1, 15, 7, 8]), "\n\n")
end


main()
