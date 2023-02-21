
##############################################################################################################
https://redis.io/docs/reference/optimization/benchmarks/
https://www.digitalocean.com/community/tutorials/how-to-perform-redis-benchmark-tests
##############################################################################################################
Benchmarking on local host
##############################################################################################################


-------------------- Set up before recording (behind the scenes)

# Have two terminal tabs open 
# One with the terminal window, the second with you logged in to the redis-cli


-------------------- Start recording


# Make sure the Redis server is running (terminal window first tab)
brew services restart redis

# Show that you are logged into the CLI (second tab)



# redis-benchmark help command
redis-benchmark --help


# Run redis benchmark - defaults to localhost:6379
## We get to see a comprehensive distribution of latencies for different commands (LPUSH, MSET etc.)
# Once benchmarking is complete make sure you scroll from the top and show the results
redis-benchmark


# Run redis benchmark by explicitly specifying the host and port
# Once benchmarking is complete make sure you scroll from the top and show the results
redis-benchmark -h 127.0.0.1 -p 6379



# Display output in CSV format (--csv)
redis-benchmark --csv

## A more condensed output is generated - a single line for each command
redis-benchmark -q


# Perform test for selected operations only (-t)
redis-benchmark -q -t SADD,SPOP,ZADD,ZPOPMIN 

# Alter the request count (-n)
## Set the number of requests to 500k instead of 100k which is the default
## Don't forget to scroll and show
redis-benchmark -t SET,GET -n 500000


# Perform test on specified command only using a Lua script
## https://redis.io/docs/manual/programmability/eval-intro/
## The syntax is:
## redis-benchmark eval <script> <num_keys> <key_1> <val_1> ... <key_n> <val_n> 
redis-benchmark \
	eval "return redis.call('SET', KEYS[1], ARGV[1])" \
	1 company Loonycorn

## The key does get written (or overwritten), which can be confirmed
## Switch to the tab where the redis-cli is running and check the value of company
GET company




