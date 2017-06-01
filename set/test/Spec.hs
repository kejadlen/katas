{-# OPTIONS_GHC -F -pgmF htfpp #-}

import Test.Framework
import Lib

test_isEmpty = do assertEqual True (isEmpty empty)

main = htfMain htf_thisModulesTests
