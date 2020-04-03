# Load necessary libraries 
library(ggplot2)
library(EpiEstim)
library(dplyr)
library(tidyr)
library(vroom)
library(here)
library(drake)
library(purrr)


# translating the codes
iso_codes <- 
   c('AN' = 'Andalucía'
     ,'AR' = 'Aragón'
     ,'AS' = 'Asturias'
     ,'CN' = 'Canarias'
     ,'CB' = 'Cantabria'
     ,'CM' = 'Castilla-La Mancha'
     ,'CL' = 'Castilla y León'
     ,'CT' = 'Catalunya'
     ,'EX' = 'Extremadura'
     ,'GA' = 'Galicia'
     ,'IB' = 'Illes Balears'
     ,'RI' = 'La Rioja'
     ,'MD' = 'Comunidad de Madrid'
     ,'MC' = 'Región de Murcia'
     ,'NC' = 'Navarra'
     ,'PV' = 'País Vasco'
     ,'VC' = 'Comunidad Valenciana')
