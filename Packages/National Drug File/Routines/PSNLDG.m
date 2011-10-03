PSNLDG ;BIR/WRT-REPORT TO DISPLAY INFO IN LOCAL DRUG FILE ; 01/28/00 14:41
 ;;4.0; NATIONAL DRUG FILE;**3,19,22**; 30 Oct 98
 ;
 ;Reference to ^PSDRUG is supported by DBIA #2352 & #221
 ;
 D RPT K PTR,NF,NFR
 Q
RPT W !!,"This report gives you a printed copy of the local drug name, inactive date, NDC,",!,"and the DEA value. If your local drug is matched to NDF and National Formulary",!,"and/or Restriction information exists, "
 W "this is also displayed after the drug",!,"name. This report requires 132 columns.",!,"You may queue the report to print, if you wish.",!
 S DIC="^PSDRUG(",L=0,FLDS="[PSNLDG1]",BY="GENERIC NAME",DHD="[PSNHEAD]" D EN1^DIP
 Q
PROD S NF="",NFR="" I $D(^PSDRUG(D0,"ND")) S PTR=$P($G(^PSDRUG(D0,"ND")),"^",3) I PTR]"",$D(^PSNDF(50.68,PTR,0)) S:$P($G(^PSNDF(50.68,PTR,5)),"^")=0 NF="   #" S:$D(^PSNDF(50.68,PTR,6,0)) NFR="   R" W ?23,NF,NFR
 Q
