module Resources where

import Data.List

myButton value = "<button> "++value++" </button>" 

data LitString = LitString String

instance Show LitString where
    show (LitString x) = x
    
str = LitString

