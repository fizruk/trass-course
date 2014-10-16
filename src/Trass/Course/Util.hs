module Trass.Course.Util where

import Control.Applicative
import Control.Monad

import Data.Text (Text)
import qualified Data.Text.IO as Text

import System.Directory
import System.FilePath

maybeWithFile :: (FilePath -> IO a) -> FilePath -> IO (Maybe a)
maybeWithFile f path = do
  exists <- doesFileExist path
  if exists
    then Just <$> f path
    else return Nothing

getSubDirectories :: FilePath -> IO [FilePath]
getSubDirectories path = do
  dirs <- filter (\d -> d /= "." && d /= "..") <$> getDirectoryContents path
  filterM doesDirectoryExist $ map (path </>) dirs
