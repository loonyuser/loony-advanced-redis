

##############################################################################################################
https://redis.io/commands/json.strappend/
https://redis.io/commands/json.strlen/
##############################################################################################################
String operations
##############################################################################################################


JSON.SET employees $ '[ { "Id":1, "Name": "Gerald", "Salary": 70000}, { "Id":2, "Name": "Naziya", "Salary": 80000 }, { "Id":3, "Name": "Steffi", "Salary": 640000 } ]'

JSON.RESP employees


JSON.GET employees $[0].Name

## The value returned is the length of the modified string
JSON.STRAPPEND employees $[0].Name '" Odoi"'

JSON.GET employees $[0].Name

## Append to all matching strings
JSON.STRAPPEND employees $..Name '" (Admin)"'

JSON.RESP employees $..Name

# Check string length
JSON.STRLEN employees $[2].Name

JSON.STRLEN employees $..Name



##############################################################################################################
https://redis.io/commands/json.numincrby/
https://redis.io/commands/json.nummultby/
##############################################################################################################
Numeric operations
##############################################################################################################

# increase value by 2
JSON.GET employees $[2].Salary

## This returns the updated attribute value
JSON.NUMINCRBY employees $[2].Salary 2000

JSON.RESP employees $[2]

## Give one employee a 5% raise
JSON.RESP employees $[0]

JSON.NUMMULTBY employees $[0].Salary 1.05

JSON.RESP employees $[0]



