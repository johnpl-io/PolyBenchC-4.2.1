#!/bin/bash

. ./common.bash

if [ $# != 0 ]; then
    BENCHMARKS=$@
fi

function run() {
    $COLORS && printf "$CYAN"

    if [ "$RUNS" -gt 1 ]; then
        printf "%s" "$1"
        shift
        $COLORS && printf "$NORM"
        printf "\n"
        i=0
        TIMEFORMAT="        %3R %3U %3S"
        while [ $i -lt "$RUNS" ]; do
            #    /usr/bin/time --quiet -o /tmp/$USER-bench-times -f "real=%E user=%Us mem=%M faults=%R exit=%x" $@ > /dev/null 2&> 1
            #    cat /tmp/$USER-bench-times
            time $@ > /dev/null 2&>1
            i=$(($i + 1))
        done
    else
        printf "%-12s " "$1"
        shift
        $COLORS && printf "$NORM"
        TIMEFORMAT="%3R %3U %3S"
        time $@ > /dev/null 2&>1
        i=$(($i + 1))
    fi
}

for f in $BENCHMARKS; do
    p=bin/$f
    w=$p.wasm
    echo ---- $f -----------

#    run "native" $p.native
#    run "lucet" $LUCET_WASI $p.lucet
#    run "spidermonkey" $SM run.js $w
#    run "v8-default" $V8 run.js -- $w
#    run "v8-liftoff" $V8 $V8_TIER_LIFTOFF run.js -- $w
#    run "v8-turbofan" $V8 $V8_TIER_TURBOFAN run.js -- $w
#    run "chakra" $CHAKRA run.js -args $w -endargs
#    run "chakra-int" $CHAKRA -nonative run.js -args $w -endargs
#    run "jsc-default" $JSC run.js -- $w

#    run "jsc-int" $JSC $JSC_TIER_INT run.js -- $w

    #    run wasm3 $WASM3 $w
    run wamr-int $WAMR $w
    for v in $WIZENG_VARIANTS; do
        run "$v" /tmp/wizeng/$v $w
    done

    # TODO: handle multiple wizeng configs

    # TODO: wavm

    # TODO: run "wizeng-jvm" cmd_wizeng_jvm $p

    # TODO: chakra int config is broken somehow

    # TODO: spidermonkey baseline

    # TODO: https://github.com/bytecodealliance/wasm-micro-runtime

    # TODO: https://github.com/Becavalier/TWVM

    # TODO: https://github.com/paritytech/wasmi

    # TODO: https://github.com/kanaka/wac

    # TODO: https://github.com/inikep/lzbench

    # TODO: https://github.com/bytecodealliance/sightglass
done
cd

