{-# OPTIONS_GHC -F -pgmF htfpp #-}

import Prelude hiding (length)
import Test.Framework
import Lib

test_isEmpty = do assertEqual True (isEmpty empty)
                  assertEqual False (isEmpty (add 1 empty))

test_length = do assertEqual 0 (length empty)
                 assertEqual 1 (length (add 1 empty))
                 assertEqual 2 (length (add 2 (add 1 empty)))

test_contains = do assertEqual False (contains 0 empty)
                   assertEqual False (contains 0 (add 1 empty))
                   assertEqual True (contains 1 (add 1 empty))

test_uniqueness = do assertEqual 1 (length (add 1 (add 1 empty)))

main = htfMain htf_thisModulesTests
