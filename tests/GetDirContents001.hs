{-# LANGUAGE CPP #-}
module GetDirContents001 where
#include "util.inl"
import System.Directory
import Data.List (sort)
import Data.Monoid ((<>))
import Data.Traversable (for)
import System.FilePath  ((</>))

main :: TestEnv -> IO ()
main _t = do
  createDirectory dir
  T(expectEq) () specials . sort =<< getDirectoryContents dir
  names <- for [1 .. 100 :: Int] $ \ i -> do
    let name = 'f' : show i
    writeFile (dir </> name) ""
    return name
  T(expectEq) () (sort (specials <> names)) . sort =<< getDirectoryContents dir
  where dir      = "dir"
        specials = [".", ".."]
