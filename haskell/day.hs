data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday   
           deriving (Eq, Ord, Show, Read, Bounded, Enum) 

-- [Monday .. Friday]
-- read "Friday" :: Day
-- minbound :: Day
