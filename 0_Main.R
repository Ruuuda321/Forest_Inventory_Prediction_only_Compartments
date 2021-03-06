#####################################################################################
########################## WERSJA 3 - WSZYSTKIE KO��WKI #################################
setwd("D:\\Forest_Inventory_Prediction_only_Compartments") ##Folder w kt�rym s� skrypty

obszar<-"T"           # e.g. M-Milicz, G-Gorlice
metoda<-"PC"          # PC, WMK, ITD

out_wyniki = "D:\\WYNIKI"      # Lokalizacja w ktorej zapisywane maj� by� WYNIKI

#### DANE WEJSCIOWE MODELU
dependent_var <- "V"                    # Nazwa obliczanej zmiennej np. V, DBHall, itd.
ile_param<-3                              # ile ��cznie parametr�w a0,a1, ..., an

## Sekcja wyboru nazw zmiennych
X <- c("x1","x2")

## Obliczone wsp�czynniki modelu
B <-data.frame(a0=-1, a1=1, a2=2)


##!!! Posta� modelu - w return() podmieniamy posta� modelu
Vp_compute <- function(...){
  arg<-list(...)
  return(arg$a0 + arg$a1*arg$x1 + arg$a2*arg$x2)
}


#### DANE WEJSCIOWE DLA FN - CSV lub SHP
#Uwaga! W pliku z FN musi by� kolumna z nazw� wydzielenia na obszarze kt�rego znajduje sie FN i pole powierzchni pojedynczego FN

FN_path<-"D:\\DANE\\FN_stats.csv" #Sciezka do pliku csv lub shp ze statystykami dla FN
FN_name<-"id_fn"        #kolumna z unikalna nazwa FN
FN_area<-"pow_fn"      #kolumna z polem powierzchni FN
wydz_name_FN<-"adr_les" #kolumna z nazwa wydzielenia na ktorym znajduje sie FN

#### DANE WEJSCIOWE DLA WYDZIELEN (SHP)  
wydz_path<-"D:\\DANE\\Wydzielenia.shp" #Plik shp z aktualnymi wydzieleniami (musz� by� zgodne z tymi kt�rymi przeci�to fishnety
wydz_name<-"adr_les"   #NAZWA KOLUMNY Z ID WYDZIELENIA (NAJLEPIEJ ADRES LESNY LUB INNY UNIKALNY)
wydz_pow<-"Pole_pow_h" ###Kolumna z polem powierzchni w hektarach

####################################################################################################################################################################
###################################################################################################################################################################
#Odtad juz nic nie zmieniamy
source('1_WczytywaniePelnychDanych.R')
source('4_Regresja.R')                                         
source('8_Zasobnosc_wydzielenia_wazona.R')                     

rm(list = ls())