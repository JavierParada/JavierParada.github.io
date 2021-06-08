library(WDI,ggplot2)
library(tidyverse)
library(data.table)
library(stringr)
library(Hmisc)
library(sjlabelled)
library(shinyHeatmaply)

directory <- getwd()
setwd("~/Documents/WDI/Emissions/R")

# 137 variables
variables <- c(
  'AG.LND.AGRI.ZS',
  'AG.LND.ARBL.ZS',
  'AG.LND.EL5M.RU.K2',
  'AG.LND.EL5M.RU.ZS',
  'AG.LND.EL5M.UR.K2',
  'AG.LND.EL5M.UR.ZS',
  'AG.LND.EL5M.ZS',
  'AG.LND.FRST.K2',
  'AG.LND.FRST.ZS',
  'AG.LND.PRCP.MM',
  'AG.LND.TOTL.K2',
  'AG.LND.TOTL.RU.K2',
  'AG.LND.TOTL.UR.K2',
  'AG.SRF.TOTL.K2',
  'EG.CFT.ACCS.ZS',
  'EG.EGY.PRIM.PP.KD',
  'EG.ELC.ACCS.RU.ZS',
  'EG.ELC.ACCS.UR.ZS',
  'EG.ELC.ACCS.ZS',
  'EG.ELC.FOSL.ZS',
  'EG.ELC.RNEW.ZS',
  'EG.ELC.RNWX.KH',
  'EG.ELC.RNWX.ZS',
  'EG.FEC.RNEW.ZS',
  'EN.ATM.CO2E.EG.ZS',
  'EN.ATM.CO2E.GF.KT',
  'EN.ATM.CO2E.GF.ZS',
  'EN.ATM.CO2E.KD.GD',
  'EN.ATM.CO2E.KT',
  'EN.ATM.CO2E.LF.KT',
  'EN.ATM.CO2E.LF.ZS',
  'EN.ATM.CO2E.PC',
  'EN.ATM.CO2E.PP.GD',
  'EN.ATM.CO2E.PP.GD.KD',
  'EN.ATM.CO2E.SF.KT',
  'EN.ATM.CO2E.SF.ZS',
  'EN.ATM.GHGO.KT.CE',
  'EN.ATM.GHGO.ZG',
  'EN.ATM.GHGT.KT.CE',
  'EN.ATM.GHGT.ZG',
  'EN.ATM.HFCG.KT.CE',
  'EN.ATM.METH.AG.KT.CE',
  'EN.ATM.METH.AG.ZS',
  'EN.ATM.METH.EG.KT.CE',
  'EN.ATM.METH.EG.ZS',
  'EN.ATM.METH.KT.CE',
  'EN.ATM.METH.ZG',
  'EN.ATM.NOXE.AG.KT.CE',
  'EN.ATM.NOXE.AG.ZS',
  'EN.ATM.NOXE.EG.KT.CE',
  'EN.ATM.NOXE.EG.ZS',
  'EN.ATM.NOXE.KT.CE',
  'EN.ATM.NOXE.ZG',
  'EN.ATM.PFCG.KT.CE',
  'EN.ATM.PM25.MC.M3',
  'EN.ATM.PM25.MC.ZS',
  'EN.ATM.SF6G.KT.CE',
  'EN.BIR.THRD.NO',
  'EN.CLC.DRSK.XQ',
  'EN.CLC.GHGR.MT.CE',
  'EN.CLC.MDAT.ZS',
  'EN.CO2.BLDG.ZS',
  'EN.CO2.ETOT.ZS',
  'EN.CO2.MANF.ZS',
  'EN.CO2.OTHX.ZS',
  'EN.CO2.TRAN.ZS',
  'EN.FSH.THRD.NO',
  'EN.HPT.THRD.NO',
  'EN.MAM.THRD.NO',
  'EN.POP.EL5M.RU.ZS',
  'EN.POP.EL5M.UR.ZS',
  'EN.POP.EL5M.ZS',
  'EN.POP.SLUM.UR.ZS',
  'ER.FSH.AQUA.MT',
  'ER.FSH.CAPT.MT',
  'ER.FSH.PROD.MT',
  'ER.GDP.FWTL.M3.KD',
  'ER.H2O.FWAG.ZS',
  'ER.H2O.FWDM.ZS',
  'ER.H2O.FWIN.ZS',
  'ER.H2O.FWTL.K3',
  'ER.H2O.FWTL.ZS',
  'ER.H2O.INTR.K3',
  'ER.H2O.INTR.PC',
  'ER.LND.PTLD.ZS',
  'ER.MRN.PTMR.ZS',
  'ER.PTD.TOTL.ZS',
  'NY.ADJ.AEDU.CD',
  'NY.ADJ.AEDU.GN.ZS',
  'NY.ADJ.DCO2.CD',
  'NY.ADJ.DCO2.GN.ZS',
  'NY.ADJ.DFOR.CD',
  'NY.ADJ.DFOR.GN.ZS',
  'NY.ADJ.DKAP.CD',
  'NY.ADJ.DKAP.GN.ZS',
  'NY.ADJ.DMIN.CD',
  'NY.ADJ.DMIN.GN.ZS',
  'NY.ADJ.DNGY.CD',
  'NY.ADJ.DNGY.GN.ZS',
  'NY.ADJ.DPEM.CD',
  'NY.ADJ.DPEM.GN.ZS',
  'NY.ADJ.ICTR.GN.ZS',
  'NY.ADJ.NNAT.CD',
  'NY.ADJ.NNAT.GN.ZS',
  'NY.ADJ.SVNG.CD',
  'NY.ADJ.SVNG.GN.ZS',
  'NY.ADJ.SVNX.CD',
  'NY.ADJ.SVNX.GN.ZS',
  'NY.GDP.COAL.RT.ZS',
  'NY.GDP.FRST.RT.ZS',
  'NY.GDP.MINR.RT.ZS',
  'NY.GDP.NGAS.RT.ZS',
  'NY.GDP.PETR.RT.ZS',
  'NY.GDP.TOTL.RT.ZS',
  'SH.H2O.BASW.RU.ZS',
  'SH.H2O.BASW.UR.ZS',
  'SH.H2O.BASW.ZS',
  'SH.H2O.SMDW.RU.ZS',
  'SH.H2O.SMDW.UR.ZS',
  'SH.H2O.SMDW.ZS',
  'SH.STA.AIRP.P5',
  'SH.STA.BASS.RU.ZS',
  'SH.STA.BASS.UR.ZS',
  'SH.STA.BASS.ZS',
  'SH.STA.HYGN.RU.ZS',
  'SH.STA.HYGN.UR.ZS',
  'SH.STA.HYGN.ZS',
  'SH.STA.ODFC.RU.ZS',
  'SH.STA.ODFC.UR.ZS',
  'SH.STA.ODFC.ZS',
  'SH.STA.POIS.P5',
  'SH.STA.POIS.P5.FE',
  'SH.STA.POIS.P5.MA',
  'SH.STA.SMSS.RU.ZS',
  'SH.STA.SMSS.UR.ZS',
  'SH.STA.SMSS.ZS',
  'SH.STA.WASH.P5')

