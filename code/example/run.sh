#!/bin/sh

read name

clang -Dcl_clang_storage_class_specifiers -isystem libclc/generic/include -include clc/clc.h -target r600 -xcl $name.cl -emit-llvm -S -o $name.ll

#llvm-link libclc/built_libs/nvptx64--nvidiacl.bc $name.ll -o $name.bc
#opt -instnamer -mem2reg -vssa $name.ll -o $name.ll

opt -load /home/zeke/llvm-3.4/Release+Asserts/lib/JSNCFG3.so -cfg_4 < $name.ll >/dev/null
