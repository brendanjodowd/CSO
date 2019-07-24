get_cso <- function(table.code) {


  json_url <- paste("http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/",
                    table.code, sep="")
  if (httr::http_type(httr::GET(json_url)) != "application/json") {
    stop("API did not return JSON", call. = FALSE)
  }
  first.line.of.text <- readLines(json_url, n=1 , warn = FALSE)
  #print("Here is the first line")
  #print(first.line.of.text)
  if(first.line.of.text=="invalid Maintable format entered"){
    stop("Invalid table code entered", call. = FALSE)
  }
  if(first.line.of.text=="no active maintable id entered"){
    stop("This JSON table does not exist", call. = FALSE)
  }

  local_dataset <- data.frame(rjstat::fromJSONstat(json_url))

  local.count = 0
  while (length(unique(stringr::word(colnames(local_dataset),  sep = stringr::fixed(".")))) == 1 &
         local.count <50)
  {
    colnames(local_dataset) <- stringr::str_replace(colnames(local_dataset) ,
                                                    stringr::word(colnames(local_dataset),
                                                                  sep = stringr::fixed(".")) , "" )
    while(all(substring(colnames(local_dataset) ,1,1) == rep(".", length(colnames(local_dataset)))))
    {
      colnames(local_dataset) <- substring(colnames(local_dataset) ,2)
    }
  }
  # Adding this bit to make Month more easily converted to date. 24-7-19 
  # Further adjusting this to convert Month to a Date
  if("Month" %in% names(local_dataset)){
    local_dataset$Month <- gsub("M" , "-" , local_dataset$Month)
    local_dataset$Month <- paste(local_dataset$Month , "-01" , sep="")
  }
  
  local_dataset
}
