#####################################################################################
########################## WERSJA 3 - WSZYSTKIE KO£ÓWKI #################################
setwd("D:\\Forest_Inventory_Prediction_only_Compartments") ##Folder w którym s¹ skrypty

obszar<-"T"           # e.g. M-Milicz, G-Gorlice
metoda<-"PC"          # PC, WMK, ITD

out_wyniki = "D:\\WYNIKI"      # Lokalizacja w ktorej zapisywane maj¹ byæ WYNIKI

#### DANE WEJSCIOWE MODELU
dependent_var <- "V"                    # Nazwa obliczanej zmiennej np. V, DBHall, itd.
ile_param<-3                              # ile ³¹cznie parametrów a0,a1, ..., an

## Sekcja wyboru nazw zmiennych
X <- c("x1","x2")

## Obliczone wspó³czynniki modelu
B <-data.frame(a0=-1, a1=1, a2=2)


##!!! Postaæ modelu - w return() podmieniamy postaæ modelu
Vp_compute <- function(...){
  arg<-list(...)
  return(arg$a0 + arg$a1*arg$x1 + arg$a2*arg$x2)
}


#### DANE WEJSCIOWE DLA FN - CSV lub SHP
#Uwaga! W pliku z FN musi byæ kolumna z nazw¹ wydzielenia na obszarze którego znajduje sie FN i pole powierzchni pojedynczego FN

FN_path<-"D:\\DANE\\FN_stats.csv" #Sciezka do pliku csv lub shp ze statystykami dla FN
FN_name<-"id_fn"        #kolumna z unikalna nazwa FN
FN_area<-"pow_fn"      #kolumna z polem powierzchni FN
wydz_name_FN<-"adr_les" #kolumna z nazwa wydzielenia na ktorym znajduje sie FN

#### DANE WEJSCIOWE DLA WYDZIELEN (SHP)  
wydz_path<-"D:\\DANE\\Wydzielenia.shp" #Plik shp z aktualnymi wydzieleniami (musz¹ byæ zgodne z tymi którymi przeciêto fishnety
wydz_name<-"adr_les"   #NAZWA KOLUMNY Z ID WYDZIELENIA (NAJLEPIEJ ADRES LESNY LUB INNY UNIKALNY)
wydz_pow<-"Pole_pow_h" ###Kolumna z polem powierzchni w hektarach

####################################################################################################################################################################
###################################################################################################################################################################
#Odtad juz nic nie zmieniamy
source('1_WczytywaniePelnychDanych.R')
source('4_Regresja.R')                                         
source('8_Zasobnosc_wydzielenia_wazona.R')                     

rm(list = ls())