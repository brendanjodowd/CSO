
### Get started
Hi! This package provides a convenient means of importing CSO data tables which are stored on Statbank. To install, use the following (requires devtools):  
```
devtools::install_github("brendanjodowd/CSO")
``` 

### Get Data
Use the function `get_cso()` to import data tables, where the argument is the 5 character code for the data table. To import monthly unemployment data, for example, use:  
```
unemployment.data <- get_cso("MUM01")
```

### Find Tables
To help you find relevant data, the package also contains a dataframe called '`statbank`' which contains titles and table codes for all of the data tables held on Statbank. So, to find data tables containing information on unemployment, for example, you could use:  
```
unemp.tables <- statbank[grepl("unemployment" , statbank$Title , ignore.case = TRUE),]
```
or, for tidyverse fans,   
```
unemp.tables <- filter(statbank, str_detect(Title , "Unemployment"))
```

### Note on Dates
Monthly data on Statbank has the following form (e.g.) 2012M06 for June 2016.  
Similarly Quarterly data takes the form (e.g.) 2017Q2 for Quarter 2 in 2017.  
In both cases I recommend that the `parse_date_time` function from the lubridate package is used.  
**Monthly example**  
```
some.data$Month <- parse_date_time(some.data$Month , "%Y%m")
```
**Quarterly example**  
```
some.data$Quarter <- parse_date_time(some.data$Quarter, "%Y%q")
```



