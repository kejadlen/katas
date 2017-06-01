module Lib
    ( Set
    , empty
    , isEmpty
    , add
    , length
    ) where

import Prelude hiding (length)

data Set = Set Int

empty :: Set
empty = Set 0

isEmpty :: Set -> Bool
isEmpty (Set n) = n == 0

add :: Int -> Set -> Set
add _ (Set n) = Set (n + 1)

length :: Set -> Int
length (Set n) = n
