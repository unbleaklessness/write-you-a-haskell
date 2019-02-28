module Lexer where

  import NanoParsec
  import qualified Tok

  data Tok = Tok {}

  langDef :: Tok.LanguageDef ()
  langDef = Tok.LanguageDef
    { Tok.commentStart = "{-"
    , Tok.commentEnd = "-}"
    }