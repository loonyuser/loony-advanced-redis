
########################################################
https://redis.io/docs/stack/search/reference/aggregations/
########################################################
# Aggregation 
########################################################

FT.INFO idx:vg:multi_fields

# Group by and count distinct platforms
FT.AGGREGATE idx:vg:multi_fields "*" GROUPBY 1 @Platform

# Search and then aggregate
FT.AGGREGATE idx:vg:multi_fields sports GROUPBY 1 @Platform

# count no. of games for a given platform
FT.AGGREGATE idx:vg:multi_fields "*" GROUPBY 1 @Platform REDUCE COUNT 0 AS vg_count

# Count the number of distinct platforms
FT.AGGREGATE idx:vg:multi_fields "*" GROUPBY 0 REDUCE COUNT_DISTINCT 1 @Platform AS dist_platform

# We cannot group by or aggregate by a field which is not present in the index
## This will not work as Genre is not part of the index
FT.AGGREGATE idx:vg:multi_fields "*" GROUPBY 1 @Genre REDUCE COUNT 0 AS vg_count

## This will fail as the index does not include Global_Sales
FT.AGGREGATE idx:vg:multi_fields "*" GROUPBY 1 @Platform REDUCE SUM 1 @Global_Sales AS sum_sales 

## Create a new index which includes global sales
FT.CREATE idx:vg:agg_idx ON HASH PREFIX 1 vg_sales: SCHEMA Platform TAG Genre Text Global_Sales NUMERIC

## Re-attempt the queries we ran unsuccessfully against the multi_fields index
FT.AGGREGATE idx:vg:agg_idx "*" GROUPBY 1 @Genre REDUCE COUNT 0 AS vg_count

FT.AGGREGATE idx:vg:agg_idx "*" GROUPBY 1 @Platform REDUCE SUM 1 @Global_Sales AS sum_sales


# avg global sales by each platform
FT.AGGREGATE idx:vg:agg_idx "*" GROUPBY 1 @Platform REDUCE AVG 1 @Global_Sales AS sale_avg 

# Lowest sale made by each platform
FT.AGGREGATE idx:vg:agg_idx "*" GROUPBY 1 @Platform REDUCE MIN 1 @Global_Sales AS sale_min 

# Highest sales recorded by a game across all games in the map
FT.AGGREGATE idx:vg:agg_idx "*" GROUPBY 0 REDUCE MAX 1 @Global_Sales AS sale_max 



### Deleting indexes
FT._LIST

## Drop each of the indexes one by one
FT.DROPINDEX idx:vg:name
FT.DROPINDEX idx:vg:stop_word
FT.DROPINDEX idx:vg:num_idx_sort
FT.DROPINDEX idx:vg:multi_fields
FT.DROPINDEX idx:vg:num_idx
FT.DROPINDEX idx:vg:agg_idx
