# Testing Automatic Offload of `do concurrent`

Here we will port the nbody sample code in Intel oneAPI HPC Toolkit located at
[`oneAPI-src/oneAPI-samples/DirectProgramming/DPC++/N-Body/Methods/Nbody`](https://github.com/oneapi-src/oneAPI-samples/tree/master/DirectProgramming/DPC%2B%2B/N-BodyMethods/Nbody) from `C++` to Fortran. 

We will make use of a `DO CONCURRENT` loop and compile on Intel DevCloud to test `ifx` offload to Intel GPUs.

## Compiler options
Following https://community.intel.com/t5/Blogs/Tech-Innovation/Tools/The-Next-Chapter-for-the-Intel-Fortran-Compiler/post/1439297
the compiler options used are:

`-qopenmp -fopenmp-target-do-concurrent`

## Results
