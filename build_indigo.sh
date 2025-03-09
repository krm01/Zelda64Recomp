#!/bin/bash

### In PowerShell

# choco install cmake, ninja, make, clang
# Make sure they're all on PATH

### In WSL

# Install git lfs
# git clone --recurse-submodules ...
# add baserom_original.z64 into lib/indigo

# Build N64Recomp for windows, since it's used in the build process as well
# rm -r lib/N64Recomp/build
# cd lib/N64Recomp
# mkdir -p build
# cd build
# cmake.exe ..
# cmake.exe --build .
# cd ../../../

# chmod +x N64Recomp.exe
# chmod +x RSPRecomp.exe


# Ensure clean
rm -r out build RecompiledFuncs RecompiledPatches indigo.toml aspMain.toml njpgdspMain.toml rsp/aspMain.cpp rsp/aspMain.text.bin rsp/njpgdspMain.cpp rsp/njpgdspMain.text.bin

# Produce an N64 ROM to recompile
# build indigo with `make release RECOMP=1` and then run copy-to-recomp.sh from indigo repo

# activate the python venv
. .venv/bin/activate

# Generate recomp configuration from ELF file
python3 gen_recomp.py lib/indigo/zelda_ocarina_mq_dbg.elf

# Run N64Recomp on the config
./N64Recomp.exe indigo.toml

# Run RSPRecomp on the ucode configs
./RSPRecomp.exe aspMain.toml
./RSPRecomp.exe njpgdspMain.toml

# TODO make this actually work
# mkdir -p build
# cd build
# cmake.exe .. -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -G Ninja
# cmake.exe --build .
