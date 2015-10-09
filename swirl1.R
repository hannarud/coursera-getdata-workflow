library(dplyr)

# Exploring dplyr

# We'll focus on data frames, but everything you learn will apply equally to other formats (data tables, databases and multidimensional arrays)

# We'll be working with the log from July 8, 2014, which contains information on roughly 225,000 package downloads
# I've created a variable called path2csv, which contains the full file path to the dataset. Call read.csv()

mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)
tail(mydf)

library(dplyr)
packageVersion("dplyr")

cran <- tbl_df(mydf)
rm("mydf") # Removing the original data frame not to confuse us
cran

select(cran, ip_id, package, country)
select(cran, r_arch:country) # select all columns starting from r_arch and ending with country.
select(cran, country:r_arch) # select the same columns in reverse order
select(cran, -time) # we can also specify the columns we want to throw away. Here we omit the time column.
select(cran, -(X:size)) #omit all columns X:size

filter(cran, package == "swirl")
filter(cran, r_version == "3.1.1", country == "US") # 'and' condition
filter(cran, r_version <= "3.0.2", country == "IN")
filter(cran, country == "US" | country == "IN") # 'or' condition
filter(cran, !is.na(r_version))

cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id))
arrange(cran2, country, desc(r_version), ip_id)

cran3 <- select(cran, ip_id, package, size)
mutate(cran3, size_mb = size/2^20)
mutate(cran3, size_mb = size/2^20, size_gb = size_mb/2^10)

summarise(cran, avg_bytes = mean(size)) # just the same
summarize(cran, avg_bytes = mean(size)) # just the same
