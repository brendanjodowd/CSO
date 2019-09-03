library(dplyr)
library(stringr)
library(ggplot2)
library(CSO)

# if there are any problems so far, make sure these are installed using install.packages()
# for the first three, and devtools::install_github("brendanjodowd/CSO") for the fourth.

##############  PART 1 - import, filter, plot  ##############

unemp <- get_cso("MUM01")

unemp1 <- unemp %>% 
  filter(Age.Group == "15 - 74 years") %>% 
  filter(Sex=="Both sexes") %>% 
  filter(str_detect(Statistic , "Rate"))
  
ggplot(unemployment.data1 , aes(Month , value)) + geom_point() + geom_line()


unemp2 <- unemp %>% 
  filter(Age.Group == "15 - 74 years") %>% 
  filter(!Sex=="Both sexes") %>% 
  filter(str_detect(Statistic , "Rate"))
  
ggplot(unemployment.data2 , aes(Month , value , colour=Sex)) + 
  geom_point() + geom_line() +
  labs(x="" , y = "Unemployment rate (%)") + 
  ylim(0,20) + 
  xlim( as.Date("2005-01-01") , as.Date("2012-01-01") ) + theme_minimal()
  
  
##############  PART 2 - joining datasets  ##############
  
travel <- get_cso("TMA08")

travel1 <- travel %>% 
  filter(Statistic=="Overseas Trips by Irish Residents (Thousand)") %>% 
  filter(Reason.for.Journey=="All reasons for journey")

ggplot(travel1 , aes(Year , value )) + geom_line()


population <- get_cso("PEA01")

population1 <- population %>% 
  filter(Age.Group=="All ages" ) %>% 
  filter(Sex == "Both sexes")

ggplot(population1 , aes(Year , value )) + geom_line()



travel_and_population <- bind_rows(travel1 , population1) %>% 
  select(Year, Statistic, value)

ggplot(travel_and_population , aes(Year, value, colour=Statistic)) + geom_line() +xlim(2009,2020)



travel1 <- travel %>% 
  filter(Statistic=="Overseas Trips by Irish Residents (Thousand)") %>% 
  filter(Reason.for.Journey=="All reasons for journey") %>% 
  select(value, Year) %>% 
  rename(trips = value)


population1 <- population %>% 
  filter(Age.Group=="All ages" ) %>% 
  filter(Sex == "Both sexes") %>% 
  select(value, Year) %>% 
  rename(pop = value)

travel_and_population <- left_join(travel1 , population1 , by="Year") %>% 
  mutate(trips_per_person = trips/pop)



##############  PART 3 - columns  ##############


crime <- get_cso("CJA07")

crime1 <- crime %>% 
  filter(str_detect(Garda.Station , "D.M.R. Western")) %>% 
  filter(Type.of.Offence=="Burglary and related offences") %>% 
  mutate(Garda.Station = word(Garda.Station , 1 , sep=",")) %>% 
  filter(Year %in% c(2012,2014,2016))

ggplot(crime1 , aes(Year , value, colour=Garda.Station)) + geom_line()

ggplot(crime1 , aes(Year , value , fill=Garda.Station)) + geom_col( position="dodge") + coord_flip()

ggplot(crime1 , aes(Garda.Station , value, fill=factor(Year))) + geom_col(position="dodge") + coord_flip()


dublin_averages <- dublin_crime %>% 
  group_by(Garda.Station) %>% 
  summarise(Avg.Burglaries = mean(value))

dublin_averages <- dublin_crime %>% 
  group_by(Garda.Station) %>% 
  mutate(Avg.Burglaries = mean(value))

dublin_averages <- dublin_averages %>% 
  mutate(Status = case_when(
    value > Avg.Burglaries ~ "Above",
    value < Avg.Burglaries ~ "Below",
    value == Avg.Burglaries ~ "Same"
    )
         )


##############  PART 3 - chloropleth  ##############


rent <- get_cso("E1021")

rent1 <- rent %>% 
  filter(str_detect(Statistic, "Average")) %>% 
  filter(Census.Year=="2016") %>% 
  filter(Nature.of.Occupancy=="Rented") 

rent_map_data <- right_join(rent1 , admin_counties, by="County.and.City")

ggplot(rent_map_data, aes(long, lat, group=group, fill=value)) + 
  geom_polygon() + coord_quickmap() 


ggplot(rent_map_data, aes(long, lat, group=group, fill=value)) + 
  geom_polygon(colour="white") + coord_quickmap() +
  scale_fill_gradient(low="blue",  high="red") + theme_void() + 
  labs(fill="Euro per week", title ="Average weekly rent")
