{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE IncoherentInstances #-}
{-# LANGUAGE DeriveDataTypeable #-}

module TypeHelper (
   decodeTypeHelper
  ,TypeQuery (..)
  ,_type
  ,_browse
) where

import Language.Haskell.Interpreter hiding (get)
import Data.Generics hiding (typeOf)
import Plugins.Html

data TypeQuery = FunctionType String
               | ModuleElems String
  deriving (Data,Typeable)

decodeTypeHelper (FunctionType string) = typeOf string
decodeTypeHelper (ModuleElems string) = getModuleExports string >>= return . show . hTable . map (:[])

_type = FunctionType
_browse = ModuleElems