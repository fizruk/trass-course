module Trass.Course (
  module Trass.Course.Section,
  module Trass.Course.Task,

  Course(..),
  readCourse,
  readSubsections,
) where

import Control.Applicative
import Control.Monad

import System.Directory
import System.FilePath

import Trass.Course.Section
import Trass.Course.Task
import Trass.Course.Util

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
  dirs        <- getSubDirectories path
  courseDirs  <- filterM (doesFileExist . (</> "overview.md")) dirs
  mapM readCourse courseDirs

