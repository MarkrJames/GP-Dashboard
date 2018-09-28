

# Link to main webpage:
# http://www.primarycareservices.wales.nhs.uk/general-practice-prescribing-data-extrac

# Download links on main page appear as:
# http://www.primarycareservices.wales.nhs.uk/opendoc/325207 

# Download links re-direct to:
# http://www.pcsdata.wales.nhs.uk/gpdata/gpdata201803.zip


# Could use rvest to scape links but as the links do not follow a pattern naming files difficult
# opted for loop instead as files follow YYYYMM pattern 

# First file starts from Apr15 


saveFolder <- ".\\Input\\GP Prescribing\\Zipped\\"

dateRange <- seq(from = as.Date("2015/04/01"),    # as date needs day, not just month and year
                 to = Sys.Date(),                 # Use system data so don't need to update script each time run
                 by = 'month')                    # increment by 1 month

dateRange <- format(as.Date(dateRange), '%Y%m')

# loop through sequence YYYYMM incrementing by 1 MM
# Check if file in folder
# If doesn't exist download file
for ( i in seq_along(dateRange)){
  
  downloadLink <- print(paste0('http://www.pcsdata.wales.nhs.uk/gpdata/gpdata',dateRange[i],".zip"))
  
  fileName <- paste0(saveFolder, basename(downloadLink))
  
  if (!file.exists(fileName)) {
    download.file(downloadLink, destfile = fileName, mode = 'wb')
  }
  
}
  
 
