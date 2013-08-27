### remove top of read files
# read.table("testing.txt", "\t", header = FALSE, skip=3)

graph_gap_sizes = function(dir)
{
  
  gap_sizes = list()
  islands = list()
  types = list()
  i = 0
  for (file_name in list.files(dir, full.names=TRUE))
  {
    chip_data <- read.table(file_name, sep="\t")
    island_total <- sum(chip_data[4])
    type <- gap_str <- unlist(strsplit(file_name, "-"))[2]
    gap_str <- unlist(strsplit(file_name, "-"))[4]
    gap_size <- as.numeric(substring(gap_str,2))

    
    # append to lists 
    gap_sizes[i] = gap_size
    islands[i] = island_total
    types[i] = type
    i = i + 1
  }
  data_frame = cbind(types,gap_sizes, islands)
  return(data_frame)
}

#plot
library(ggplot2)
qplot(gap_size,islands,data=d) + geom_smooth()

