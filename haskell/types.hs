
data Board = EmptyBoard | InPlayBoard | CompletedBoard deriving (Show)

--start :: EmptyBoard
--start = undefined ::

--test :: Board a => a -> IO ()
--test a = putStrLn (read a)

start :: Board
start = (EmptyBoard)

play :: Board -> Board
play (EmptyBoard) = (InPlayBoard)

finish :: Board -> Board
finish (InPlayBoard) = (CompletedBoard)

test = do
    let x = start
    finish x