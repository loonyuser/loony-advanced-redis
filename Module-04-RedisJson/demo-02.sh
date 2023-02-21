
##############################################################################################################
https://redis.io/commands/json.arrappend/
https://redis.io/commands/json.arrinsert/
https://redis.io/commands/json.arrlen/
https://redis.io/commands/json.arrpop/
https://redis.io/commands/json.arrtrim/
##############################################################################################################
JSON Array operations
##############################################################################################################



## Let's create an array of moderators
JSON.SET users:mods $ '[{"Name": "Ivan", "Location": "Bulgaria"}]'

JSON.GET users:mods

## We get the array length after the insert (should be 2 here)
JSON.ARRAPPEND users:mods $ '{"Name": "Jack", "Location": "China"}'

JSON.GET users:mods

## May be easier to view the response
JSON.RESP users:mods

JSON.ARRAPPEND users:mods $ '{"Name": "Arturo", "Location": "Argentina"}' '{"Name": "Dayo", "Location": "Nigeria"}'

JSON.RESP users:mods

## We get the array length
JSON.ARRLEN users:mods

## Drop the first array element (at index 0)
## The popped element is returned
JSON.ARRPOP users:mods $ 0

JSON.RESP users:mods

## When no index is specified, the last element is popped
JSON.ARRPOP users:mods

JSON.RESP users:mods


## Insert elements at a specific index
JSON.ARRINSERT users:mods $ 0 '{"Name": "Dayo", "Location": "Nigeria"}'

JSON.RESP users:mods

## Insert with a negative index. This is relative to the last element of the array.
## This element becomes the second last 
JSON.ARRINSERT users:mods $ -1  '{"Name": "Ivan", "Location": "Bulgaria"}'

JSON.RESP users:mods


## Accessing elements from different arrays using MGET
## https://redis.io/commands/json.mget/
JSON.MGET users:mods users:admins $

JSON.MGET users:mods users:admins $[*].Name



##############################################################################################################
https://redis.io/commands/json.objkeys/
https://redis.io/commands/json.objlen/
##############################################################################################################
JSON Object Operation
##############################################################################################################

JSON.SET user:sheila $ '{ "Id":7, "Name": "Sheila", "Location":"India", "Department":["R&D", "Electronics", "Communication"], "Mail":{"Work":"sheila.work@loonycorn.com", "Personal":"sheila.home@loonycorn.com"}}'

JSON.RESP user:sheila

# Check object len
JSON.OBJLEN user:sheila 

## OBJLEN also applies to nestesd objects
JSON.OBJLEN user:sheila $.Mail

# Get all object Keys
JSON.OBJKEYS user:sheila

JSON.OBJKEYS user:sheila $.Mail

