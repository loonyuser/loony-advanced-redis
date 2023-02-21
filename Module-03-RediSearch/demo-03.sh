
##############################################################################################################
https://redis.io/commands/ft.search/
https://redis.io/docs/stack/search/reference/query_syntax/
##############################################################################################################

text search
########################################################

## View the indexes
FT._LIST


## Return only specific fields in the results - equivalent of SELECT
## The RETURN keyword is followed by the count of fields to return (5 results)
FT.SEARCH idx:vg:name wii RETURN 2 Name Year

# using a wildcard
FT.SEARCH idx:vg:name wi* RETURN 2 Name Year

# match multiple words - the equivalent of OR is the pipe (|)
FT.SEARCH idx:vg:name sports|auto RETURN 2 Name Year

## To perform an equivalent of an AND operation, we can specify the search terms 
##		separated by one of a number of valid separators
## https://redis.io/docs/stack/search/reference/escaping/
FT.SEARCH idx:vg:name duck,sports RETURN 2 Name Year

## & is another character which can be used to tokenize search terms
FT.SEARCH idx:vg:name grand&auto&andreas RETURN 2 Name Year

# The search term is wrapped in quotes if we want to include spaces
FT.SEARCH idx:vg:name "grand auto andreas" RETURN 2 Name Year



## Search for sports
FT.SEARCH idx:vg:name sports RETURN 2 Name Year

## Search for anything which does NOT contain sports
FT.SEARCH idx:vg:name -sports RETURN 2 Name Year

## Search for sports, but not duck (two results)
FT.SEARCH idx:vg:name sports&-duck RETURN 2 Name Year



## This returns 2 Grand Theft Auto games and Kinect Adventures
## The weight of the Description field in the index is 5.0, so the 
##		Grand Theft Auto games get a higher weight than Kinect Adventures
FT.SEARCH idx:vg:multi_fields adventure RETURN 4 Name Year Description Platform

## Search within a specific field of the index
## This only returns Kinect Adventures
FT.SEARCH idx:vg:multi_fields @Name:adventure RETURN 4 Name Year Description Platform

## Search multiple keywords in multiple fields
## Effectively an AND operation in this case
FT.SEARCH idx:vg:multi_fields "@Description:princess @Name:world" RETURN 4 Name Year Description Platform

## Search for single term in multiple fields using INFIELDS
FT.SEARCH idx:vg:multi_fields duck INFIELDS 2 Name Description RETURN 4 Name Year Description Platform



## We can choose to summarize Description instead
## Excerpts around the occurrences of the matched term are included in the summary
## This can be seen in the description of Kinect Adventures which has two occurrences of "adventure"
FT.SEARCH idx:vg:multi_fields adventure RETURN 3 Name Description Platform SUMMARIZE FIELDS 1 Description


## Highlight the matching terms in the results
## This is useful when formatting the results to be displayed in a web app where the
##			search is initiated. By default the highlighting is <b> HTML tags
FT.SEARCH idx:vg:multi_fields adventure RETURN 3 Name Description Platform SUMMARIZE FIELDS 1 Description HIGHLIGHT FIELDS 2 Name Description


