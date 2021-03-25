usePackage <- function(p) {  ## install package if not exists
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep = TRUE)
  require(p, character.only = TRUE)
}
usePackage("rgdal")
usePackage("tools")
usePackage("splitstackshape")
usePackage("sqldf")
usePackage("data.table")
usePackage("openxlsx")
usePackage("dplyr")
usePackage("stringr")



#Wczytywanie FN
if(exists("FN_path")){
  if(tools::file_ext(FN_path)=="csv"){
    FN<-read.csv2(FN_path,stringsAsFactors = F)
  } else if(tools::file_ext(FN_path)=="xlsx"){
    FN<-read.xlsx(FN_path,sheet = 1)
  } else if(tools::file_ext(FN_path)=="shp"){
    FN<-readOGR(dsn=FN_path, ogrListLayers(FN_path),encoding = 'UTF-8', stringsAsFactors = F)
  } else {
    stop("Plik ze statystykami dla FN powinien byæ w formacie CSV,SHP lub XLSX")
  }
}

#Wczytywanie wydzieleñ
if (exists("wydz_path")){
  if(tools::file_ext(wydz_path)=="shp"){ 
    wydz<-readOGR(dsn=wydz_path, ogrListLayers(wydz_path),encoding = 'UTF-8', stringsAsFactors = F)
  } else {
    stop("Wczytaj plik z wydzieleniami w formacie SHP")
  }
}


#Sprawdzenie_typu_danych_i_wymuszenie typu - kolowki
names_pattern_dbl<-c("^all_|^fe_|^le_|^k[1-4]_|^ABA.ITD_|^p343_|^lad_|^pARAHpTF|^crown_ret_perc_stats|^canRR|^usr_zwarcie1|^lad_sum_4m|^pow_fn|^hsr_all|^HSR|^hsr_m|^h100_all|^H100|^h100_m|^ba_all|^BA|^ba_m|^vol|^vol_z|^vol_m|^gsv_all|^GSV|^gsv_m|^crown_ret_perc_stats|^single_to_all_stats|^ground_to_all|^ret12_avg|^ret12_med|^pARAH|^pARAHpTF|^tFRAh|^prcgAlMeF|^prcgAlMoF|^prcntgAlMe|^prcntgAlMo|^pFRAMe|^pFRAMo|^zskew|^zkurt|^zentropy|^pzabovezmean|^pzabove2")
names_pattern_int<-c("^udz_gg|^udz_igl|^KLW|^n|^n_ha|^n_z|^n_z_ha|^n_m|^n_m_ha|^WIEK|^tFRAh|^frsRetAMe|^frsRetAMo|^frsRetAMd|^allRetAMe|^allRetAMo|^allRetAMd")

#Sprawdzenie_typu_danych_i_wymuszenie typu - FN
vec2<-names(FN)
vec2_dbl<-vec2[which(str_detect(string = vec2, pattern = names_pattern_dbl))]
vec2_int<-vec2[which(str_detect(string = vec2, pattern = names_pattern_int))]

if (length(vec2_dbl)!=0){
for (i in 1:length(vec2_dbl)){
  FN[,vec2_dbl[i]]<-as.numeric(FN[,vec2_dbl[i]])
  print(summary(FN[,vec2_dbl[i]]))
  }
}

if(length(vec2_int)!=0){
for (i in 1:length(vec2_int)){
  FN[,vec2_int[i]]<-as.integer(FN[,vec2_int[i]])
  }
}


#Czyszczenie plików z NULLI
FN[is.na(FN)]<-0


