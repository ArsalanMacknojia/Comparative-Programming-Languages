-- Comparative Programming Languages - Exercise 2
-- Arsalan Macknojia

-----------------------------------------Hailstone Length------------------------------------------------------

-- Function 'hailstone' returns the next element in the hailstone sequence.
-- e.g. hailstone 14 => 7

hailstone :: Int -> Int
hailstone n
    | even n = n `div` 2
    | odd n = (3*n) + 1

-- Function 'hailLen' returns the length of the hailstone sequence. (i.e. number of values in the sequence before it gets to one)
-- e.g. hailLen 11 => 14

hailLen 1 = 0
hailLen n = 1 + hailLen (hailstone n)

-----------------------------------------Primes & Divisors------------------------------------------------------

-- Function 'divisors' returns the divisors of a number (excluding 1 and the number itself)
-- e.g. divisors 30 -> [2,3,5,6,10,15]

divisors :: Int -> [Int]
divisors n = [i| i <- [2..(n `div` 2)], n `mod` i == 0]

-- Function 'prime' calculates the list of prime numbers up to the argument.
-- e.g. primes 7 => [2,3,5,7]

primes :: Int -> [Int]
primes n = [i | i <- [2..n], divisors i == []]

-----------------------------------------Join Strings------------------------------------------------------------

-- Function 'join' calculates the give list with a string (the seprator) in between each element.
-- e.g. join "+" ["1","2","3"] => "1+2+3"

join :: String -> [String] -> [Char]
join _ [] = ""
join _ [a]= a
join a (x:xs) = (++) x a ++ join a xs

-----------------------------------------Pythagorean Triples------------------------------------------------------

-- Function 'pythagorean' takes one arguments (max. value for c) and returns Pythagorean triples (values a,b,c all integers greater than 0, where a^2 + b^2 = c^2).
-- e.g. pythagorean 10 => [(3,4,5),(6,8,10)]

pythagorean :: Int -> [(Int, Int, Int)]
pythagorean c = [(a, b, i) | i <- [1..c], a <- [1..c], b <- [1..a], a^2+b^2==i^2]
