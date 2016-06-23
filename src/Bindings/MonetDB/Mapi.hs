{-# LANGUAGE ForeignFunctionInterface #-}
module Bindings.MonetDB.Mapi where

import Foreign
import Foreign.C.Types
import Foreign.C.String

type MapiMsg = CInt

cMOK, cMERROR, cMTIMEOUT, cMMORE, cMSERVER :: MapiMsg
cMOK      = 0
cMERROR   = (-1)
cMTIMEOUT = (-2)
cMMORE    = (-3)
cMSERVER  = (-4)

type Mapi = Ptr ()

type MapiHdl = Ptr ()

foreign import ccall "mapi.h mapi_connect" mapi_connect
    :: Ptr CChar
    -> CInt
    -> Ptr CChar
    -> Ptr CChar
    -> Ptr CChar
    -> Ptr CChar
    -> IO Mapi

foreign import ccall "mapi.h mapi_disconnect" mapi_disconnect :: Mapi -> IO ()
foreign import ccall "mapi.h mapi_query" mapi_query :: Mapi -> Ptr CChar -> IO MapiHdl
foreign import ccall "mapi.h mapi_close_handle" mapi_close_handle :: MapiHdl -> IO ()
foreign import ccall "mapi.h mapi_execute" mapi_execute :: MapiHdl -> IO MapiMsg
foreign import ccall "mapi.h mapi_fetch_row" mapi_fetch_row :: MapiHdl -> IO CInt
foreign import ccall "mapi.h mapi_get_field_count" mapi_get_field_count :: MapiHdl -> IO CInt
foreign import ccall "mapi.h mapi_fetch_field" mapi_fetch_field :: MapiHdl -> CInt -> IO (Ptr CChar)
foreign import ccall "mapi.h mapi_fetch_field_len" mapi_fetch_field_len :: MapiHdl -> CInt -> IO CSize
foreign import ccall "mapi.h mapi_error" mapi_error :: Mapi -> IO CInt
foreign import ccall "mapi.h mapi_error_str" mapi_error_str :: Mapi -> IO (Ptr CChar)
foreign import ccall "mapi.h mapi_result_error" mapi_result_error :: MapiHdl -> IO (Ptr CChar)
foreign import ccall "mapi.h mapi_get_name" mapi_get_name :: MapiHdl -> CInt -> IO (Ptr CChar)

