bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
    | bmi <= skinny = "You're underweight, you emo, you!" ++ (show whatever)
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"  
    | otherwise     = "You're a whale, congratulations!"  
    where bmi = weight / height ^ 2
          whatever@(skinny, normal, fat) = (18.5, 25.0, 30.0)

		  
capital "" = "Empty string, whoops!"  
capital all@('D':xs) = "The first letter of " ++ all ++ " is D"
capital all@(x:xs) = "x" 


x = "abcxyz"
