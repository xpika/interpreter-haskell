{-# LANGUAGE OverloadedStrings #-} 
import Web.Scotty
import Control.Monad.Trans
import Data.Text.Lazy
import Language.Haskell.Interpreter hiding (get)
import Text.Read (readMaybe)
import Control.Applicative
import Data.Monoid (mconcat)

import TypeHelper

import Paths_interpreter_haskell
import System.IO

uneither q =  (case q of {
               Right x -> x
              ;Left g -> show g
             })
   

main = scotty 80 $ do
  get "/ghci_command" $ do
    beam <- param "foo"
    interpreted <- liftIO $ 
        do runInterpreter $
             do 
             loadModules ["Resources"] 
             set [languageExtensions :=  [QuasiQuotes]]
             setTopLevelModules ["Resources"] 
             setImports ["Prelude","Control.Monad"]
             t <- typeOf beam
             q <- case t of {
                  "TypeQuery" -> do {
                     interpret beam infer >>= decodeTypeHelper
                   };
                   _ -> eval beam;
              }
             return q
    html $ mconcat [pack (uneither interpreted)]
  get "/jquery.min.js" $ do
    fname <- liftIO $ getDataFileName "jquery.min.js" 
    newfile <- liftIO $ readFileSafe fname
    html $ mconcat [pack newfile] 
  get "/:word" $ do
    beam <- param "word"
    newfile <- liftIO $ readFile "text.html"
    html $ mconcat [pack newfile,beam]


readFileSafe str =  do 
 handle <- openFile str ReadMode
 hSetEncoding handle utf8_bom
 hGetContents handle

