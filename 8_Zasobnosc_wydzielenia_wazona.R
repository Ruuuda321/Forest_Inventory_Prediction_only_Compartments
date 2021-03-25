
#Usuwanie ujemnych wynikow dla FN
for (i in 1:nrow(df7_FN)){
    if (df7_FN[i,3]<0 | is.na(df7_FN[i,3])){
      df7_FN[i,3]=0
    }
 print(sprintf("FN nr %i z %i",i,nrow(df7_FN)))
}


#Obliczanie wazonej wartosci zasobnosci - zasobnosc * waga
df7_FN[,sprintf('Wagax%s_model',dependent_var)]<-df7_FN[,sprintf('%s_model',dependent_var)]*df7_FN[,FN_area]
head(df7_FN)


write.csv2(x=df7_FN,file=paste(out_wyniki,"\\",obszar,"_FN_wyniki_ABA-",metoda,"reg_",dependent_var,".csv",sep=""))

############################ COMPARTMENTS - WYDZIELENIA ###########################

wydz_names<-wydz@data[,wydz_name]
n_wydz<-length(wydz)
kol_wydz<-ncol(wydz)


####!!! Calculating volume for compartments using weighted arithmetic mean (CHANGE NAME OF COLUMN with area of FN

for (j in 1:n_wydz){ 
  FN_wydz<-df7_FN[which(df7_FN[,wydz_name_FN]==wydz_names[j]),]
  wydz@data[which(wydz@data[,wydz_name]==wydz_names[j]),"Count_FN"]<-nrow(FN_wydz)
  if (dependent_var == "BAall"){
    BA_srednie<-sum(FN_wydz[,sprintf('Wagax%s_model',dependent_var)])/sum(FN_wydz[,FN_area])
    ile_max_oczek<-wydz@data[which(wydz@data[,wydz_name]==wydz_names[j]), wydz_pow ]/0.05
    wydz@data[which(wydz@data[,wydz_name]==wydz_names[j]),sprintf('%s_model',dependent_var)]<-BA_srednie*ile_max_oczek
  } else {
    wydz@data[which(wydz@data[,wydz_name]==wydz_names[j]),sprintf('%s_model',dependent_var)]<-sum(FN_wydz[,sprintf('Wagax%s_model',dependent_var)])/sum(FN_wydz[,FN_area])
  }
}

head(wydz@data)

#### Export to SHAPEFILE and csv
out_wydz_name<-paste(obszar,"_wydzielenia_wyniki_ABA-",metoda,"reg_",dependent_var,sep="")  
writeOGR(obj= wydz,dsn= out_wyniki,layer= out_wydz_name,driver= "ESRI Shapefile")
write.xlsx(x=wydz@data,file=file.path(out_wyniki, paste(out_wydz_name, ".xlsx", sep="")))
