
########################################################
https://redis.io/docs/stack/search/reference/stopwords/
########################################################
Stop-word
########################################################


## When no list of stopwords is specified, RediSearch uses a default stopwords list
##		when an index is created with FT.CREATE
## Let's re-examine one of the indexes we created

## This returns values as duck is a valid search term
## Note that all descriptions include at least one occurrence of "the"
FT.SEARCH idx:vg:multi_fields @Description:duck RETURN 2 Name Description

## Searching for "the", which is a stopword, yields no results
FT.SEARCH idx:vg:multi_fields @Description:the RETURN 2 Name Description

## This returns games which match duck or racing in the description
FT.SEARCH idx:vg:multi_fields @Description:duck|racing RETURN 2 Name Description

## Searches for a bunch of stop words will not return anything
FT.SEARCH idx:vg:multi_fields @Description:for|is|and|by RETURN 2 Name Description

# Create an index with custom stop words - let's add "duck" and "racing" as stopwords
FT.CREATE idx:vg:stop_word STOPWORDS 2 duck racing ON HASH PREFIX 1 vg_sales: SCHEMA Description TEXT 

## Note at the bottom that there is a property called stopwords_list
FT.INFO idx:vg:stop_word

## Searching for words that are not stop-words works just fine
FT.SEARCH idx:vg:stop_word @Description:monster|puzzle RETURN 2 Name Description

## But the same query which worked on the multi_fields index does not return results here
FT.SEARCH idx:vg:stop_word @Description:duck|racing RETURN 2 Name Description




########################################################
Fuzzy matches 
########################################################


## There are a handful of results when we search for "sports"
FT.SEARCH idx:vg:name sports RETURN 2 Name Year

## But none when we search for "spots"
FT.SEARCH idx:vg:name spots RETURN 2 Name Year

## Enclosing the search term in a single set of % returns matches for words which are 
##		a Levenshtein distance (LD) of 1 from it
## https://en.wikipedia.org/wiki/Levenshtein_distance
FT.SEARCH idx:vg:name %spots% RETURN 2 Name Year

## There is no fuzzy match for "thrift" within an LD of 1
FT.SEARCH idx:vg:name %thrift% RETURN 2 Name Year

## Include a second set of % to search up to an LD of 2 (max LD allowed is 3)
## There's clearly not much separating thrift and theft
FT.SEARCH idx:vg:name %%thrift%% RETURN 2 Name Year





