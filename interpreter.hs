{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Control.Monad.Trans
import Data.Text.Lazy
import Language.Haskell.Interpreter hiding (get)
import Text.Read (readMaybe)
import Control.Applicative

import Data.Monoid (mconcat)
   
main = scotty 3000 $ do
  get "/ghci_command" $ do
    beam <- param "foo"
    interpreted <- liftIO $ 
        do runInterpreter $
             do 
             loadModules ["Resources"] 
             set [languageExtensions :=  [OverloadedStrings]]
             setTopLevelModules ["Resources"] 
             setImports ["Prelude","Control.Monad"]
             q <- eval beam
             return (case q of {
               Right x -> x
              ;Left g -> show g
             })
    html $ mconcat [pack interpreted]
  get "/jquery.min.js" $ do
    newfile <- liftIO $ readFile "./jquery.min.js"
    html $ mconcat [pack newfile]
  get "/:word" $ do
    beam <- param "word"
    newfile <- liftIO $ readFile "text.html"
    html $ mconcat [pack newfile,beam]



