-- Comparative Programming Languages - Exercise 1
-- Arsalan Macknojia

-- Function 'det' calculates the discriminant.
det a b c = b^2 - 4*a*c

-- Function 'quadsol1' and 'quadsol2' calculates two solutions to a quadratic formula.
quadsol1 a b c = (-b - sqrt (det a b c))/2*a
quadsol2 a b c = (-b + sqrt (det a b c))/2*a


-- Function 'third_a' returns the third element of the list using built-in index operator.
-- It throws an exception if list has less than 3 characters.
third_a list = list !! 2

-- Function 'third_b' returns the third element of the list using pattern matching.
-- It throws an exception if list has less than 3 characters.
third_b (_:_:x:_) = x


-- Function 'hailstion' returns the next element in the hailstone sequence (https://plus.maths.org/content/mathematical-mysteries-hailstone-sequences)
hailstone n
    | even n = n `div` 2
    | odd n = (3*n) + 1
