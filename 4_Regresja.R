##  Obliczenie wartosci estymowanych (modelowanych) dla FN
tab7_FN <- function(df, a){
  nrs <- character(nrow(df))
  wydz <-character(nrow(df))
  area <-double(nrow(df))
  vms <- double(nrow(df))
  for (k in seq_along(df[,1])){
    print(k)
    Nr = df[k, FN_name]
    nrs[k] <- Nr
    Wydz = df[k, wydz_name_FN]
    wydz[k] <- Wydz
    Area = as.numeric(df[k, FN_area])
    area[k] <- Area
    Vm <- Vp_compute(a0 = a$a0, a1 = a$a1, a2 = a$a2, a3 = a$a3, a4 = a$a4, a5 = a$a5, a6 = a$a6, a7 = a$a7, a8 = a$a8, a9 = a$a9, a10 = a$a10, x1 = as.numeric(df[k,X[1]]), x2= as.numeric(df[k,X[2]]), x3 = as.numeric(df[k,X[3]]), x4= as.numeric(df[k,X[4]]), x5 = as.numeric(df[k,X[5]]), x6= as.numeric(df[k,X[6]]), x7 = as.numeric(df[k,X[7]]), x8= as.numeric(df[k,X[8]]), x9= as.numeric(df[k,X[9]]), x10= as.numeric(df[k,X[10]]))
    if (Vm<0 || is.nan(Vm)){
      Vm<-0
    }
    vms[k] <- Vm
  }
  df7 = data.frame(nrs, wydz, area, vms) 
  colnames(df7) <- c(FN_name, wydz_name_FN, FN_area, sprintf('%s_model',dependent_var))
  return(df7)
}

df7_FN<-tab7_FN(FN, B)


#Zapis tabeli wspolczynnikow do pliku
openxlsx::write.xlsx(x=B, file = paste(out_wyniki,"\\wspolczynniki_modelu_ABA-",metoda,"reg_",dependent_var,".xlsx",sep=""))






