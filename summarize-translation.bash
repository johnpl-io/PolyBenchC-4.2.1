#!/bin/bash

. ./common.bash

COLUMNS=${COLUMNS:="wizard wasm3 wamr jsc-int v8-liftoff jsc-bbq v8-turbofan jsc-omg"}

if [ $# != 0 ]; then
    BENCHMARKS=$@
fi

# Translation time
echo Translation time ratio
for engine in $COLUMNS; do
    printf "\t%s" $engine
done
printf "\n"

for BENCHMARK in $BENCHMARKS; do
    printf "%s" $BENCHMARK
    
    for engine in $COLUMNS; do
        DATAFILE=data/translation.$BENCHMARK.$engine.us
        AVG=$(awk -f average.awk $DATAFILE)
        printf "\t%s" $AVG
    done
    printf "\n"
done

# Translation bytes
echo Translation space ratio
for engine in $COLUMNS; do
    printf "\t%s" $engine
done
printf "\n"

for BENCHMARK in $BENCHMARKS; do
    printf "%s" $BENCHMARK
    
    for engine in $COLUMNS; do
        DATAFILE=data/translation.$BENCHMARK.$engine.bytes
        AVG=$(awk -f average.awk $DATAFILE)
        printf "\t%s" $AVG
    done
    printf "\n"
done
