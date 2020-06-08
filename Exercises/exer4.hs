-- Comparative Programming Languages - Exercise 4
-- Arsalan Macknojia

-----------------------------------------Hailstone Sequence-------------------------------------

-- Function 'hailstone' returns the next element in the hailstone sequence.
-- e.g. hailstone 14 => 7

hailstone :: Int -> Int
hailstone n
   | even n    = n `div` 2
   | otherwise = 3 * n + 1

-- Function 'hailSeq' returns a hailstone sequence starting wih the given argument and ending with one. (Recursive Function)
-- e.g. hailSeq 11 => [11,34,17,52,26,13,40,20,10,5,16,8,4,2,1]

hailSeq :: Int -> [Int]
hailSeq n 
   | n == 0    = []
   | n == 1    = [1]
   | otherwise = [n] ++ hailSeq (hailstone n)


-- Function hailSeq' returns a hailstone sequence starting wih the given argument and ending with one. (Iterative Function)
-- e.g. hailSeq 11 => [11,34,17,52,26,13,40,20,10,5,16,8,4,2,1]

hailSeq' :: Int -> [Int]
hailSeq' n 
   | n == 0    = []
   | otherwise = takeWhile (/=1) (iterate hailstone n) ++ [1]


-----------------------------------------Join Strings-------------------------------------------

-- Function 'join' concatenate the give list with a string (the seprator) in between each element. (Iterative Function)
-- e.g. join "+" ["1","2","3"] => "1+2+3"

join :: String -> [String] -> [Char]
join c s = foldr (\x y-> x ++ if y == "" then y else c ++ y) "" s


--------------------------------------------Merge Sort------------------------------------------

-- Function 'merge' take two already sorted lists and returns a single sorted list
-- e.g. merge [2,4,6,8] [1,3,5,7] => [1,2,3,4,5,6,7,8]

merge :: (Ord a) => [a] -> [a] -> [a]
merge []  ys  = ys
merge xs  []  = xs
merge (x:xs) (y:ys)
   | (x <= y) = x : merge (xs) (y:ys)
   | (x > y)  = y : merge (x:xs) (ys)

-- Function 'merge sort' takes an unsorted list as an argument and returns a sorted list.
-- e.g. mergeSort [1,9,3,2,7,6,4,8,5] => [1,2,3,4,5,6,7,8,9]

mergeSort :: Ord a => [a] -> [a]
mergeSort []   = []
mergeSort [x]  = [x]
mergeSort list = merge (mergeSort first) (mergeSort second)
   where
      first    = take (length list `div` 2) list
      second   = drop (length list `div` 2) list


--------------------------------------------Search Maybe----------------------------------------

-- Function 'findElt' takes two arguments; an element and a list. 
-- Function returns the index of the given element in the list if it exist otherwise nothing.
-- e.g. findElt 8 [4,5,2,8,7,3,1] => Just 3
-- e.g. findElt 6 [4,5,2,8,7,3,1] => Nothing

findElt :: (Ord a) => a -> [a] -> Maybe Integer
findElt element list = search 0 list
   where
      search i []           = Nothing 
      search i (x:list)
           | element == x   = Just i
           | otherwise      = search (i + 1) list

