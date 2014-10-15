module Trass.Course.Section where

import Control.Applicative
import Data.Aeson
import Data.Text (Text)
import Trass.Course.Util

data Section = Section
  { sectionTitle        :: Text
  , sectionSummary      :: Maybe Text
  , sectionOverview     :: Maybe FilePath
  , sectionTheory       :: Maybe FilePath
  }
  deriving (Show)

instance FromJSON Section where
  parseJSON (Object v) = Section
                     <$> v .:  "title"
                     <*> v .:? "summary"
                     <*> v .:? "overview"
                     <*> v .:? "theory"
  parseJSON _ = empty

instance ToJSON Section where
  toJSON Section{..} = object $ concat
    [ ["title"    .=  sectionTitle ]
    , "summary"   .=? sectionSummary
    , "overview"  .=? sectionOverview
    , "theory"    .=? sectionTheory ]
