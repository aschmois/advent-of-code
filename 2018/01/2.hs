-- stack --resolver lts-13.20 script

-- run it like `stack 2.hs < input.txt`

import qualified Data.Set as Set

main = do
    content <- getContents -- We need to pull contents out of IO. getConents returns IO String, we want String
    let contentLines = lines content :: [String] -- creates lines of contents
        matching = findMatchingSet Set.empty contentLines contentLines 0
    print matching

findMatchingSet :: Set.Set Int -> [String] -> [String] -> Int -> Int
findMatchingSet set orig contentLines value = do
    case contentLines of
        [] -> findMatchingSet set orig orig value
        contentLine : newContentLines -> do
            let val = convert' contentLine value
            if Set.member val set  
            then
                val
            else do
                let newSet = Set.insert val set
                findMatchingSet newSet orig newContentLines val

convert' :: String -> Int -> Int
convert' line value = case line of
    '+' : rest -> value + (read rest)
    '-' : rest -> value - (read rest)
    _ -> undefined