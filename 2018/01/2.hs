-- stack --resolver lts-13.20 script

import qualified Data.Set as Set

main = do
    content <- getContents -- We need to pull contents out of IO. getConents returns IO String, we want String
    let contentLines = lines content :: [String] -- creates lines of contents
    print $ findMatchingSet Set.empty contentLines
    
findMatchingSet :: Set.Set Int -> [String] -> IO Int
findMatchingSet set contentLines = do
    frequency <- getFrequency contentLines
    if Set.lookup set frequency

getFrequency :: [String] -> IO Int
getFrequency contentLines = do
    let convertedFunctions = map convert contentLines :: [Int -> Int] -- creates an array of functions that get an int and return an int
    pure $ foldr (\ fn int -> fn int) 0 convertedFunctions

convert :: String -> (Int -> Int)
convert line = case line of
    '+' : rest -> (\ x -> x + (read rest))
    '-' : rest -> (\ x -> x - (read rest))
    _ -> undefined