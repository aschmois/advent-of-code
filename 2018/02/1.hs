-- stack --resolver lts-13.20 script

-- run it like : `stack 2.hs`
-- for ghcid : stack --resolver lts-13.20 exec --package ghcid -- ghcid 1.hs --test :main

import qualified Data.Map as Map
import qualified Data.Set as Set

main :: IO ()
main = do
  content <- readFile "input.txt"
  print 
    . f3
    . f2 
    . map f1 
    . lines 
    $ content

f3 :: (Int, Int) -> Int
f3 (e1, e2) = e1 * e2

f2 :: [(Int, Int)] -> (Int, Int)
f2 = foldr (\ (e1, e2) (a1, a2) -> (a1 + e1, a2 + e2)) (0,0)

f1 :: String -> (Int, Int)
f1 cLine = do
    let csMap = f1a cLine
        cs = Map.elems csMap
        xs = Set.fromList cs
    (fromEnum $ Set.member 2 xs, fromEnum $ Set.member 3 xs)

f1a :: [Char] -> Map.Map Char Int
f1a = foldr (\ char -> Map.insertWith (+) char 1) Map.empty 