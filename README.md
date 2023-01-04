# Testing Automatic Offload of `do concurrent`

Here we will port the nbody sample code in oneAPI HPC Toolkit located at
[`oneAPI-src/oneAPI-samples/DirectProgramming/DPC++/N-Body/Methods/Nbody`](https://github.com/oneapi-src/oneAPI-samples/tree/master/DirectProgramming/DPC%2B%2B/N-BodyMethods/Nbody) from `C++` to Fortran. 

We will make use of a `DO CONCURRENT` loop and compile on Intel DevCloud to test `ifx` offload to Intel GPUs.

## Compiler options
Following https://community.intel.com/t5/Blogs/Tech-Innovation/Tools/The-Next-Chapter-for-the-Intel-Fortran-Compiler/post/1439297
the compiler options used are:

`-qopenmp -fopenmp-target-do-concurrent`

## Building and running on a Intel GPU on Intel DevCloud
Assuming you have created an account on DevCloud, follow instructions similar to the steps in the [oneAPI Nbody sample](https://github.com/oneapi-src/oneAPI-samples/tree/master/DirectProgramming/DPC%2B%2B/N-BodyMethods/Nbody).

* Log in to the DevCloud: `ssh devcloud`
* Clone this github repository: `git clone https://github.com/sarojadhikari/nbody-ifx-do-concurrent.git` and change to the directory
* Get an interactive GPU node: `qsub  -I  -l nodes=1:gpu:ppn=2 -d .`
* Build and run using `make && ./nbody`

## Result
```
 Initialize Gravity Simulation
 nPart =        16000
 nSteps =           10
 dt =   0.1000000    
 -------------------------------------
           s   kenergy       time (s)
 -------------------------------------
           1  3.9802771E-03  6.0300000E-02
           2  3.9802729E-03  5.8100000E-02
           3  3.9802706E-03  5.8100000E-02
           4  3.9802766E-03  5.7999998E-02
           5  3.9802724E-03  5.8300000E-02
           6  3.9802594E-03  5.8200002E-02
           7  3.9802473E-03  5.8499999E-02
           8  3.9802557E-03  5.9099998E-02
           9  3.9802608E-03  5.9000000E-02
          10  3.9802436E-03  5.9200000E-02
 
 Total Time (s):   0.5872000    
 =============================
```
