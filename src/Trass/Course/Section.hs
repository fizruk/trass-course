module Trass.Course.Section where

import Control.Applicative
import Control.Monad

import Data.Text (Text)
import qualified Data.Text    as Text
import qualified Data.Text.IO as Text
import qualified Data.Yaml as Yaml

import System.FilePath

import Trass.Config
import Trass.Config.Options
import Trass.Course.Util

data Section = Section
  { sectionPath         :: FilePath
  , sectionTitle        :: Text
  , sectionSummary      :: Maybe Text
  , sectionOverview     :: Maybe Text
  , sectionTheory       :: Maybe Text
  , sectionTrassConfig  :: Maybe (ConfigWithOptions TrassConfig)
  }
  deriving (Show)

readSection :: FilePath -> IO Section
readSection path = Section
  <$> pure path
  <*> pure (Text.pack path)
  <*> maybeWithFile Text.readFile (path </> "summary.txt")
  <*> maybeWithFile Text.readFile (path </> "overview.md")
  <*> maybeWithFile Text.readFile (path </> "theory.md")
  <*> (join <$> maybeWithFile Yaml.decodeFile (path </> "trass.yml"))
