#!/bin/sh

if [ $# -ne 1 ]
then
  echo "Usage: `basename $0` TEXTFILE"
  exit $E_BADARGS
fi

OBT=$(dirname $0)
if [ -x "$(command -v python3)" ]
  then PYTHON="python3"
elif [ -x "$(command -v python)" ]
  then PYTHON="python"
elif [ -x "$(command -v python2)" ]
  then PYTHON="python2"
  else { echo >&2 "No python command (python3, python2 or python) found.  Aborting."; exit 1; }
fi

"$PYTHON" "$OBT"/mtag/mtag.py -wxml < $1				\
    | vislcg3		\
	      --grammar "$OBT"/cg/bm_morf.cg	\
	      --no-pass-origin			\
	      --show-end-tags			\
    | perl -ne 'print if /\S/'
