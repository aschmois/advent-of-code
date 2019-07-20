-- stack --resolver lts-13.20 script

-- run it like : `stack 1.hs`
-- for ghcid : stack --resolver lts-13.20 exec --package ghcid -- ghcid 1.hs --test :main

import qualified Distribution.Simple.Utils as Utils
import qualified Data.List as List
import qualified Data.Vector as Vector

main :: IO ()
main = do
  content <- readFile "input.txt"
  pairs <- 
    removePair 0
    . Vector.fromList
    $ content
  print pairs

removePair :: Int -> Vector.Vector Char -> IO String
removePair idx chars = do
    if idx >= (Vector.length chars)-1 then 
        pure $ Vector.toList chars
    else do
        let str = Vector.slice idx ((Vector.length chars) - idx) chars
            first = Vector.unsafeIndex str idx 
            second = Vector.unsafeIndex str (idx+1)
        if first == second || (Utils.lowercase [first]) /= (Utils.lowercase [second]) then do
            print ("1first " <> [first] <> " second " <> [second] <> " idx " <> (show idx))
            removePair (idx + 1) chars
        else do
            print ("first " <> [first] <> " second " <> [second] <> " idx " <> (show idx))
            let v1 = Vector.drop idx chars
                v2 = Vector.drop idx v1
            print v1
            print v2
            -- print ("second " <> [second])
            -- print ("rest " <> rest)
            removePair 0 v2