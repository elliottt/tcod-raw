{-# LANGUAGE ForeignFunctionInterface #-}

module Graphics.UI.TCOD.Raw.Console (
    init_root
  , set_window_title
  , set_fullscreen
  , is_fullscreen
  , is_window_closed

  , set_custom_font
  ) where

import Graphics.UI.TCOD.Raw.ConsoleTypes

import Data.Word ( Word8(..) )
import Foreign.C.String ( CString, withCString )
import Foreign.C.Types ( CInt(..) )
import Foreign.Ptr ( Ptr(..) )

#include "libtcod.h"


foreign import ccall "TCOD_console_init_root"
  c_init_root :: CInt -> CInt -> CString -> Word8 -> CInt -> IO ()

init_root :: Int -> Int -> String -> Bool -> Renderer -> IO ()
init_root w h title fullscreen renderer =
  withCString title $ \ p_title ->
    c_init_root (fromIntegral w) (fromIntegral h) p_title fullscreen'
                (getRenderer renderer)
  where
  fullscreen' | fullscreen = 1
              | otherwise  = 0



foreign import ccall "TCOD_console_set_window_title"
  c_set_window_title :: CString -> IO ()

set_window_title :: String -> IO ()
set_window_title title = withCString title c_set_window_title



foreign import ccall "TCOD_console_set_fullscreen"
  c_set_fullscreen :: Word8 -> IO ()

set_fullscreen :: Bool -> IO ()
set_fullscreen fullscreen
  | fullscreen = c_set_fullscreen 1
  | otherwise  = c_set_fullscreen 0



foreign import ccall "TCOD_console_is_fullscreen"
  c_is_fullscreen :: IO Word8

is_fullscreen :: IO Bool
is_fullscreen  =
  do w <- c_is_fullscreen
     case w of
       0 -> return False
       _ -> return True



foreign import ccall "TCOD_console_is_window_closed"
  c_is_window_closed :: IO Word8

is_window_closed :: IO Bool
is_window_closed  =
  do w <- c_is_window_closed
     case w of
       0 -> return False
       _ -> return True



foreign import ccall "TCOD_console_set_custom_font"
  c_set_custom_font :: CString -> CInt -> CInt -> CInt -> IO ()

set_custom_font :: FilePath -> FontFlags -> Int -> Int -> IO ()
set_custom_font path flags ch cv =
  withCString path $ \ p_path ->
    c_set_custom_font p_path (getFontFlags flags)
        (fromIntegral ch) (fromIntegral cv)
