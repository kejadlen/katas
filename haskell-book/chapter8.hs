import Data.List (intersperse)

-- applyTimes 5 (+1) 5
-- (+1) . applyTimes 4 (+1) $ 5
-- (+1) . (+1) applyTimes 3 (+1) $ 5
-- (+1) . (+1) . (+1) applyTimes 2 (+1) $ 5
-- (+1) . (+1) . (+1) . (+1) applyTimes 1 (+1) $ 5
-- (+1) . (+1) . (+1) . (+1) . (+1) applyTimes 0 (+1) $ 5
-- (+1) . (+1) . (+1) . (+1) . (+1) applyTimes 0 (+1) 5
-- (+1) . (+1) . (+1) . (+1) . (+1) 5
-- (+1) . (+1) . (+1) . (+1) . 6
-- (+1) . (+1) . (+1) 7
-- (+1) . (+1) 8
-- (+1) 9
-- 10

dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go num denom 0
  where go n d count
          | n < d = (count, n)
          | otherwise = go (n - d) d (count + 1)

cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow " ++ y

flippy = flip cattyConny
apedCatty = cattyConny "woops"
frappe = flippy "haha"

recursiveSum :: (Eq a, Num a) => a -> a
recursiveSum 1 = 1
recursiveSum n = n + recursiveSum (n - 1)

recursiveMult :: (Integral a) => a -> a -> a
recursiveMult n 1 = n
recursiveMult x y
  | y < 0 = -(recursiveMult x (-y))
  | otherwise = x + recursiveMult x (y - 1)

mc91 :: (Integral a) => a -> a
mc91 n
  | n > 100 = n - 10
  | otherwise = mc91 . mc91 $ n + 11

digitToWord :: Int -> String
digitToWord 0 = "zero"
digitToWord 1 = "one"
digitToWord 2 = "two"
digitToWord 3 = "three"
digitToWord 4 = "four"
digitToWord 5 = "five"
digitToWord 6 = "six"
digitToWord 7 = "seven"
digitToWord 8 = "eight"
digitToWord 9 = "nine"

digits :: Int -> [Int]
digits n
  | x == 0 = [y]
  | otherwise = digits x ++ [y]
  where (x, y) = n `divMod` 10

wordNumber :: Int -> String
-- wordNumber n = concat wordsWithDashes
--   where words = map digitToWord $ digits n
--         wordsWithDashes = intersperse "-" words
wordNumber = concat . (intersperse "-") . map digitToWord . digits
