# This script is sourced by the user and uses
# their shell. Try not to use bashisms.

# Do not execute this script without sourcing,
# because it won't have any effect then.
# That is, always run this script with
#
#     . ./emsdk_env.sh
# or
#     source ./emsdk_env.sh
#
# instead of just plainly running with
#
#     ./emsdk_env.sh
#
# which won't have any effect.
if [ -z "$BASH_SOURCE" ]; then
  D1=`dirname $0`
  DIR=`cd $D1 && pwd`
  S=`basename $0`

  READLINK=`which readlink`
  if [ -x "$READLINK" ] ; then
    DLINK=`readlink $D1/$S`
    if [ "$DLINK" != "" ] ; then
      D1=`dirname $DLINK`
      DIR=`cd $D1 && pwd`
    fi
  fi
  if [ ! -f "$DIR/emsdk.py" ]; then
    echo "error: You must be in the same directory as emsdk_env.sh when sourcing it (or switch to the bash shell)" 1>&2
  fi
  unset S
  unset D1
  unset DLINK
  unset READLINK
else
  DIR="$(dirname "$BASH_SOURCE")"
fi

# Force emsdk to use bash syntax so that this works in windows + bash too
eval `EMSDK_BASH=1 $DIR/emsdk construct_env`
unset DIR
