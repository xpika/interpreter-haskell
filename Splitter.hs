module Splitter (splitter) where 

import Text.ParserCombinators.Parsec

splitter :: String -> ([String],String)
splitter xs = case parse parser "" xs of
                Right x -> x

parser =  do
 modu <- many imp
 rest <- manyTill anyChar eof
 return (modu,rest)

imp = do
 string "import "
 modu <- manyTill anyChar (char ';' <|> newline)
 return modu