# Download data 
datalist = list()
counter <- 0
for (x in variables) {
  counter <- counter + 1
  print(paste(toString(counter), x))
  dat <- WDI(indicator = x, extra = TRUE, start = 2000, country = "all")
  datalist[[counter]] <- dat
}

# 147 variables x 5,544 observations
metadata <- c("iso2c", "country", "year", "iso3c", "region", "capital", "longitude","latitude", "income", "lending")
df_wide <- datalist %>% reduce(inner_join, by = metadata)
df_wide <- df_wide[c(metadata, variables)]
df_wide[sapply(df_wide,is.character)] <- lapply(df_wide[sapply(df_wide,is.character)], as.factor)
str(df_wide[sapply(df_wide,is.factor)])
# maintain variable description
varlabels <- setNames(stack(lapply(df_wide, label))[2:1], c("Indicator", "Description"))

# long: 759,528 obs
setDT(df_wide)
df_long <- melt(data = df_wide, id.vars = metadata, variable.name = "Indicator", value_name = "Value")
str(df_long)
CETS <- str_split_fixed(df_long$Indicator, "\\.", 6)
colnames(CETS) <- c("CETS1","CETS2","CETS3","CETS4","CETS5","CETS6")
df_long <- cbind(df_long,CETS)
df_long <- remove_all_labels(df_long)
df_long <- merge(df_long, varlabels, by.x="Indicator", by.y="Indicator")
df_long[sapply(df_long,is.character)] <- lapply(df_long[sapply(df_long,is.character)], as.factor)
str(df_long)

write_csv(df_long,file="WDI_Inventory.csv", na = "")