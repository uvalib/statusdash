# set the definitions
INSTANCE=statusdash
NAMESPACE=uvadave

# build the image
docker build -t $NAMESPACE/$INSTANCE .

# return status
exit $?
