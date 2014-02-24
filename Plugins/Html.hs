{-# LANGUAGE OverloadedStrings , TypeSynonymInstances, FlexibleInstances#-}
import qualified Text.Blaze.Html5 as H
import           Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import Control.Monad
import Data.ByteString.Lazy (unpack)
import Data.Char

instance Show H.Html where
    show x = map ( chr .fromIntegral)  (unpack (renderHtml x))
    
renderTable xss = do 
  H.table $ do
    forM_ xss $ \xs ->
      H.tr $ do
        forM_ xs $ \x ->
          H.td $ do
            H.p (H.toHtml $ show x) 