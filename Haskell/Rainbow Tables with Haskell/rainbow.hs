-- Comparative Programming Languages
-- Assignment 1
-- Arsalan Macknojia

-------------------------------------------------------------SOURCE CODE---------------------------------------------------------------

import RainbowAssign
import Data.Maybe as Maybe
import qualified Data.Map as Map

-------------------------------------------------------------PARAMETERS----------------------------------------------------------------

pwLength, nLetters, width, height :: Int
filename :: FilePath
pwLength = 8            -- length of each password
nLetters = 5            -- number of letters to use in passwords: 5 -> a-e
width = 40              -- length of each chain in the table
height = 1000           -- number of "rows" in the table
filename = "table.txt"  -- filename to store the table

-----------------------------------------------------------HASHING & REDUCING----------------------------------------------------------

-- Helper Functions

basenLetters :: Int -> [Int]
basenLetters hash = [hash `mod` nLetters] ++ basenLetters (hash `div` nLetters)

-- Function 'pwReduce' maps the given hash value to an arbitrary password.

pwReduce :: Hash -> Passwd
pwReduce passwordHash = reverse (map toLetter (take pwLength (basenLetters (fromEnum passwordHash ))))

-----------------------------------------------------------BUILDING THE TABLE----------------------------------------------------------

-- Helper Functions

generateHash :: [Passwd] -> [Hash]
generateHash passwords = map pwHash passwords

hashMap :: Int -> [Passwd] -> [Hash]
hashMap 0 passwordList = generateHash passwordList
hashMap n passwordList = hashMap (n-1) (map pwReduce (generateHash passwordList))

-- Function 'rainbowTable' generates a rainbow table, given a list of initial passwords.

rainbowTable :: Int -> [Passwd] -> Map.Map Hash Passwd
rainbowTable tableWidth passwordList = Map.fromList (zip (hashMap tableWidth passwordList) passwordList)

-----------------------------------------------------REVERSING HASHES (findPassword)---------------------------------------------------

-- Helper Functions

reduceHash :: Hash -> Hash
reduceHash hash = pwHash (pwReduce hash)

hashReduce :: Passwd -> Passwd
hashReduce password = pwReduce (pwHash password)

searchTable :: Map.Map Hash Passwd-> Int -> Hash -> Maybe Passwd
searchTable _ (-1) _ = Nothing
searchTable pwHashTable tableWidth hashValue
  | Map.lookup hashValue pwHashTable == Nothing = searchTable pwHashTable (tableWidth-1) (reduceHash hashValue)
  | otherwise = Map.lookup hashValue pwHashTable

verifyPassword :: Passwd -> Int -> Hash -> Maybe Passwd
verifyPassword _ (-1) _ = Nothing
verifyPassword password tableWidth hashValue
  | (pwHash password) == hashValue = Just password
  | otherwise = verifyPassword (hashReduce password) (tableWidth-1) hashValue

crackPassword :: Maybe Passwd -> Int -> Hash -> Maybe Passwd
crackPassword Nothing _ _ = Nothing
crackPassword (Just password) tableWidth hashValue = verifyPassword password tableWidth hashValue

-- Function 'findPassword' reverses a hash to the corresponding password, if possible.

findPassword :: Map.Map Hash Passwd-> Int -> Hash -> Maybe Passwd 
findPassword pwHashTable tableWidth hashValue = crackPassword (searchTable pwHashTable tableWidth hashValue) tableWidth hashValue

---------------------------------------------------CREATING, READING, & WRITING TABLES-------------------------------------------------

generateTable :: IO ()
generateTable = do
  table <- buildTable rainbowTable nLetters pwLength width height
  writeTable table filename

test1 :: IO (Maybe Passwd)
test1 = do
  table <- readTable filename
  return (Map.lookup 0 table)

test2 :: Int -> IO ([Passwd], Int)
test2 n = do
  table <- readTable filename
  pws <- randomPasswords nLetters pwLength n
  let hs = map pwHash pws
  let result = Maybe.mapMaybe (findPassword table width) hs
  return (result, length result)

------------------------------------------------------------------MAIN-----------------------------------------------------------------

main :: IO ()
main = do
  generateTable
  res <- test2 10000
  print res

------------------------------------------------------------RUN INSTRUCTIONS-----------------------------------------------------------

-- ghc -O2 --make -Wall rainbow.hs
-- ./rainbow