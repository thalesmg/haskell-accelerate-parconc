{-# LANGUAGE CPP #-}

module Main where

import Data.Array.Accelerate              as A
#ifdef USE_GPU
import Data.Array.Accelerate.LLVM.PTX as GPU
#else
import Data.Array.Accelerate.LLVM.Native as CPU
#endif
import Criterion
import Criterion.Main
import Criterion.Types
import ShortestPath
import Data.Monoid ((<>))

#ifdef USE_GPU
ambiente = "GPU"
#else
ambiente = "CPU"
#endif

myConfig :: Config
myConfig = defaultConfig {timeLimit = 2, verbosity = Verbose}

runBench :: Int -> Scalar Weight
runBench n =
  run (let g :: Acc Graph
           g    = generate (constant (Z:.n:.n) :: Exp DIM2) f

           f :: Exp DIM2 -> Exp Weight
           f ix = let i,j :: Exp Int
                      Z:.i:.j = unlift ix
                  in
                    A.fromIntegral j +
                    A.fromIntegral i * constant (Prelude.fromIntegral n)
        in
          A.foldAll (+) (constant 0) (shortestPathsAcc n g))

main :: IO ()
main = defaultMainWith
  myConfig
  [ bench ("shortest " <> ambiente) $ nf runBench 2000
  ]
