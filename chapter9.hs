eftBool :: Bool -> Bool -> [Bool]
eftBool False False = [False]
eftBool False True = [False, True]
eftBool True False = []
eftBool True True = [True]

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd from to
  | from == to = [from]
  | from > to || from == GT = []
  | otherwise = from : eftOrd (succ from) to

eftInt :: Int -> Int -> [Int]
eftInt from to
  | from == to = [from]
  | from > to || from == (maxBound :: Int) = []
  | otherwise = from : eftInt (succ from) to

myWords :: String -> [String]
myWords "" = []
-- myWords s = firstWord s : (myWords (restWords s))
myWords s = firstSplit ' ' s : (myWords (restSplit ' ' s))

-- firstWord :: String -> String
-- firstWord = takeWhile (/=' ')

-- restWords :: String -> String
-- restWords s = dropWhile (==' ') (dropWhile (/=' ') s)

myLines :: String -> [String]
myLines "" = []
myLines s = firstSplit '\n' s : (myLines (restSplit '\n' s))

firstSplit :: Char -> String -> String
firstSplit c = takeWhile (/=c)

restSplit :: Char -> String -> String
restSplit c s = dropWhile (==c) (dropWhile (/=c) s)

-- 9.7 Exercises: Square Cube

mySqr = [x^2 | x <- [1..5]]
myCube = [y^3 | y <- [1..5]]

-- [(x,y) | x <- mySqr, y <- myCube]
-- [(x,y) | x <- mySqr, y <- myCube, x < 50, y < 50]
-- length [(x,y) | x <- mySqr, y <- myCube, x < 50, y < 50]
