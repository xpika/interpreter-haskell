{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE IncoherentInstances #-}



module Plugins.Html (
  hTable
 ,module Text.Blaze.Html5
 ,mySpecialHTMLGetter
 ,mySpecialStringGetter
) where

import Text.Blaze.Html5 hiding (map)
import Text.Blaze.Internal
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5.Attributes as A


import Control.Monad

import           Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import Data.Char
import Data.ByteString.Lazy (unpack)
instance Show Text.Blaze.Html5.Html where
    show x = map (chr . fromIntegral)  (unpack (renderHtml x))
    
    
rHtml x = mySpecialStringGetter $ map (chr . fromIntegral)  (unpack (renderHtml x))    
 
hTable :: (Show a, MySpecialHTMLGetter a,MySpecialStringGetter a) => [[a]] -> Text.Blaze.Internal.MarkupM ()
hTable xss =
  H.table $
    forM_ xss $ \xs ->
      H.tr $
        forM_ xs $ \x ->
          H.td H.! (A.style "text-align:right") $
           H.p (mySpecialHTMLGetter x)
           
class MySpecialHTMLGetter a where
 mySpecialHTMLGetter :: (Show a, MySpecialStringGetter a) => a -> Text.Blaze.Internal.MarkupM ()
 
instance MySpecialHTMLGetter (Text.Blaze.Internal.MarkupM ()) where
 mySpecialHTMLGetter a = a
 
instance MySpecialHTMLGetter a where
 mySpecialHTMLGetter a = toHtml $ mySpecialStringGetter a
 
class MySpecialStringGetter a where
    mySpecialStringGetter :: Show a => a -> String

instance MySpecialStringGetter String where
 mySpecialStringGetter a = a
 
instance MySpecialStringGetter a where
 mySpecialStringGetter a = show a
 