module Plugins.LiteralString where

data LitString = LitString String

instance Show LitString where
    show (LitString x) = x
    
str = LitString
