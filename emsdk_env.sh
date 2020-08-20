# This script is sourced by the user and uses
# their shell.
#
# This script tries to find its location but
# this does not work in every shell.
#
# It is known to work in bash, zsh and ksh
#
# Do not execute this script without sourcing,
# because it won't have any effect then.
# That is, always run this script with
#
#     . /path/to/emsdk_env.sh
#
# or
#
#     source /path/to/emsdk_env.sh
#
# instead of just plainly running with
#
#     ./emsdk_env.sh
#
# which won't have any effect.

CURRENT_SCRIPT=
DIR="."

if [ -n "$BASH_SOURCE" ]; then
  CURRENT_SCRIPT="$BASH_SOURCE"
elif [ -n "$ZSH_VERSION" ]; then
  CURRENT_SCRIPT="${(%):-%x}"
elif [ -n "$KSH_VERSION" ]; then
  CURRENT_SCRIPT=${.sh.file}
fi

if [ -n "$CURRENT_SCRIPT" ]; then
  DIR=$(dirname "$CURRENT_SCRIPT")
  # now work out actual DIR if this is part of a symlink
  if [ -h "$CURRENT_SCRIPT" ]; then
    SYMDIR=$(dirname "$(ls -l "$CURRENT_SCRIPT" | sed -n "s/.*-> //p")")
    if [ -z "$SYMDIR" ]; then
      SYMDIR="."
    fi
    FULLDIR="$DIR/$SYMDIR"
    DIR=$(cd "$FULLDIR" > /dev/null 2>&1; /bin/pwd)
    unset SYMDIR
    unset FULLDIR
  fi
fi

if [ ! -f "$DIR/emsdk.py" ]; then
  echo "Error: unable to determine 'emsdk' directory. Perhaps you are using a shell or" 1>&2
  echo "       environment that this script does not support." 1>&2
  echo 1>&2
  echo "A possible solution is to source this script while in the 'emsdk' directory." 1>&2
  echo 1>&2
  unset DIR
  return
fi

# Force emsdk to use bash syntax so that this works in windows + bash too
eval `EMSDK_BASH=1 $DIR/emsdk construct_env`
unset CURRENT_SCRIPT
unset DIR
