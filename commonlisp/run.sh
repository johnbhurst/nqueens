DIR=$(dirname $0)
if [[ $# -eq 3 ]]; then
  NAME=$1
  shift
else
  NAME=Queens
fi
FROM=$1
TO=$2

cd $DIR

buildapp --load-system queens --asdf-path . --entry queens:main --output queens
./queens $FROM $TO
