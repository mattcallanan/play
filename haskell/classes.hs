{-# LANGUAGE MultiParamTypeClasses, EmptyDataDecls, FlexibleInstances,
FlexibleContexts, UndecidableInstances, TypeFamilies, ScopedTypeVariables #-}

import Data.Typeable (Typeable, cast)
import Data.Maybe (fromMaybe)

toString :: (Show a, Typeable a) => a -> String
toString x = fromMaybe (show x) (cast x)

class Board a

class Board a => EmptyBoard a

class Board a => InPlayBoard a

class Board a => CompletedBoard a

--start :: EmptyBoard
--start = undefined ::

--test :: Board a => a -> IO ()
--test a = putStrLn (read a)
