-- stack --resolver lts-13.20 script

-- run it like : `stack 1.hs`
-- for ghcid : stack --resolver lts-13.20 exec --package ghcid -- ghcid 1.hs --test :main

main :: IO ()
main = do
  content <- readFile "input.txt"
  print 
    . createMatrix
    . map getClaim
    . lines 
    $ content

getClaim :: String -> (Int, (Int, Int), (Int, Int))
getClaim cLine = do
  let [id, x,y,w,h] = fmap read . words . fmap (\c -> if '0' <= c && c <= '9' then x else ' ') cLine
  (id (x,y), (w,h))

-- Matrix with [Int] inside listing all the claims
createMatrix :: [(Int, (Int, Int), (Int, Int))] -> [[[Int]]]
createMatrix claims = undefined

getBounds :: [(Int, (Int, Int), (Int, Int))] -> (Int, Int)
getBounds claims = undefined