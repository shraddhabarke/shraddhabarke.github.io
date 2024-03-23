{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_tagsoup (
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
version = Version [0,14,8] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/shraddhabarke/.cabal/store/ghc-9.2.8/tgsp-0.14.8-29f913be/bin"
libdir     = "/Users/shraddhabarke/.cabal/store/ghc-9.2.8/tgsp-0.14.8-29f913be/lib"
dynlibdir  = "/Users/shraddhabarke/.cabal/store/ghc-9.2.8/lib"
datadir    = "/Users/shraddhabarke/.cabal/store/ghc-9.2.8/tgsp-0.14.8-29f913be/share"
libexecdir = "/Users/shraddhabarke/.cabal/store/ghc-9.2.8/tgsp-0.14.8-29f913be/libexec"
sysconfdir = "/Users/shraddhabarke/.cabal/store/ghc-9.2.8/tgsp-0.14.8-29f913be/etc"

getBinDir     = catchIO (getEnv "tagsoup_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "tagsoup_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "tagsoup_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "tagsoup_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tagsoup_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tagsoup_sysconfdir") (\_ -> return sysconfdir)




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
