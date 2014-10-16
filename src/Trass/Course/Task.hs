module Trass.Course.Task where

import Control.Applicative
import Control.Monad

import Data.Text (Text)
import qualified Data.Text    as Text
import qualified Data.Text.IO as Text

import System.Directory
import System.FilePath

data Task = Task
  { taskPath        :: FilePath
  , taskTitle       :: Text
  , taskDescription :: Text
  }
  deriving (Show)

readTasks :: FilePath -> IO [Task]
readTasks path = do
  paths     <- map (path </>) <$> getDirectoryContents path
  dirs      <- filterM doesDirectoryExist paths
  taskDirs  <- filterM (doesFileExist . (</> "task.md")) dirs
  mapM readTask taskDirs

readTask :: FilePath -> IO Task
readTask path = Task
  <$> pure path
  <*> pure (Text.pack path)
  <*> Text.readFile (path </> "task.md")
