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
V8=/project/titzer/v8/v8/out/x64.release/d8
WIZENG=$HOME/wizard-engine/bin/wizeng.x86-64-linux
JSC=/project/titzer/WebKit/WebKitBuild/Release/bin/jsc
SM=/project/titzer/spidermonkey/92.0b4/js
CHAKRA=/project/titzer/ChakraCore/out/Release/bin/ChakraCore/ch

COLORS=${COLORS:=true}

function cmd_native() {
    echo $1.native
}

function cmd_lucet() {
    echo $LUCET_WASI $1.lucet
}

function cmd_v8_liftoff() {
    echo $V8 --nowasm-tier-up run.js -- $1.wasm
}

function cmd_v8_turbofan() {
    echo $V8 --nolift-off run.js -- $1.wasm
}

function cmd_v8_default() {
    echo $V8 run.js -- $1.wasm
}

function cmd_wizeng() {
    echo $WIZENG $1.wasm
}

function cmd_jsc_int() {
    echo $JSC --useOMGJIT=false --useBBQJIT=false run.js -- $1.wasm
}

function cmd_jsc_default() {
    echo $JSC run.js -- $1.wasm
}

function cmd_sm_default() {
    echo $SM run.js $1.wasm
}

function cmd_chakra_default() {
    echo $CHAKRA run.js -args $1.wasm -endargs
}

BENCHMARKS="floyd-warshall nussinov deriche correlation covariance seidel-2d adi fdtd-2d jacobi-1d heat-3d jacobi-2d syr2k gemver gemm symm trmm syrk gesummv doitgen mvt atax 3mm 2mm bicg ludcmp cholesky lu trisolv gramschmidt durbin"

if [ $# != 0 ]; then
    BENCHMARKS=$@
fi

COUNT=1

function run() {
    $COLORS && printf "$CYAN"

    if [ "$COUNT" -gt 1 ]; then
        printf "%s" "$1"
        $COLORS && printf "$NORM"
        shift
        printf "\n"
        i=0
        TIMEFORMAT="        %3R %3U %3S"
        while [ $i -lt "$COUNT" ]; do
            #    /usr/bin/time --quiet -o /tmp/$USER-bench-times -f "real=%E user=%Us mem=%M faults=%R exit=%x" $@ > /dev/null 2&> 1
            #    cat /tmp/$USER-bench-times
            time $@ > /dev/null 2&>1
            i=$(($i + 1))
        done
    else
        printf "%-12s " "$1"
        $COLORS && printf "$NORM"
        shift
        TIMEFORMAT="%3R %3U %3S"
        time $@ > /dev/null 2&>1
        i=$(($i + 1))
    fi
}

for f in $BENCHMARKS; do
    p=bin/$f
    echo ---- $f -----------

    run "native" $(cmd_native $p)
    run "lucet" $(cmd_lucet $p)
    run "spidermonkey" $(cmd_sm_default $p)
    run "v8-default" $(cmd_v8_default $p)
    run "v8-liftoff" $(cmd_v8_liftoff $p)
    run "v8-turbofan" $(cmd_v8_turbofan $p)
    run "chakra" $(cmd_chakra_default $p)
    run "jsc-default" $(cmd_jsc_default $p)
    run "jsc-int" $(cmd_jsc_int $p)
    run "wizeng" $(cmd_wizeng $p)

    # TODO: handle multiple wizeng configs

    # TODO: wavm
    
    # TODO: run "wizeng-jvm" cmd_wizeng_jvm $p

    # TODO: spidermonkey baseline, wasm3, chakra int

    # TODO: https://github.com/bytecodealliance/wasm-micro-runtime

    # TODO: https://github.com/Becavalier/TWVM

    # TODO: https://github.com/paritytech/wasmi

    # TODO: https://github.com/kanaka/wac

    # TODO: https://github.com/inikep/lzbench

    # TODO: https://github.com/bytecodealliance/sightglass
done
cd 
