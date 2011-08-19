PSSNFIP ;BIR/WRT-Post install routine for National Formulary Indicator ; 01/28/00 12:51
 ;;1.0;PHARMACY DATA MANAGEMENT;**29**;9/30/97
 ;
 ; Reference to ^DIC supported by IA# 2928
 ;
KILL K ^DIC(50.606,0,"RD")
 K ^DIC(51.2,0,"RD")
 Q
