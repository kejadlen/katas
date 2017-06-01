module Lib
    ( Set
    , empty
    , isEmpty
    , add
    , length
    , contains
    ) where

import Prelude hiding (length)

data Set = Empty | Cons Int Set

empty :: Set
empty = Empty

isEmpty :: Set -> Bool
isEmpty Empty = True
isEmpty _ = False

add :: Int -> Set -> Set
add x Empty = Cons x Empty
add e (Cons x xs)
  | e == x    = Cons x xs
  | otherwise = Cons x (add e xs)

length :: Set -> Int
length Empty = 0
length (Cons _ s) = 1 + (length s)

contains :: Int -> Set -> Bool
contains _ Empty = False
contains e (Cons x s)
  | e == x    = True
  | otherwise = contains e s
