#############################################################################################################
Redis json
##############################################################################################################
https://redis.io/commands/json.set/
https://redis.io/commands/json.get/
https://redis.io/commands/json.mget/
https://redis.io/commands/json.type/
https://redis.io/commands/json.del/
##############################################################################################################
Json SET, GET, MGET, TYPE, DEL
##############################################################################################################

## VERY IMPORTANT recording note - hit enter to leave a line between each query (easier for annotations and to see results)


## The example we use includes different kinds of users on some platform
## Users may be admins, moderators etc.

# Set an object 
## The arguments to JSON.SET are the key, the path, and the value
## $ represents the root path which is the default for new keys
## We'll explore different paths a little later
JSON.SET user_001 $ '{ "Id":1, "Name": "Gerald", "Location":"Ghana", "Active":true }'

## Check the type of the newly added key-value
JSON.TYPE user_001

## We can check the types of the attributes of JSON data
## 
JSON.TYPE user_001 $.Id
JSON.TYPE user_001 $.Name
JSON.TYPE user_001 $.Active

# get an json object
JSON.GET user_001

# get a specific field of an object
JSON.GET user_001 $.Id

# This will fail return a blank due to case-sensitivity
JSON.GET user_001 $.id

# get multiple fields
JSON.GET user_001 $.Id $.Name

## View the JSON Data in Redis serialization protocol (RESP) specification
## https://redis.io/docs/reference/protocol-spec/
## Use JSON.RESP instead of JSON.GET
JSON.RESP user_001



# Delete an attribute
JSON.DEL user_001 $.Name
JSON.GET user_001

# Delete the object
JSON.DEL user_001
JSON.GET user_001


# Set an array
JSON.SET users $ '[ { "Id":1, "Name": "Gerald", "Location":"Ghana" }, { "Id":2, "Name": "Naziya", "Location":"Bangladesh" }, null, true ]'
JSON.TYPE users

# Get the array
JSON.GET users
JSON.RESP users 

# Get an array element - both syntaxes are equivalent here
JSON.GET users $.[0]

# Access elements from the end
JSON.GET users $[-1]
JSON.GET users $[-3]

# Get an element of the nested object
JSON.GET users $.[0].Name
JSON.GET users $.[0].Name $.[1].Name

## Specifying a path to get to attributes in the nested objects
JSON.GET users $.[*].Name
JSON.GET users $..Name


# Delete an attribute from a nested obj
JSON.DEL users $.[1].Name
JSON.GET users $.[1]

# Delete an array element
JSON.DEL users $.[0]
JSON.GET users

# Delete an array
JSON.DEL users
JSON.GET users 


# Get child elements
JSON.SET users:admins $ '[ { "Name": "Gerald", "Mail":{"Work":"gerald.work@loonycorn.com", "Personal":"gerald.home@loonycorn.com"}}, { "Name": "Naziya", "Mail":{"Work":"naz.work@loonycorn.com", "Personal":"naz.home@loonycorn.com"}}, { "Name": "Steffi", "Contact":{"Phone": {"Work":"555-WORK", "Personal":"555-HOME"}, "Email": {"Work": "steffi.work@loonycorn.com"}}}]'

JSON.RESP users:admins

## Get Personal mails by setting a path 
## For the JSON path syntax, refer to :
##		https://redis.io/docs/stack/json/path/#jsonpath-syntax
JSON.GET users:admins $.[*].Mail.Personal

## Recursively search for all attributes named "Personal"
## Details from Mail.Personal, Contact.Phone.Personal, and even Contact.Email.Personal show up
JSON.GET users:admins $..Personal

## Using RESP
JSON.RESP users:admins $..Personal




