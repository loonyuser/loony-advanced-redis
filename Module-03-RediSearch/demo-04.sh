
########################################################
Tag search
########################################################

## Describe the multi_fields index and note that Platform is set as a TAG
##			field rather than text
FT.INFO idx:vg:multi_fields

## We search for "Wii" in the name, and this returns multiple games
##		whose platform is Wii
FT.SEARCH idx:vg:multi_fields @Name:wii RETURN 2 Name Platform

## However, we cannot perform a similar search on platform with the same syntax
## This returns nothing
FT.SEARCH idx:vg:multi_fields @Platform:wii RETURN 2 Name Platform

## When searching for tags, we enclose in curly braces
## We get back more games than when we searched for "wii" in the Name field
FT.SEARCH idx:vg:multi_fields @Platform:{wii} RETURN 2 Name Platform

## Wildcards also succeed on tags - we search for games on the PlayStation platform
FT.SEARCH idx:vg:multi_fields @Platform:{ps*} RETURN 2 Name Platform

## Search for games on PlayStation or Super Nintendo Entertainment System
FT.SEARCH idx:vg:multi_fields "@Platform:{ps*|SNES}" RETURN 2 Name Platform




########################################################
numeric search
########################################################

# create index for rank and global sales
## We can include numeric fields in any index, even ones with TEXT and TAG fields
FT.CREATE idx:vg:num_idx ON HASH PREFIX 1 vg_sales: SCHEMA Rank NUMERIC Global_Sales NUMERIC

FT._LIST


# search numeric field - the bounds specified are included when using only square brackets
FT.SEARCH idx:vg:num_idx "@Rank:[1 3]" RETURN 2 Name Rank


# exclusive search - use opening parenthesis to exclude the bound value from the search
FT.SEARCH idx:vg:num_idx "@Rank:[(1 3]" RETURN 2 Name Rank

FT.SEARCH idx:vg:num_idx "@Rank:[1 (3]" RETURN 2 Name Rank

# negate search - return games where the rank is not in the range [3 18]
FT.SEARCH idx:vg:num_idx "-@Rank:[3 18]" RETURN 2 Name Rank

## Greater than and less than operations can be performed by setting -inf or inf as the bounds
FT.SEARCH idx:vg:num_idx "@Rank:[-inf 3]" RETURN 2 Name Rank

FT.SEARCH idx:vg:num_idx "@Rank:[(18 inf]" RETURN 2 Name Rank

# floating point search
FT.SEARCH idx:vg:num_idx "@Global_Sales:[23.4 28.5]" RETURN 2 Name Global_Sales

## Sorting (this bypasses the ordering of results by scores)
FT.SEARCH idx:vg:num_idx "@Global_Sales:[23.4 28.5]" RETURN 2 Name Global_Sales SORTBY Global_Sales ASC

## We can also sort based on a different field than the one we searched on
FT.SEARCH idx:vg:num_idx "@Global_Sales:[23.4 28.5]" RETURN 3 Name Global_Sales Rank SORTBY Rank DESC

## We cannot sort by a non-indexed field
FT.SEARCH idx:vg:num_idx "@Global_Sales:[23.4 28.5]" RETURN 3 Name Global_Sales Rank SORTBY Name ASC



##### Sortable Indexes
### https://redis.io/docs/stack/search/reference/sorting/

## Create an index with one of the fields set to SORTABLE
FT.CREATE idx:vg:num_idx_sort ON HASH PREFIX 1 vg_sales: SCHEMA Rank NUMERIC Global_Sales NUMERIC SORTABLE


## Check the games with a minimum Global_Sales number of 30M ordered by Global_Sales
## The latency of such a search will be less when the index is already sorted on that field
FT.SEARCH idx:vg:num_idx_sort "@Global_Sales:[35 inf]" RETURN 3 Name Global_Sales Rank SORTBY Global_Sales DESC

## Note from the documentation:
## In the current implementation, when declaring a sortable field, its content gets copied 
##		into a special location in the index, for fast access on sorting. This means that 
##		making long fields sortable is very expensive, and you should be careful with it.

## We can still sort by Rank
FT.SEARCH idx:vg:num_idx_sort "@Global_Sales:[35 inf]" RETURN 3 Name Global_Sales Rank SORTBY Rank DESC

## We can set a limit on the sorted results - this gives us the top 4
## The 1st argument to LIMIT is an offset, the 2nd is the number of results
FT.SEARCH idx:vg:num_idx_sort "@Global_Sales:[30 inf]" RETURN 3 Name Global_Sales Rank SORTBY Global_Sales DESC LIMIT 0 2

## Arguments of 0 and 0 only gives us back the count of values in the results
FT.SEARCH idx:vg:num_idx_sort "@Global_Sales:[30 inf]" RETURN 3 Name Global_Sales Rank SORTBY Global_Sales DESC LIMIT 0 0



