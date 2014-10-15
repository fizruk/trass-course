module Trass.Course.Util where

import Data.Aeson
import Data.Aeson.Types
import Data.Text (Text)
import qualified Data.HashMap.Strict as HashMap

(.=?) :: ToJSON a => Text -> Maybe a -> [Pair]
k .=? v = maybe [] (\v' -> [k .= v']) v

objectUnion :: Value -> Value -> Value
objectUnion (Object v) (Object v') = Object $ HashMap.union v v'
objectUnion _ _ = object []

