{-
### Question 1
From the example in the book:
    let newFocus = modify (\_ -> 'P') (goRight (goLeft (freeTree,[])))  
What are the elements as in freeTree as it goes through the left and right branches and what element is replaced in the tree?
-}
-- ['O', 'Y']
-- 'Y' gets replace with 'P'

{-
### Question 2

Implement a text editor that:

* Moves up a line,
* Moves down a line,
* Inserts a line,
* Deletes a line,
* Replaces a line,
* Moves to the start of the document,
* Moves to the end of the document.

Make sure we get can't go passed the top or bottom of the document.
-}

{- Function signatures: -}

type HEdit = ([String], [String])
cursorUp :: HEdit -> HEdit
cursorDown :: HEdit -> HEdit
insertLine :: String -> HEdit -> HEdit
deleteLine :: HEdit -> HEdit
replaceLine :: String -> HEdit -> HEdit
startDocument :: HEdit -> HEdit      -- "home" line
endDocument :: HEdit -> HEdit        -- "end" line

{- Tests: -}

line1 = "first line"
line2 = "second line"
line3 = "third line"
emptyDocument = ([], [])
document = ([line1, line2, line3], [])
cursorUpOk1 = cursorUp(document) == document
cursorUpOk2 = cursorUp([line2, line3],[line1]) == document
cursorDownOk1 = cursorDown(document) == ([line2, line3], [line1])
cursorDownOk2 = cursorDown([], [line3, line2, line1]) == cursorDown([], [line3, line2, line1])
startDocumentOk = startDocument(cursorDown(cursorDown(document))) == document
endDocumentOk = endDocument(document) == ([], [line3, line2, line1])
insertLineOk = insertLine line1 (insertLine line2 (insertLine line3 emptyDocument)) == document
deleteLineOk1 = deleteLine document == ([line2, line3], [])
deleteLineOk2 = deleteLine emptyDocument == emptyDocument
deleteLineOk3 = deleteLine(endDocument(document)) == ([], [line2, line1])
replaceLineOk1 = replaceLine "skink" document == (["skink", line2, line3], [])
complicated = endDocument(replaceLine "george" (cursorUp(replaceLine "fred" (deleteLine(cursorDown(document)))))) == ([], ["fred", "george"])
allTests = [cursorUpOk1, cursorUpOk2, cursorDownOk1, cursorDownOk2, startDocumentOk, endDocumentOk, insertLineOk,deleteLineOk1, deleteLineOk2, deleteLineOk3, replaceLineOk1, complicated]

{- Answer -}

cursorUp (xs, []) = (xs, [])
cursorUp (xs, b:bs) = (b:xs, bs)
cursorDown ([], bs) = ([], bs)
cursorDown (x:xs, bs) = (xs, x:bs)
insertLine l (xs, bs) = (l:xs, bs)
deleteLine ([], bs) = ([], bs)  -- should this delete the last breadcrumb? I don't think so.
deleteLine (_:xs, bs) = (xs, bs)
replaceLine _ ([], bs) = ([], bs)
replaceLine l (_:xs, bs) = (l:xs, bs)
startDocument (xs, []) = (xs, [])
startDocument z = startDocument $ cursorUp z
endDocument ([], bs) = ([], bs)
endDocument z = endDocument $ cursorDown z


{-
### Question 3

A nexus is a tree that shares nodes (see page 3 of [Functional Pearl Trouble Shared is Trouble Halved](http://www.cs.ox.ac.uk/ralf.hinze/publications/HW03.pdf)).
It splits the value of the node into two parts using the following function:

isegs xs = [init xs, tail xs]
isegs [1,2,3,4] = [ [1,2,3],[2,3,4] ]
-}

{- Write a program that simulates a nexus, using the following functions and data: -}

data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)
data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving Show
type Breadcrumbs a = [Crumb a]
type Zipper a = (Tree a, Breadcrumbs a)


modify :: (a -> a) -> Zipper a -> Zipper a
modify f (Node x l r, bs) = (Node (f x) l r, bs)
modify f (Empty, bs) = (Empty, bs)

attach :: Tree a -> Zipper a -> Zipper a
attach t (_, bs) = (t, bs)

isegs xs = [init xs, tail xs]
okIsegs = isegs [1,2,3,4] == [ [1,2,3],[2,3,4] ]

--nexus :: Tree [Int]
startNexus = Node ([1,2,3,4]) Empty Empty
--startNexusZipper :: Zipper a
startNexusZipper = (startNexus, [])
endNexus =
    Node [1,2,3,4]
        (Node [1,2,3]
            (Node [1,2]
                (Node [1] Empty Empty)
                (Node [2] Empty Empty)
            )
            (Node [2,3]
                (Node [2] Empty Empty)
                (Node [3] Empty Empty)
            )
        )
        (Node [2,3,4]
            (Node [2,3]
                (Node [2] Empty Empty)
                (Node [3] Empty Empty)
            )
            (Node [3,4]
                (Node [3] Empty Empty)
                (Node [4] Empty Empty)
            )
        )

createNexus :: Zipper [Int] -> Zipper [Int]
createNexus z@(t, bs) = attach (toNexus t) z

toNexus :: Tree [Int] -> Tree [Int]
toNexus (Node [x] l r) = Node [x] l r
toNexus (Node xs l r) = Node xs (toNexus (Node (init xs) l r)) (toNexus (Node (tail xs) l r))


{- Make this True: -}

okBeginNexus = (fst (createNexus startNexusZipper)) == (endNexus)
