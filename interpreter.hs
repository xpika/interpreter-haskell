{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Control.Monad.Trans
import Data.Text.Lazy
import Language.Haskell.Interpreter hiding (get)

import Data.Monoid (mconcat)

main = scotty 80 $ do
  get "/ghci_command/:word" $ do
    beam <- param "word"
    interpreted <- liftIO $  runInterpreter $ setImports ["Prelude","Control.Monad"] >> eval beam
    html $ mconcat [pack (show interpreted)]
  get "/:word" $ do
    beam <- param "word"
    newfile <- liftIO $ readFile "text.html"
    html $ mconcat [pack newfile,beam]
