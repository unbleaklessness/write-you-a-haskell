module Tok where

  data LanguageDef = LanguageDef
    { commentStart :: String
    , commentEnd :: String
    , commentLine :: String
    , nestedComments :: Bool
    }