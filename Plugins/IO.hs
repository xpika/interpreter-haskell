
module Plugins.IO where

import System.IO.Unsafe 


instance Show a => Show (IO a) where 
  show io = show $ unsafePerformIO io

