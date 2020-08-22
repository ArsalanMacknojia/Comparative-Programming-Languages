-- Comparative Programming Languages - Exercise 5
-- Arsalan Macknojia

-----------------------------------------myIterate---------------------------------------

-- Function 'myIterate' behaves identically to Haskell built-in function iterate.

myIterate :: Ord a => (a -> a) -> a -> [a]
myIterate f x = f x : myIterate f (f x) 

-----------------------------------------myTakeWhile-------------------------------------

-- Function 'myTakeWhile' behaves identically to Haskell the built-in takeWhile.

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile f [] = []
myTakeWhile f (x:xs) 
    | f x = (x : myTakeWhile f xs)
    | otherwise = []

--------------------------------------------Pascal---------------------------------------

-- Function 'Pascal' returns the nth row of Pascal's triangle
-- e.g. pascal 3 => [1,3,3,1]

-- Helper Functions

add :: Num a => (a, a) -> a
add (a,b) = a + b

sumRow :: Num a => [a] -> [a]
sumRow prev = map add (zip prev (tail prev))

-- Pascal

pascal :: Integer -> [Integer]
pascal 0   = [1]
pascal 1   = [1,1]
pascal row = [1] ++ sumRow (pascal (row-1)) ++ [1]

----------------------------------addPair (Pointfree Addition)---------------------------

-- Function 'addPair' gives a pointfree definiton of a function
-- e.g. addPair (100, 3+4) => 107

addPair :: Num a => (a, a) -> a
addPair = uncurry (+)

-------------------------------withoutZeros (Pointfree Filtering)------------------------

-- Function 'withoutZeros' removes any zeros from a list of numbers
-- e.g. withoutZeros [1,2,0,3,4,0,5,6,0] => [1,2,3,4,5,6]

withoutZeros :: (Eq a,Num a) => [a] -> [a]
withoutZeros = filter (/=0) 

-----------------------------------------fibs--------------------------------------------

-- Function 'fibs' calculate fibonacci number.
-- e.g. fib 20 => 6765

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fibs = map fib [0..]

----------------------------------------things-------------------------------------------

things :: [Integer]
things = 0 : 1 : zipWith (+) things (tail things)
