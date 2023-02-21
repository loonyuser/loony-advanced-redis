
##############################################################################################################
https://redis.io/commands/ft.create/
https://redis.io/commands/ft.info/
https://redis.io/commands/ft._list/
https://redis.io/docs/stack/search/quick_start/#create-an-index
##############################################################################################################
Create, List, Describe and use an index
##############################################################################################################

# Behind the scenes set it up so you have two terminal tabs open
# One tab with the redis-cli
# One tab with the 

# In the ~/advancedredis directory show the file that you have (only one file vgsales.txt, please remove all the previous files)

ls

## View the vgsales.txt file in Sublime Text or a similar text editor

## Each line is simply an HSET command where data for a video game is added in the form of a map

### in bash ###
# upload data 


cat vgsales.txt | redis-cli --pipe



### Switch to the Redis CLI redis-cli ###
# Read a hash
## https://redis.io/commands/hgetall/
HGETALL vg_sales:000

# Create an index on a single field - Name
FT.CREATE idx:vg:name ON HASH PREFIX 1 vg_sales: SCHEMA Name TEXT 

# get index info
FT.INFO idx:vg:name


## IMPORTANT: Before running ANY search command clear the screen and hit many "enters" so you have some separation from the previous command. Try to do this wherever possible


## Search the indexed field for the keyword "sports"
## This will return the details of 3 different games
FT.SEARCH idx:vg:name sports


## Note that the clear command can be used to clear the screen
clear


---------------------------------------------------


# index multiple fields
FT.CREATE idx:vg:multi_fields ON HASH PREFIX 1 vg_sales: SCHEMA Name TEXT Description TEXT WEIGHT 5.0 Platform TAG 


## List all indexes
FT._LIST

## Search for racing games in the index
## The two entries in the result are for Mario Kart, but different editions
##		released in different years
FT.SEARCH idx:vg:multi_fields racing

## We do the equivalent of the SELECT clause by specifying the fields to be returned
## We need to specify the number of fields to return followed by the field names
FT.SEARCH idx:vg:multi_fields racing RETURN 3 Name Year Description

## In the above results note that the 2005 edition of Mario Kart does not 
##		have "race" mentioned anywhere directly, but many mentions of racing
## If we search for "race", the game still shows up in the results though
##		the order of the two games changes
FT.SEARCH idx:vg:multi_fields race RETURN 3 Name Year Description


## The WITHSCORES argument returns the scores corresponding to each game
FT.SEARCH idx:vg:multi_fields race RETURN 2 Name Year WITHSCORES

## Using EXPLAINSCORE alongside WITHSCORE gives us details about how the score is calculated
FT.SEARCH idx:vg:multi_fields race RETURN 2 Name Year WITHSCORES EXPLAINSCORE

## Get the score and explanation for the "racing" search term (the scores are much higher)
FT.SEARCH idx:vg:multi_fields racing RETURN 2 Name Year WITHSCORES EXPLAINSCORE

## We'll explore searches in more detail later on


---------------------------------------------------

# Search for Xbox games
FT.SEARCH idx:vg:multi_fields xbox RETURN 3 Name Year Description

# There should be only one result


# Now add two more games to Redis (they will be automatically indexed)

# Game 1
HSET vg_sales:012 Rank 13 Name "Pokemon Gold/Pokemon Silver" Platform GB Year 1999 Genre "Role Playing" Publisher Nintendo Global_Sales 23.1 Description "Pokémon Gold Version and Pokémon Silver Version are 1999 role-playing video games developed by Game Freak and published by Nintendo for the Game Boy Color. They are the first installments in the second generation of the Pokémon video game series. They were released in Japan in 1999, Australia and North America in 2000, and Europe in 2001. Pokémon Crystal, an enhanced version, was released a year later in each region. In 2009, on the 10th anniversary of Gold and Silver, remakes titled Pokémon HeartGold and SoulSilver were released for the Nintendo DS."


# Game 2
HSET vg_sales:017 Rank 18 Name "Grand Theft Auto: San Andreas" Platform PS2 Year 2004 Genre Action Publisher "Take-Two Interactive" Global_Sales 20.81 Description "Grand Theft Auto: San Andreas is a 2004 action-adventure game developed by Rockstar North and published by Rockstar Games. It is the fifth main entry in the Grand Theft Auto series, following 2002's Grand Theft Auto: Vice City, and the seventh installment overall. It was released in October 2004 for the PlayStation 2, in June 2005 for Microsoft Windows and Xbox, and in November 2010 for Mac OS X. The game is set within an open world environment that players can explore and interact with at their leisure. The story follows former gangster Carl 'CJ' Johnson, who returns home following his mother's murder and is drawn back into his former gang and a life of crime while clashing with corrupt authorities and powerful criminals. "



# Search for Xbox again (now you will get 2 results)
FT.SEARCH idx:vg:multi_fields xbox RETURN 3 Name Year Description












