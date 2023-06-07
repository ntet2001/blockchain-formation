{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_queue (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/ntetigor/Documents/blockchain-formation/queue/.stack-work/install/x86_64-linux-tinfo6/500ba532efa721b893260cad6f44689b6a2c41e1401d2378d1d104de0b6d7d09/9.2.7/bin"
libdir     = "/home/ntetigor/Documents/blockchain-formation/queue/.stack-work/install/x86_64-linux-tinfo6/500ba532efa721b893260cad6f44689b6a2c41e1401d2378d1d104de0b6d7d09/9.2.7/lib/x86_64-linux-ghc-9.2.7/queue-0.1.0.0-6a567vhAGyK4f5DdHVmHMK"
dynlibdir  = "/home/ntetigor/Documents/blockchain-formation/queue/.stack-work/install/x86_64-linux-tinfo6/500ba532efa721b893260cad6f44689b6a2c41e1401d2378d1d104de0b6d7d09/9.2.7/lib/x86_64-linux-ghc-9.2.7"
datadir    = "/home/ntetigor/Documents/blockchain-formation/queue/.stack-work/install/x86_64-linux-tinfo6/500ba532efa721b893260cad6f44689b6a2c41e1401d2378d1d104de0b6d7d09/9.2.7/share/x86_64-linux-ghc-9.2.7/queue-0.1.0.0"
libexecdir = "/home/ntetigor/Documents/blockchain-formation/queue/.stack-work/install/x86_64-linux-tinfo6/500ba532efa721b893260cad6f44689b6a2c41e1401d2378d1d104de0b6d7d09/9.2.7/libexec/x86_64-linux-ghc-9.2.7/queue-0.1.0.0"
sysconfdir = "/home/ntetigor/Documents/blockchain-formation/queue/.stack-work/install/x86_64-linux-tinfo6/500ba532efa721b893260cad6f44689b6a2c41e1401d2378d1d104de0b6d7d09/9.2.7/etc"

getBinDir     = catchIO (getEnv "queue_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "queue_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "queue_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "queue_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "queue_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "queue_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
