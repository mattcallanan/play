{-
Question 1
Hide foldr and foldl.
-}

--import Prelude hiding (foldr, foldl)

{-
Question 2
What is the standard directory structure for a Haskell project?
-}
{-
http://www.haskell.org/haskellwiki/Structure_of_a_Haskell_project
http://www.haskell.org/haskellwiki/How_to_write_a_Haskell_program
app/             -- Root-dir
  src/           -- For keeping the sourcecode
    Main.lhs     -- The main-module
    App/         -- Use hierarchical modules
      ...
      Win32/     -- For system dependent stuff
      Unix/
    cbits/       -- For C code to be linked to the haskell program
  testsuite/     -- Contains the testing stuff
    runtests.sh  -- Will run all tests
    tests/       -- For unit-testing and checking
      App/       -- Clone the module hierarchy, so that there is one 
                    testfile per sourcefile
    benchmarks/   -- For testing performance
  doc/           -- Contains the manual, and other documentation
    examples/    -- Example inputs for the program
    dev/         -- Information for new developers about the project, 
                    and eg. related literature
  util/          -- Auxiliary scripts for various tasks
  dist/          -- Directory containing what end-users should get
    build/       -- Contains binary files, created by cabal
    doc/         -- The haddock documentation goes here, created by cabal
    resources/   -- Images, soundfiles and other non-source stuff
                    used by the program
  _DARCS/        
  README         -- Textfile with short introduction of the project
  INSTALL        -- Textfile describing how to build and install
  TODO           -- Textfile describing things that ought to be done
  AUTHORS        -- Textfile containing info on who does and has done 
                    what in this project, and their contact info
  LICENSE        -- Textfile describing licensing terms for this project
  app.cabal      -- Project-description-file for cabal
  Setup.hs       -- Program for running cabal commands
  
-}

{-
Question 3
Run the function 'l16' in week7.hs to print out:
---------------------
|cstmr-name|loan-num|
---------------------
|Adams     |L-16    |
---------------------
To do this you'll need to complete the export specification which includes a data type constructor and any methods in the module RelationalAlgebra.hs.

This includes:
- Any imports
- Types:
-- Records are Arrays of Record
-- Record are Arrays of Value
-- Schema are Arrays of Fields
-- Value, Field and Name are Strings
- The datatype Table deriving Eq and Show and made of a Name, a Schema and Records.
- Any methods required by week7.hs.
-}

