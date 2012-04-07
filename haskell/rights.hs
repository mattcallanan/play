let sides = [(a,b,c)|a <- [1..10], b <- [1..10], c <- [1..10]]
let triangles = [(a,b,c)|(a,b,c) <- sides, (a + b + c) == 24]
let rights = [(a,b,c)|a^2 + b^2 == c^2]
