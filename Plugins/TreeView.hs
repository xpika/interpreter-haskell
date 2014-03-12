module Plugins.TreeView where

import Data.Tree
import Plugins.LiteralString

 -- wip

data HTMLTree = HTMLTree (Tree String)

testTree = Node "" [
              Node "c1" [ Node "1" [], Node "2" [] ]
             ,Node "c2" [ Node "1" [], Node "2" [] ]
           ]

renderList xs = 
    "<ul>" 
  ++ concatMap (\item -> "<li>" ++ show (stri item) ++ "</li>") xs
  ++ "</ul>"

instance Show (HTMLTree) where
  show (HTMLTree s) = renderList . map ((\x -> "<a style=\"text-decoration:none\" href=\"#\">[+]</a> "++ x) . rootLabel)  $  subForest s
 


renderTree = HTMLTree testTree

