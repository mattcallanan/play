x = show smlx ++ "," ++ show smly ++ " " ++ show cellCount
    where smlx = (-10)
          smly = (-100)
          bigx = 99
          bigy = 999
          cellCount = (bigx - smlx) * (bigy - smly)
