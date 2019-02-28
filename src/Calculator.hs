module Calculator where

  import Control.Monad
  import NanoParsec

  data Expr
    = Add Expr Expr
    | Multiply Expr Expr
    | Subtract Expr Expr
    | Literal Int
    deriving Show
  
  eval :: Expr -> Int
  eval ex = case ex of
    Add a b -> eval a + eval b
    Multiply a b -> eval a * eval b
    Subtract a b -> eval a - eval b
    Literal n -> n
  
  int :: Parser Expr
  int = Literal <$> number

  expr :: Parser Expr
  expr = term `chainl1` addop

  term :: Parser Expr
  term = factor `chainl1` mulop

  factor :: Parser Expr
  factor = int `option` parens expr

  infixOp :: String -> (a -> a -> a) -> Parser (a -> a -> a)
  infixOp x f = reserved x >> return f

  addop :: Parser (Expr -> Expr -> Expr)
  addop = (infixOp "+" Add) `option` (infixOp "-" Subtract)

  mulop :: Parser (Expr -> Expr -> Expr)
  mulop = infixOp "*" Multiply

  run :: String -> Expr
  run = runParser expr

  main :: IO ()
  main = forever $ do
    putStr "> "
    a <- getLine
    print $ eval $ run a
