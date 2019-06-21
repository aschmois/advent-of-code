-- stack --resolver lts-13.20 script
main = do
    content <- getContents -- We need to pull contents out of IO. getConents returns IO String, we want String
    let contentLines = lines content :: [String] -- creates lines of contents
    let convertedFunctions = map convert contentLines :: [Int -> Int] -- creates an array of functions that get an int and return an int
    let result = foldr (\ fn int -> fn int) 0 convertedFunctions -- reduce a function starting from 0 with an array of functions
    print result

convert :: String -> (Int -> Int)
convert line = case line of
    '+' : rest -> (\ x -> x + (read rest))
    '-' : rest -> (\ x -> x - (read rest))
    _ -> undefined