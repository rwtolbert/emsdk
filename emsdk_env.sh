# This script is sourced by the user and uses
# their shell.
#
# This script tries to find its location but
# this does not work in every shell.
#
# It is known to work in bash and zsh
#
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
  unset S
  unset D1
  unset DLINK
  unset READLINK
  if [ ! -f "$DIR/emsdk.py" ]; then
    echo "Error: unable to determine 'emsdk' directory. Perhaps you are using a shell or" 1>&2
    echo "       environment that this script does not support." 1>&2
    echo "One possible solution is to source this script while in the 'emsdk' directory." 1>&2
    echo 1>&2
    unset DIR
    return
  fi
else
  DIR="$(dirname "$BASH_SOURCE")"
fi

# Force emsdk to use bash syntax so that this works in windows + bash too
eval `EMSDK_BASH=1 $DIR/emsdk construct_env`
unset DIR
