module Main where

import qualified Lib (someFunc)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  Lib.someFunc
