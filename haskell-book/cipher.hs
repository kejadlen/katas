module Cipher where

import Data.Char

cipher :: Int -> String -> String
cipher _ "" = ""
cipher n (c:cs) = (cipher' n c) : (cipher n cs)

decipher :: Int -> String -> String
decipher n = cipher (-n)

cipher' :: Int -> Char -> Char
cipher' n c
  | isUpper c = chr (((ord c) - (ord 'A') + n) `mod` 26 + (ord 'A'))
  | isLower c = chr (((ord c) - (ord 'a') + n) `mod` 26 + (ord 'a'))
  | otherwise = c
