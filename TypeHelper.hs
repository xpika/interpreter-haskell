{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE IncoherentInstances #-}
{-# LANGUAGE DeriveDataTypeable #-}

module TypeHelper (
   decodeTypeHelper
  ,TypeQuery (..)
  ,_type
) where

import Language.Haskell.Interpreter hiding (get)
import Data.Generics hiding (typeOf)

data TypeQuery = FunctionType String
  deriving (Data,Typeable)

decodeTypeHelper (FunctionType string) = typeOf string

_type = FunctionType
