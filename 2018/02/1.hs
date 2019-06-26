-- stack --resolver lts-13.20 script

-- run it like : `stack 2.hs`
-- for ghcid : stack --resolver lts-13.20 exec --package ghcid -- ghcid 1.hs --test :main

import qualified Data.Map as Map

main :: IO ()
main = do
  content <- readFile "input.txt"
  print 
    . f2 
    . map f1 
    . lines 
    $ content

f2 :: [(Int, Int)] -> Int
f2 = foldr (\ (e1, e2) a -> a + e1 * e2 ) 0

f1 :: String -> (Int, Int)
f1 cLine = do
    let csMap = f1a cLine
        cs = Map.elems csMap
    (boolToInt $ elem 2 cs, boolToInt $ elem 3 cs)

boolToInt :: Bool -> Int
boolToInt a = case a of
    True -> 1
    False -> 0

f1a :: [Char] -> Map.Map Char Int
f1a cs = undefined