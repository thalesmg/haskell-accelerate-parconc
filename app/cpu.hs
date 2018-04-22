{-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wall -fno-warn-name-shadowing #-}

module Main ( main, test {-, maxDistances -} ) where

import Data.Array.Accelerate as A
import Data.Array.Accelerate.LLVM.Native as CPU
import ShortestPath
import System.Environment

main :: IO ()
main = do
   (n:_) <- fmap (fmap read) getArgs
   print (run (let g :: Acc Graph
                   g    = generate (constant (Z:.n:.n) :: Exp DIM2) f

                   f :: Exp DIM2 -> Exp Weight
                   f ix = let i,j :: Exp Int
                              Z:.i:.j = unlift ix
                          in
                          A.fromIntegral j +
                           A.fromIntegral i * constant (Prelude.fromIntegral n)
               in
                 A.foldAll (+) (constant 0) (shortestPathsAcc n g)))
