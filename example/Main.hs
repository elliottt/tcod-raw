module Main where

import Graphics.UI.TCOD.Raw
import Graphics.UI.TCOD.Raw.Console
import Graphics.UI.TCOD.Raw.ConsoleTypes

import Control.Concurrent ( threadDelay )


main :: IO ()
main  = do
  init_root 80 24 "testing" False glsl
  threadDelay 5000000

