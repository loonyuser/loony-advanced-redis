
#############################################################################################################
Redis Json Search
#############################################################################################################
https://redis.io/docs/stack/search/indexing_json/
##############################################################################################################
####################################################
Indexing json object
####################################################

# Create json 
JSON.SET emp:1 $ '{ "Id":1, "Name": "Gerald", "Location":"Ghana", "Skills": ["Java", "Python", "AWS", "Azure"], "Major": "Computer Science" }'
JSON.SET emp:2 $ '{ "Id":2, "Name": "Naziya", "Location":"Bangladesh", "Skills": ["Python", "Redis", "MySQL", "PowerBI"], "Major": "Computer Engineering" }'
JSON.SET emp:3 $ '{ "Id":3, "Name": "Steffi", "Location":"New Zealand", "Skills": ["Java", "Redis", "PostgreSQL", "Tableau"], "Major": "Chemical Engineering"}'

JSON.MGET emp:1 emp:2 emp:3 $

# Create index on JSON data
## Note that we create tags out of the Skills array
FT.CREATE empIdx ON JSON PREFIX 1 emp: SCHEMA $.Id AS Id NUMERIC $.Name AS Name TEXT SORTABLE $.Skills.* AS Skills TAG $.Major AS Major TEXT

FT.INFO empIdx

####################################################
Search indexed json object
####################################################

FT.SEARCH empIdx "@Id:[1 2]"

FT.SEARCH empIdx "@Major:Computer*" RETURN 2 Name Major

## The argument to RETURN can be an attribute name or a JSON path when working with
##		JSON data 
##		(we need a JSON path here to view the full array, or just the first element gets printed)
FT.SEARCH empIdx "@Skills:{Redis|Tableau}" RETURN 2 Name $.Skills



