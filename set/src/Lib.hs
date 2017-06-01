module Lib
    ( Set
    , empty
    , isEmpty
    , add
    ) where

data Set = Set Bool

empty :: Set
empty = Set True

isEmpty :: Set -> Bool
isEmpty (Set s) = s

add :: Int -> Set -> Set
add _ _ = Set False
