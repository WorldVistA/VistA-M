PSNRPT ;BIR/WRT-REPORT TO DISPLAY DRUGS THAT HAVE BEEN MATCHED,VERIFIED,& MERGED ;[ 01/12/98   5:18 PM ]
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 W !!,"This report gives a printed copy of the drugs from your local drug file that",!,"have been matched to the National Drug File. This report requires 132 columns.",!,"You may queue the report to print, if you wish.",!
 S DIC="^PSDRUG(",L=0,FLDS="[PSNRPT4]",BY="GENERIC NAME",DIS(0)="I $D(^PSDRUG(D0,""ND"")),$P(^PSDRUG(D0,""ND""),U,2)]""""",DHD="W ?0 D ^PSNHEADR" D EN1^DIP
 K PSNDF,PSNDOS,PSNPS,PSNPTR,PSNST,PSNTP,PSNUN,VV,VVV,PSNLOCL,%DT,X,Y
 Q
