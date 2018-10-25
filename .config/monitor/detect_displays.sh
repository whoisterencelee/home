#!/bin/sh

XRANDR="xrandr"

VOUTS=$(${XRANDR}|awk 'BEGIN {printf("(")} /^\S.*connected/{printf("[%s]=%s ", $1, $2)} END{printf(")")}')

#XPOS=0
#YPOS=0
#POS="${XPOS}x${YPOS}"

POS=([X]=0 [Y]=0)

xrandr_params_for() {
  if [ "${2}" == 'connected' ]
  then

    MODE= ${XRANDR} | sed -n '/^'${1}' /,/^[^ ]/p' | sed -n '/^ /p' | sort -n | tail -n 1 | sed -e 's/   \(.*\)  .*/\1/g'

    echo MODE is ${MODE}
    #CMD="${XRANDR} --output ${1} --mode ${MODE} --pos ${POS[X]}x${POS[Y]}"
    CMD="${XRANDR} --output ${1} --mode $MODE"
    echo CMD is ${CMD}
    return 0
  else
    CMD="${XRANDR} --output ${1} --off"
    return 1
  fi
}

for VOUT in ${!VOUTS[*]}
do
  echo ${VOUT}
  xrandr_params_for ${VOUT} ${VOUTS[${VOUT}]}
done
set -x
${CMD}
set +x
