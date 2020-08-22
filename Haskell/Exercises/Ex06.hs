-- Comparative Programming Languages - Exercise 6
-- Arsalan Macknojia

import Data.Ratio

-----------------------------------------rationalSum---------------------------------------

-- Function 'rationalSum' returns a list of all rational numbers whose numerator and denominator add to the given argument.
-- e.g. rationalSum 8 => [1 % 7,1 % 3,3 % 5,1 % 1,5 % 3,3 % 1,7 % 1]

rationalSum :: Integer -> [Rational]
rationalSum num = [x % y | x <- [1..(num-1)], y <- [1..(num-1)], x==num-y]

---------------------------------------rationalSumLowest------------------------------------

-- Function 'rationalSum' returns a list of all rational numbers whose numerator and denominator add to the given argument and the values are are already in lowest-terms.
-- e.g. rationalSumLowest 8 => [1 % 7,3 % 5,5 % 3,7 % 1]

rationalSumLowest :: Integer -> [Rational]
rationalSumLowest num = [x % y | x <- [1..(num-1)], y <- [1..(num-1)], x==num-y, gcd x y == 1]

--------------------------------------------rationals---------------------------------------

-- Function 'rationals' constructs a list that contains all positive rational numbers exactly once.
-- e.g. take 10 rationals => [1 % 1,1 % 2,2 % 1,1 % 3,3 % 1,1 % 4,2 % 3,3 % 2,4 % 1,1 % 5]
-- e.g. elem (8%7) rationals => True

rationals :: [Rational]
rationals = concat (map rationalSumLowest [0..])

----------------------------------------------sumFile---------------------------------------

-- Function 'sumFile' reads a file input.txt which contain intergers (one per line), add up the numbers and print the result.

sumFile :: IO ()
sumFile = do
    lines <- readFile "input.txt"
    let numbers = map (read::String->Int) (words lines)    
    print (sum numbers)