{-# OPTIONS_GHC -F -pgmF htfpp #-}

import Test.Framework
import Lib

test_isEmpty = do assertEqual True (isEmpty empty)
                  assertEqual False (isEmpty (add 1 empty))

main = htfMain htf_thisModulesTests
