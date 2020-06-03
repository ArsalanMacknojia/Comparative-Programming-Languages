-- Comparative Programming Languages - Exercise 3
-- Arsalan Macknojia

import Data.Time.Calendar
import Data.Time.Calendar.OrdinalDate

------------------------------------------------Merging----------------------------------------------

-- Function 'merge' take two already sorted lists and returns a single sorted list
-- e.g. merge [2,4,6,8] [1,3,5,7] => [1,2,3,4,5,6,7,8]

merge :: (Ord a) => [a] -> [a] -> [a]
merge []  ys  = ys
merge xs  []  = xs

merge (x:xs) (y:ys)
   | (x <= y) = x: merge (xs) (y:ys)
   | (x > y) = y: merge (x:xs) (ys)

-----------------------------------------Tail Recursive Hailstone-------------------------------------

-- Function 'hailstone' returns the next element in the hailstone sequence.
-- e.g. hailstone 14 => 7

hailstone :: Int -> Int
hailstone n
    | even n = n `div` 2
    | odd n = 3*n + 1

-- Function 'hailLen' returns the length of the hailstone sequence. (i.e. number of values in the sequence before it gets to one)
-- e.g. hailLen 11 => 14

hailLen n = hailTail 0 n
  where
    hailTail a 1 = a
    hailTail a n = hailTail (a+1) (hailstone n)

------------------------------------------------Factorial----------------------------------------------

-- Function 'fact' returns the factorial of the given argument
-- e.g. fact 5 => 120

fact :: Int -> Int
fact n 
   | (n == 0)   = 1
   | (n > 0)    = n* fact (n-1)

fact' :: Int -> Int 
fact' n = foldl(*) 1 [1..n]

--------------------------------------------Days In A Year-----------------------------------------------

-- Function 'daysInYear' returns a list of all the days in a given year
-- e.g. daysInYear 2020 = [2020-01-01,2020-01-02,2020-01-03,2020-01-04,…]

daysInYear :: Integer -> [Day]
daysInYear y  = [jan1..dec31]
  where jan1  = fromGregorian y 01 01
        dec31 = fromGregorian y 12 31

---------------------------------------------Is Friday---------------------------------------------------

-- Function 'isFriday' takes an argument of type Day and returns True if that day is a Friday(and False otherwise)
-- e.g. isFriday (fromGregorian 2018 5 18) => True

isFriday :: Day -> Bool
isFriday x
   | snd (mondayStartWeek(x)) == 5 = True
   | otherwise                     = False

---------------------------------------------Is Prime Day---------------------------------------------------

-- Function 'divisors' returns the divisors of a number (excluding 1 and the number itself)
-- e.g. divisors 30 -> [2,3,5,6,10,15]

divisors :: Int -> [Int]
divisors n = [i| i <- [2..(n `div` 2)], n `mod` i == 0]

-- Function 'isPrimeDay' takes a Day as an argument and returns True if day is prime.
-- e.g. isPrimeDay (fromGregorian 2018 5 13) => True

isPrimeDay :: Day -> Bool
isPrimeDay x
 | divisors d == []  = True
 | otherwise         = False
  where (_,_,d)      = toGregorian(x)

---------------------------------------------Prime Fridays---------------------------------------------------

-- Function 'primeFridays' retuns a list of all prime Fridays in a year
-- e.g. primeFridays 2018 => [2018-01-05,2018-01-19,2018-02-02,2018-02-23,2018-03-02,…]

primeFridays :: Integer -> [Day]
primeFridays x = [d | d <- d, isFriday d && isPrimeDay d]
       where d = daysInYear x


