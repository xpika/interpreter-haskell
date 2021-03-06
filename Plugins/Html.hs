{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE IncoherentInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Plugins.Html (
  hTable
 ,hTableWithHeader
 ,mySpecialHTMLGetter
 ,mySpecialStringGetter
 ,fromString
) where

import Text.Blaze.Html5 hiding (map)
import Text.Blaze.Internal
import qualified Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import Control.Monad

import Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import Data.Char
import Data.ByteString.Lazy (unpack)
import Data.String

instance Show Text.Blaze.Html5.Html where
    show x = map (chr . fromIntegral)  (unpack (renderHtml x))
    
rHtml x = mySpecialStringGetter $ map (chr . fromIntegral) (unpack (renderHtml x))    


hTableWithHeader :: (Show a, MySpecialHTMLGetter a,MySpecialStringGetter a) => [[a]] -> Text.Blaze.Internal.MarkupM ()
hTableWithHeader (xs:xss) =
  H.table $
   do makeHeaders xs 
      makeCells xss
      
makeHeaders :: (Show a, MySpecialHTMLGetter a,MySpecialStringGetter a) => [a] -> Text.Blaze.Internal.MarkupM ()
makeHeaders xs = 
    H.tr $
      forM_ xs $ \x ->
      H.th H.! (A.style "text-align:right") $
        H.p (mySpecialHTMLGetter x)

makeCells :: (Show a, MySpecialHTMLGetter a,MySpecialStringGetter a) => [[a]] -> Text.Blaze.Internal.MarkupM ()
makeCells xss = 
  forM_ xss $ \xs ->
    H.tr $
      forM_ xs $ \x ->
      H.td H.! (A.style "text-align:right") $
        H.p (mySpecialHTMLGetter x)


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
