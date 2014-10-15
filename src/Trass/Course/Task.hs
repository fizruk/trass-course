module Trass.Course.Task where

import Control.Applicative
import Data.Aeson
import Data.Text (Text)

data Task = Task
  { taskTitle       :: Text
  , taskDescription :: FilePath
  }
  deriving (Show)

instance FromJSON Task where
  parseJSON (Object v) = Task
                     <$> v .: "title"
                     <*> v .: "description"
  parseJSON _ = empty

instance ToJSON Task where
  toJSON Task{..} = object
    [ "title"       .= taskTitle
    , "description" .= taskDescription ]
