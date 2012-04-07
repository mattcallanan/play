import Data.Maybe

factors n = let candidates = [2..floor (sqrt (fromInteger n))]
            in catMaybes $ map (\x -> if n `mod` x == 0
                                      then Just (x, n `div` x)
                                      else Nothing) candidates
									  
bigNums = [2000000000000..]
answer = map (length . factors) (take 10 bigNums)
main = print answer
