
module Graphics.UI.TCOD.Raw.ConsoleTypes where

import Foreign.C.Types ( CInt(..) )

#include "libtcod.h"


newtype Renderer = Renderer { getRenderer :: CInt }

glsl :: Renderer
glsl  = Renderer (#const TCOD_RENDERER_GLSL)

opengl :: Renderer
opengl  = Renderer (#const TCOD_RENDERER_OPENGL)

sdl :: Renderer
sdl  = Renderer (#const TCOD_RENDERER_SDL)



newtype FontFlags = FontFlags { getFontFlags :: CInt }
