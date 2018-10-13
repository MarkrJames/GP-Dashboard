# Script to unzip 

loadFolder <- "C:\\Users\\mrmar\\Desktop\\R Projects\\GP-Dashboard\\Input\\GP Prescribing\\Zipped\\gpdata"   # note. inclueds start or file name "\\gpdata"

saveFolder <- "C:\\Users\\mrmar\\Desktop\\R Projects\\GP-Dashboard\\Input\\GP Prescribing\\Unzipped"

dateRange <- seq(from = as.Date("2015/04/01"),    # as date needs day, not just month and year
                 to = Sys.Date(),                 # Use system data so don't need to update script each time run
                 by = 'month')                    # increment by 1 month

dateRange <- format(as.Date(dateRange), '%Y%m')


# TO DO - Look to replace for loop with purrr
for ( i in seq_along(dateRange))
  {
  csvFile =  paste0(saveFolder,"\\GPData", dateRange[i], ".csv")
  
  if (!file.exists(csvFile)) {
  
  unzip(zipfile =  paste0(loadFolder, dateRange[i],".zip"),               
        files = paste0("GPData", dateRange[i], ".csv"),                      
        exdir = saveFolder)
    }
  }






