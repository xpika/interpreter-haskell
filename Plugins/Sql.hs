module Plugins.Sql where

import Database.HDBC 
import Database.HDBC.Sqlite3
import Plugins.Html

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html4.Transitional.Attributes as A 

import qualified Data.ByteString
import Data.Char

fun = do
      conn <- connectSqlite3 "new.db"
      quickQuery' conn "SELECT * from mytable" []

unSql (SqlByteString x) = x

sqlite_query db str = do
 conn <- connectSqlite3 db
 statement <- prepare conn str
 -- results <- quickQuery' conn str []
 i <- execute statement []
 i2 <- getColumnNames statement
 results <- fetchAllRows' statement
 return ( [i2] ++ (map (map ( map (chr. fromIntegral). Data.ByteString.unpack . unSql)) results))


