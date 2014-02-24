{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE IncoherentInstances #-}

module Plugins.LiteralString where

data LitString a = LitString a

instance Show (LitString String) where
    show (LitString x) = x
    
instance Show a => Show (LitString a) where
    show (LitString x) = show x    
    
str = LitString
