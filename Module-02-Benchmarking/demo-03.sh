#######################################################
Benchmarking on remote host
#######################################################

## Redis Benchmark docs for reference
## https://redis.io/docs/management/optimization/benchmarks/

## Set up environment variables for the IP address of redis India and redis USA
REDIS_INDIA=34.93.134.235
REDIS_USA=34.171.204.179

echo $REDIS_INDIA
echo $REDIS_USA



# Run redis benchmark against the India and US-based VMs
## The VM that is closer performs much better
redis-benchmark -h $REDIS_INDIA -p 6379 \
	-n 10000 -t SET,GET \
	-a 'redis-instance-india-password'
redis-benchmark -h $REDIS_USA -p 6379 \
	-n 10000 -t SET,GET \
	-a 'redis-instance-usa-password'



# Alter the clients count (-c) (the number of parallel connections)
## The default for c is 50
redis-benchmark -c 100 \
	-h $REDIS_INDIA -p 6379 -n 10000 -t SET,GET\
	-a 'redis-instance-india-password'
redis-benchmark -c 100 \
	-h $REDIS_USA -p 6379 -n 10000 -t SET,GET\
	-a 'redis-instance-usa-password'


## IMPORTANT: In this pair of tests, run both on the same screen 
# Perform test with random keys
redis-benchmark -r 1000 \
	-h $REDIS_INDIA -p 6379 -n 10000 -t SET,GET \
	-a 'redis-instance-india-password' --csv
redis-benchmark -r 1000 \
	-h $REDIS_USA -p 6379 -n 10000 -t SET,GET \
	-a 'redis-instance-usa-password' --csv


# Alter the size of value in bytes (-d)
redis-benchmark -d 100 \
	-h $REDIS_INDIA -p 6379 -n 10000 -t SET,GET \
	-a 'redis-instance-india-password'
redis-benchmark -d 100 \
	-h $REDIS_USA -p 6379 -n 10000 -t SET,GET \
	-a 'redis-instance-usa-password'


# pipeline (compare the RPS with and without pipelining, with pipelining is much better)
redis-benchmark -P 50 \
	-h $REDIS_INDIA -p 6379 -n 10000 -t SET,GET \
	-a 'redis-instance-india-password'
redis-benchmark -P 50 \
	-h $REDIS_USA -p 6379 -n 10000 -t SET,GET \
	-a 'redis-instance-usa-password'


# Run the test in loop
## You'll need to hit Ctrl+C to quit
redis-benchmark -l \
	-h $REDIS_INDIA -p 6379 -q -n 1 -t SET,GET \
	-a 'redis-instance-india-password' --csv
redis-benchmark -l \
	-h $REDIS_USA -p 6379 -q -n 1 -t SET,GET \
	-a 'redis-instance-usa-password' --csv


# Run the with multiple threads
## In the output, note the property "multi-thread: yes"
## Also set the number of requests to 20
redis-benchmark --threads 3 \
	-h $REDIS_INDIA -p 6379 -n 10000 -t SET,GET \
	-a 'redis-instance-india-password'
redis-benchmark --threads 3 \
	-h $REDIS_USA -p 6379 -n 10000 -t SET,GET \
	-a 'redis-instance-usa-password'

