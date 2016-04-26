# set the definitions
INSTANCE=statusdash
NAMESPACE=uvadave

# get the IP address of the docker engine
host_ip=$(ifconfig eth0 2>/dev/null | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')

# stop the running instance
docker stop $INSTANCE

# remove the instance
docker rm $INSTANCE

# remove the previously tagged version
docker rmi $NAMESPACE/$INSTANCE:current  

# tag the latest as the current
docker tag -f $NAMESPACE/$INSTANCE:latest $NAMESPACE/$INSTANCE:current

docker run -d -p $host_ip:8999:3030 --name $INSTANCE $NAMESPACE/$INSTANCE:latest

# return status
exit $?
