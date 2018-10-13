
library(RODBC)    # Needed to connect to SQL DB

# SQL DB connection
# Note connection string sensative to spaces before/after '=' 
conn <- odbcDriverConnect(connection = "Driver={SQL Server Native Client 11.0};
                                        server=localhost;
                                        database=dbHealth;
                                        trusted_connection=yes;")
<<<<<<< HEAD

=======
>>>>>>> 04214c5c28235d7cc330f3b1599a9ba1a79011c7
# Create SQL table
query_create <- "
                CREATE TABLE [dbo].[GP_Prescribing](
                [HB] [nvarchar](255) NULL,
                [Locality] [nvarchar](255) NULL,
                [PracticeID] [nvarchar](255) NULL,
                [BNFCode] [nvarchar](255) NULL,
                [BNFName] [nvarchar](255) NULL,
                [Items] [float] NULL,
                [NIC] [float] NULL,
                [ActCost] [float] NULL,
                [Quantity] [float] NULL,
                [DDD] [float] NULL,
                [ADQ] [float] NULL,
                [Period] [float] NULL
                ) ON [PRIMARY]
                "

# Run SQL script
sqlQuery(conn, query_create)

# Create a sequence and incrent by 1 month. Must be Y,M,D as date needs day, not just month and year
date <- seq(from = as.Date("2016/01/01"),
            to = Sys.Date(), 
            by = 'month') 

# Change date fotmat to match file naming string
date <- format(as.Date(date), '%Y%m')

# Loop through files and use SQL bulk insert into SQL DB
<<<<<<< HEAD
# Note *'* after FROM and before *"* in SQL statement
=======
# Note *'* after FROM and before *"* in SQL statment
>>>>>>> 04214c5c28235d7cc330f3b1599a9ba1a79011c7
for ( i in seq_along(date) )
  {
    query_insert <-  paste0("BULK INSERT GP_Prescribing
                             FROM '" , getwd(), "/Input/GP Prescribing/Unzipped/GPData", date[i], ".csv'  
                             WITH 
                             (
                             FIRSTROW = 2, 
                             FIELDTERMINATOR = ',', 
                             ROWTERMINATOR = '\n' 
                             ) " 
                            )
    sqlQuery(conn, query_insert)
    } 
