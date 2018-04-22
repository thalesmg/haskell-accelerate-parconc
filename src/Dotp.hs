module Dotp where

import Data.Array.Accelerate              as A
import Data.Array.Accelerate.LLVM.Native  as CPU
import Data.Array.Accelerate.LLVM.PTX     as GPU

dotp :: Acc (Vector Float) -> Acc (Vector Float) -> Acc (Scalar Float)
dotp xs ys = A.fold (+) 0 (A.zipWith (*) xs ys)

xs :: Acc (Vector Float)
xs = use $ fromList (Z :. 10000) [0..]

ys :: Acc (Vector Float)
ys = use $ fromList (Z :. 10000) [1,3..]
