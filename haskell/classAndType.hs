
class Board a

data EmptyBoard = EmptyBoard deriving Show
data InPlayBoard = InPlayBoard deriving Show

instance Board EmptyBoard 
instance Board InPlayBoard 

start :: EmptyBoard
start = (EmptyBoard)

--play :: Board a => a -> a
play x = (InPlayBoard)

--finish :: Board -> Board
--finish (InPlayBoard) = (CompletedBoard)

test = do
    let x = start
    show x
--    play x



-- move :: Board -> Position -> Board
-- whoWon :: Board -> Player
-- takeBack :: Board -> Board
-- playerAt :: Board -> Position -> Player
-- forall Board b. forall Position p. such that (not (positionIsOccupied p b)). takeBack(move(p, b)) == b
