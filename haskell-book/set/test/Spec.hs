{-# OPTIONS_GHC -F -pgmF htfpp #-}

import Prelude hiding (length)
import Test.Framework
import Lib

zero     = empty
one      = add 1 empty
many     = add 1 (add 2 (add 3 empty))
removed  = remove 2 many
fromList = setFromList [1, 2, 1]

test_isEmpty = do
  assertEqual True (isEmpty zero)
  assertEqual False (isEmpty one)

test_length = do
  assertEqual 0 (length zero)
  assertEqual 1 (length one)
  assertEqual 3 (length many)

test_contains = do
  assertEqual False (contains 0 zero)
  assertEqual False (contains 0 one)
  assertEqual True (contains 1 one)

test_uniqueness = do
  assertEqual 1 (length (add 1 one))

test_remove = do
  assertEqual 2 (length removed)
  assertEqual False (contains 2 removed)

test_from_list = do
  assertEqual 2 (length fromList)
  assertEqual True (contains 1 fromList)
  assertEqual True (contains 2 fromList)

test_gadt = do
  assertEqual 1 (length (add "omg" empty))

main = htfMain htf_thisModulesTests
