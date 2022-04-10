#!/bin/bash

NORM='[0;00m'
GREEN='[0;32m'     ; LIGHTGREEN='[1;32m'
BROWN='[0;33m'     ; YELLOW='[1;33m'
PURPLE='[0;35m'    ; PINK='[1;35m'
BLACK='[0;30m'     ; DARKGRAY='[1;30m'
CYAN='[0;36m'      ; LIGHTCYAN='[1;36m'
BLUE='[0;34m'      ; LIGHTBLUE='[1;34m'
LIGHTGRAY='[0;37m' ; WHITE='[1;37m'
RED='[0;31m'       ; LIGHTRED='[1;31m'

LUCET_WASI=lucet-wasi
POLYBENCH=/project/titzer/PolyBenchC-4.2.1
ENGINES=$POLYBENCH/engines
V8=/project/titzer/v8/x64.release/d8
WIZENG_JVM=$HOME/wizard-engine/bin/wizeng.jvm
WIZENG_32=$HOME/wizard-engine/bin/wizeng.x86-linux
WIZENG_64=$HOME/wizard-engine/bin/wizeng.x86-64-linux
WIZENG=$HOME/wizard-engine/bin/wizeng.x86-64-linux
WIZENG_NT=$HOME/wizard-engine/bin/wizeng.x86-64-linux-tagless
WIZENG_V3=$HOME/wizard-engine/bin/wizeng.x86-linux
WIZENG_WAVE=$HOME/wizard-engine/bin/wizeng.wave
#WASM3=/project/titzer/wasm3/build/wasm3

WIZENG_VALID=$ENGINES/wizeng-valid
WIZENG_NO_SIDETABLE=$ENGINES/wizeng-no-sidetable
WASM3=$ENGINES/wasm3
WAMR_SLOW=$ENGINES/iwasm-slow
WAMR_CLASSIC=$ENGINES/iwasm-classic
WAMR_FAST=$ENGINES/iwasm-fast

JSC=/project/titzer/WebKit/WebKitBuild/Release/bin/jsc
SM=/project/titzer/spidermonkey/92.0b4/js
CHAKRA=/project/titzer/ChakraCore/bin/optimized/ch
CHAKRA_NOJIT=/project/titzer/ChakraCore/bin/no-jit/ch
WAMR=/project/titzer/wasm-micro-runtime/product-mini/platforms/linux/build/iwasm
# TODO: three builds of WAMR?

V8_TIER_LIFTOFF="--nowasm-tier-up"
V8_TIER_TURBOFAN="--nolift-off"
JSC_TIER_INT="--useOMGJIT=false --useBBQJIT=false"
JSC_TIER_OMG="--useOMGJIT=true --useBBQJIT=false"
JSC_TIER_BBQ="--useWasmLLInt=false --useOMGJIT=false --useBBQJIT=true"

COLORS=${COLORS:=true}
COUNT=${COUNT:=1}

if [ "$WIZENG_VARIANTS" = "" ]; then
    WIZENG_VARIANTS=$(cd /tmp/wizeng && ls wizeng*)
fi


#TODO deriche
#TODO floyd-warshall
#BENCHMARKS="floyd-warshall nussinov correlation covariance seidel-2d adi fdtd-2d jacobi-1d heat-3d jacobi-2d syr2k gemver gemm symm trmm syrk gesummv doitgen mvt atax 3mm 2mm bicg ludcmp cholesky lu trisolv gramschmidt durbin"
BENCHMARKS="nussinov correlation covariance seidel-2d adi fdtd-2d heat-3d jacobi-2d syr2k gemver gemm symm trmm syrk doitgen mvt atax 3mm 2mm bicg ludcmp cholesky lu gramschmidt"
