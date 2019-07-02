-- stack --resolver lts-13.20 script

-- run it like : `stack 2.hs`
-- for ghcid : stack --resolver lts-13.20 exec --package ghcid -- ghcid 2.hs --test :main

import qualified Data.List as List

main :: IO ()
main = do
  content <- readFile "input.txt"
  print 
    . foo
    . lines 
    $ content

foo :: [String] -> String
foo cLines = case cLines of
    [] -> undefined
    line : [] -> undefined
    line : rest -> case doesMatch line rest of
        Nothing -> foo rest
        Just result -> result 

doesMatch :: String -> [String] -> Maybe String
doesMatch line strings = case strings of
    [] -> Nothing
    potentialMatch : rest -> case traverseMatch potentialMatch rest of
        Nothing -> doesMatch line rest
        Just result -> Just result

traverseMatch :: String -> [String] -> Maybe String
traverseMatch l1 lineList = case lineList of
  [] -> Nothing
  l2 : rest -> case compare' l1 l2 of
    Nothing -> traverseMatch l1 rest
    Just result -> Just result

compare' :: String -> String -> Maybe String
compare' l1 l2 = case foldr (\ (x, y) (count, acc) -> 
                                    if x == y then (count, y : acc) else (count + 1, acc)
                                ) (0, "") (zip l1 l2) of
  (1, rest) -> Just rest
  _ -> Nothing