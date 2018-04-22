module Main where

import Data.Array.Accelerate              as A
import Data.Array.Accelerate.LLVM.Native  as CPU
import Data.Array.Accelerate.LLVM.PTX     as GPU
import Criterion
import Criterion.Main
import Criterion.Types
import Dotp

myConfig :: Config
myConfig = defaultConfig {timeLimit = 2, verbosity = Verbose}

main :: IO ()
main = defaultMainWith
  myConfig
  [ bench "GPU dotp" $ nf (\(xs, ys) -> GPU.run $ dotp xs ys) (xs, ys)
  , bench "CPU dotp" $ nf (\(xs, ys) -> CPU.run $ dotp xs ys) (xs, ys)
  ]
