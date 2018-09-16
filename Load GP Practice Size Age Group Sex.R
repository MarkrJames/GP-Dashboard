library(RODBC)      # For odbc connection to SQL
library(tidyverse)
library(readxl)


# GP data taken from Welsh Government stats:
# https://gov.wales/statistics-and-research/general-medical-practitioners/?tab=previous&lang=en
# .xls & .ods files from 2014:2017 combined manually into single spreadsheet outside of R
# Combined manually as not all in a standard format and only a small number of files(4)

# Read spreadsheet into r dataframe
gp_df <- read_excel(path = "C:\\Users\\mrmar\\Desktop\\R Projects\\Wales Practice Size Tidy\\Join_gp-practice-populations-gender-age-group_2014_17.xlsx", 
                    sheet = "Sheet1",col_names = T)

# Add new columns to sum those above 65.  Needed in analayis later on as over 65s are weighted differenlty when using PU (Prescibing Units) calcs
gp_df <- gp_df %>% 
  mutate('both_65+' = rowSums(gp_dff[12:14] + gp_dff[19:21]),
         'm_65+'   = rowSums(gp_dff[12:14]),
         'f_65+'   = rowSums(gp_dff[19:21])
  )

# Gather all columns except for first 4 (Year, LHB, cluster, wcode) into narrow format
# Create new columns and categories by age group and sex
gp_all_df <- gp_df  %>% 
  gather(... = -(1:4)) %>% 
  mutate(
    AgeGroup = case_when(
      substr(key,1,2) %in% c('m_', 'f_') ~ substr(key,3,8),
      key %in% c('total', 'male', 'female') ~ "All",
      key == 'both_65+' ~ '65+'
    ),
    Sex = case_when(
      substr(key,1,1) == 'm' ~ "Male",
      substr(key,1,1) == 'f' ~ "Female",
      substr(key,1,1) %in% c('t', 'B') ~ "Both"
    )
  )


# Connect to SQL database
conn <-odbcDriverConnect(connection=
                           "Driver={SQL Server Native Client 11.0};
                         server=localhost;
                         database=dbHealth;
                         trusted_connection=yes;")

# Save dataframe to SQL to use later
sqlSave(conn, gp_all_df, "gp_age_sex_2014_17_narrow")




