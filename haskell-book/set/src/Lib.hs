{-# LANGUAGE GADTs #-}

module Lib
    ( Set
    , empty
    , isEmpty
    , add
    , length
    , contains
    , remove
    , setFromList
    ) where

import Prelude hiding (length)

data Set a where
  Empty :: (Eq a) => Set a
  Cons :: (Eq a) => a -> Set a -> Set a

empty :: (Eq a) => Set a
empty = Empty

isEmpty :: Set a -> Bool
isEmpty Empty = True
isEmpty _ = False

add :: a -> Set a -> Set a
add x Empty = Cons x Empty
add e (Cons x xs)
  | e == x    = Cons x xs
  | otherwise = Cons x (add e xs)

length :: Set a -> Int
length Empty = 0
length (Cons _ s) = 1 + (length s)

contains :: a -> Set a -> Bool
contains _ Empty = False
contains e (Cons x xs)
  | e == x    = True
  | otherwise = contains e xs

remove :: a -> Set a -> Set a
remove _ Empty = Empty
remove e (Cons x xs)
  | e == x    = xs
  | otherwise = Cons x (remove e xs)

setFromList :: (Eq a) => [a] -> Set a
setFromList [] = Empty
setFromList (x:xs) = add x (setFromList xs)
