# Testing Automatic Offload of `do concurrent`

Here we will port the nbody sample code in oneAPI HPC Toolkit located at
[`oneAPI-samples/DirectProgramming/C++SYCL/N-BodyMethods/Nbody/`](https://github.com/oneapi-src/oneAPI-samples/tree/master/DirectProgramming/C%2B%2BSYCL/N-BodyMethods/Nbody) from `C++` to Fortran. 

See README2023.md and Makefile2023 for previous versions of the documents based on oneAPI 2023 which mostly discusses compiler options and steps for running on Intel DevCloud. 

In this document, we will focus on oneAPI 2024 and discuss steps to run `do concurrent` offload to a client intel GPU on Ubuntu operating system.

## Compiler options

Following https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2024-0/fopenmp-qopenmp-target-do-concurrent.html, 
the compiler options used are:

`-fopenmp-target-do-concurrent -fiopenmp -fopenmp-targets=spir64`

See also: https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2024-0/fopenmp-targets-qopenmp-targets.html

## Building and running
* Install intel oneAPI 2024 (base and HPC including fortran compiler)
* Assuming the installation is on the default location, set the environment: `source /opt/intel/oneapi/setvars.sh`
* Install runtime libraries following: https://dgpu-docs.intel.com/driver/client/overview.html

* Build and run using `make && ./nbody`

## Result
```
 ===============================
 Initialize Gravity Simulation
 nPart =        16000
 nSteps =           10
 dt =   0.1000000    
 -------------------------------------
           s   kenergy       time (s)
 -------------------------------------
           1  3.9802892E-03  0.2495000    
           2  3.9802892E-03  8.1000002E-03
           3  3.9802892E-03  7.3000002E-03
           4  3.9802892E-03  7.7000000E-03
           5  3.9802892E-03  7.4000000E-03
           6  3.9802892E-03  8.8000000E-03
           7  3.9802892E-03  7.4000000E-03
           8  3.9802892E-03  7.4000000E-03
           9  3.9802892E-03  7.1999999E-03
          10  3.9802892E-03  7.8999996E-03
 
 Total Time (s):   0.3187000    
 =============================

```

To check that GPU is being used install `intel-gpu-tools` and check the output of `intel_gpu_top` while the code is running.
