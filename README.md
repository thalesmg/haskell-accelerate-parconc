# Example of using Accelerate-HS from Parallel and Concurrent Programming in Haskell

## Environment

- OS: Ubuntu 17.10
- Installed CUDA according to the [official guide](https://developer.nvidia.com/cuda-downloads) (Linux > x86_64 > Ubuntu > 17.04 > deb (local)), CUDA v9.1, GeForce GTX 960M.
- `apt install llvm-5.0-dev`
- Stack resolver 11.5
- Stack extra deps:
  - accelerate-llvm-1.1.0.0
  - accelerate-llvm-native-1.1.0.1
  - accelerate-llvm-ptx-1.1.0.1
  - cuda-0.9.0.3
  - llvm-hs-5.0.0
  - llvm-hs-pure-5.0.0

More info on the [official Accelerate page](http://www.acceleratehs.org/get-started).

## Benchmarks

For some reason I yet do not understand, the vector dot product example from Accelerate's site is a lot slower with GPU than with CPU execution.

```
accelerate-parconc-0.1.0.0: benchmarks
Running 3 benchmarks...
Benchmark bench: RUNNING...
benchmarking GPU dotp
analysing with 1000 resamples
measurement overhead 1.136 ms
bootstrapping with 14 of 53 samples (26%)
time                 1.413 ms   (1.066 ms .. 1.623 ms)
                     0.811 R²   (0.723 R² .. 0.880 R²)
mean                 1.120 ms   (914.5 μs .. 1.389 ms)
std dev              471.6 μs   (426.2 μs .. 520.0 μs)
variance introduced by outliers: 98% (severely inflated)

benchmarking CPU dotp
analysing with 1000 resamples
bootstrapping with 23 of 75 samples (30%)
time                 299.8 μs   (289.8 μs .. 309.3 μs)
                     0.992 R²   (0.988 R² .. 0.996 R²)
mean                 298.0 μs   (292.7 μs .. 304.3 μs)
std dev              15.31 μs   (12.29 μs .. 21.51 μs)
found 1 outliers among 23 samples (4.3%)
  1 (4.3%) high mild
variance introduced by outliers: 42% (moderately inflated)

Benchmark bench: FINISH
Benchmark shortest-cpu: RUNNING...
benchmarking shortest CPU
measurement took 225.1 s
analysing with 1000 resamples
measurement overhead 1.747 ms
bootstrapping with 3 of 4 samples (75%)
time                 14.47 s    (13.71 s .. 15.07 s)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 14.52 s    (14.38 s .. 14.60 s)
std dev              129.1 ms   (0.0 s .. 129.7 ms)
variance introduced by outliers: 19% (moderately inflated)

Benchmark shortest-cpu: FINISH
Benchmark shortest-gpu: RUNNING...
benchmarking shortest GPU
measurement took 57.50 s
analysing with 1000 resamples
measurement overhead -2.658 ms
bootstrapping with 3 of 4 samples (75%)
time                 3.902 s    (2.888 s .. 4.730 s)
                     0.989 R²   (0.986 R² .. 1.000 R²)
mean                 3.712 s    (3.505 s .. 3.859 s)
std dev              221.5 ms   (0.0 s .. 254.2 ms)
variance introduced by outliers: 19% (moderately inflated)

Benchmark shortest-gpu: FINISH
```
