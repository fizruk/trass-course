module Trass.Course.Util where

import Control.Applicative

import Data.Text (Text)
import qualified Data.Text.IO as Text

import System.Directory

maybeReadFile :: FilePath -> IO (Maybe Text)
maybeReadFile path = do
  exists <- doesFileExist path
  if exists
    then Just <$> Text.readFile path
    else return Nothing
