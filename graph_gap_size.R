### remove top of read files
# read.table("testing.txt", "\t", header = FALSE, skip=3)

graph_gap_sizes = function(dir)
  {

  gap_sizes = list()
  islands = list()

  for (file_name in list.files(dir, full.names=TRUE))
    {
    chip_data <- read.table(file_name, sep="\t")
    island_total <- sum(chip_data[4])
    gap_str <- unlist(strsplit(file_name, "-"))[4]
    gap_size <- as.numeric(substring(gap_str,2))
  
    # append to lists
    gap_sizes <- c(gap_sizes, gap_size)
    islands <- c(islands, island_total)
    }
  return(gap_size, islands)
    }


# getdata
gap_size, islands <- graph_gap_sizes(location_dir)

#plot
library(ggplot2)
qplot(gap_size,islands) + geom_smooth()

