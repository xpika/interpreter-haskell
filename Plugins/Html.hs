{-# LANGUAGE OverloadedStrings , TypeSynonymInstances, FlexibleInstances#-}

module Plugins.Html (
  hTable
 ,rHtml
 ,module Text.Blaze.Html5 
) where

import Text.Blaze.Html5 hiding (map)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5.Attributes as A
import           Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import Control.Monad
import Data.ByteString.Lazy (unpack)
import Data.Char
import Plugins.LiteralString

instance Show Text.Blaze.Html5.Html where
    show x = map (chr . fromIntegral)  (unpack (renderHtml x))
    
    
rHtml x = str $ map (chr . fromIntegral)  (unpack (renderHtml x))    
    
hTable xss =
  H.table $
    forM_ xss $ \xs ->
      H.tr $
        forM_ xs $ \x ->
          H.td H.! (A.style "text-align:right") $
           H.p (H.toHtml $ show $ str $ x)