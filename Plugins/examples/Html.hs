table cells = 
  do
  H.h1 "Html Elements"
  let elements = [H.button,(H.! A.style "background-color:blue") . H.div,H.textarea,H.h1,H.li,H.select.H.option]
  let contents = map (fromString . show)  [1..]
  let cells = [zipWith ($)  elements contents]
  hTable  cells H.! A.border "1"
