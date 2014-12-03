{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Control.Monad.Trans
import Data.Text.Lazy
import Language.Haskell.Interpreter hiding (get)
import Text.Read (readMaybe)
import Control.Applicative
import Data.Monoid (mconcat)


import TypeHelper

import Splitter

uneither q =  (case q of {
               Right x -> x
              ;Left g -> show g
             })
   
main = scotty 3000 $ do
  get "/ghci_command" $ do
    beam <- param "foo"
    let z@(imps,q) = splitter beam
    liftIO $ print z
    interpreted <- liftIO $ 
        do runInterpreter $
             do 
             loadModules ["Resources"] 
             set [languageExtensions :=  [QuasiQuotes]]
             setTopLevelModules ["Resources"] 
             setImports (["Prelude","Control.Monad"]++imps)
             t <- typeOf q
             q <- case t of {
                  "TypeQuery" -> do {
                     interpret q infer >>= decodeTypeHelper
                   };
                   _ -> eval q;
              }
             return q
    html $ mconcat [pack (uneither interpreted)]
  get "/jquery.min.js" $ do
    newfile <- liftIO $ readFile "./jquery.min.js"
    html $ mconcat [pack newfile]
  get "/:word" $ do
    beam <- param "word"
    newfile <- liftIO $ readFile "text.html"
    html $ mconcat [pack newfile,beam]




