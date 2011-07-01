heron a b c = sqrt (s*(s-a)*(s-b)*(s-c))
    where
    s = (a+b+c) / 2


areaTriangleTrig  a b c = c * height / 2   -- use trigonometry
    where
    cosa   = (b^2 + c^2 - a^2) / (2*b*c)
    sina   = sqrt (1 - cosa^2)
    height = b*sina


areaTriangleHeron a b c = result           -- use Heron's formula
    where
    result = sqrt (s*(s-a)*(s-b)*(s-c))
    s      = (a+b+c)/2

