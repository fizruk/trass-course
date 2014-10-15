module Trass.Course (
  module Trass.Course.Section,
  module Trass.Course.Task,

  Course(..),
) where

import Control.Applicative
import Data.Aeson
import Trass.Course.Util

import Trass.Course.Section
import Trass.Course.Task

data Course = Course
  { courseSection     :: Section
  , courseTasks       :: [Task]
  , courseSubsections :: [Course]
  }
  deriving (Show)

instance FromJSON Course where
  parseJSON o@(Object v) = Course
                       <$> parseJSON o
                       <*> v .:? "tasks"    .!= []
                       <*> v .:? "sections" .!= []
  parseJSON _ = empty

instance ToJSON Course where
  toJSON Course{..} = objectUnion
    (toJSON courseSection)
    (object
      [ "tasks"     .= courseTasks
      , "sections"  .= courseSubsections ])
