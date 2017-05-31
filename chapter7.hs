addOneIfOdd n = case odd n of
  True -> f n
  False -> n
  where f = \n -> n + 1

addFive = \x -> \y -> (if x > y then y else x) + 5

mFlip f x y = f y x

k (x, y) = x
k1 = k ((4-1), 10)
k2 = k ("three", (1+2))
k3 = k (3, True)

f (a, b, c) (d, e, f) = ((a, d), (c, f))

functionC x y =
  case x > y of
    True -> x
    False -> y

ifEvenAdd2 n =
  case even n of
    True -> n + 2
    False -> n

nums x =
  case compare x 0 of
    LT -> -1
    GT -> 1
    EQ -> 0

dodgy x y = x + y * 10
oneIsOne = dodgy 1
oneIsTwo = (flip dodgy) 2

avgGrade :: (Fractional a, Ord a) => a -> Char
avgGrade x
  | y >= 0.9  = 'A'
  | y >= 0.8  = 'B'
  | y >= 0.7  = 'C'
  | y >= 0.59 = 'D'
  | otherwise = 'F'
  where y = x / 100

numbers x
  | x < 0 = -1
  | x == 0 = 0
  | x > 0 = 1

tensDigit :: Integral a => a -> a
tensDigit x = d
  where (xLast, _) = x `divMod` 10
        (_, d)     = xLast `divMod` 10

hunsD x = tensDigit $ x `div` 10

foldBoolCase :: a -> a -> Bool -> a
foldBoolCase x y b = case (x, y, b) of
  (x, _, True) -> x
  (_, y, False) -> y

foldBoolGuard :: a -> a -> Bool -> a
foldBoolGuard x y b
  | b == True = x
  | b == False = y

g :: (a -> b) -> (a, c) -> (b, c)
g f (a, c) = (f a, c)

-- roundTrip :: (Show a, Read a) => a -> a
roundTrip :: (Show a, Read b) => a -> b
roundTrip = read . show
