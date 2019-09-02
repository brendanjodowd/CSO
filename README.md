
CSO Package
=========

### Get started
Hi! This package provides a convenient means of importing CSO data tables which are stored on Statbank. To install, use the following (requires devtools package):  
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
CSO data often contains a time variable, such as 'Month', 'Quarter' or 'Year'. The function `get_cso()` converts 'Month' to type date (the first day of that month), and 'Year' to type numerical. The variable 'Quarter' comes in as a string, and is of the form (e.g.) `2010Q1`.


### Licensing and Maps  
The shapes data for counties and administrative counties are derived from shapefiles produced by Ordnance Survey Ireland (OSi) and taken from their [Open Data Portal](data-osi.opendata.arcgis.com). A standard Creative Commons licence applies to this data. Open Data is data that can be freely used, re-used and redistributed by anyone - subject only, at most, to the requirement that the source of the information is to attributed. For more about the Creative Commons Licence, see [here](https://creativecommons.org/licenses/by/4.0/legalcode). For more about OSi, see [here](https://www.osi.ie/about/). 



