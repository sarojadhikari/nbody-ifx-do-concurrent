# ifx Automatic Offload of Do Concurrent Test

Here we will port the nbody sample code in Intel oneAPI HPC Toolkit located at
`oneAPI/oneAPI-samples/DirectProgramming/DPC++/N-Body/Methods/Nbody`

from `C++` to Fortran. 

We will make use of a `DO CONCURRENT` loop and compile on Intel DevCloud for testing.

## Compiler options
Following https://community.intel.com/t5/Blogs/Tech-Innovation/Tools/The-Next-Chapter-for-the-Intel-Fortran-Compiler/post/1439297
the compiler options used are:

`-qopenmp -fopenmp-target-do-concurrent`

## Results
