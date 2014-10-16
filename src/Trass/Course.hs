module Trass.Course (
  module Trass.Course.Section,
  module Trass.Course.Task,

  Course(..),
) where

import Control.Applicative
import Control.Monad

import Trass.Course.Section
import Trass.Course.Task

import System.Directory
import System.FilePath

data Course = Course
  { courseSection     :: Section
  , courseTasks       :: [Task]
  , courseSubsections :: [Course]
  }
  deriving (Show)

readCourse :: FilePath -> IO Course
readCourse path = Course
  <$> readSection path
  <*> readTasks path
  <*> readSubsections path

readSubsections :: FilePath -> IO [Course]
readSubsections path = do
  paths       <- map (path </>) <$> getDirectoryContents path
  dirs        <- filterM doesDirectoryExist paths
  courseDirs  <- filterM (doesFileExist . (</> "overview.md")) dirs
  mapM readCourse courseDirs
