PSSDRINT ;BIR/WRT-REPORT OF LOCALLY ADDED DRUG INTERACTIONS ;09/11/98 13:21
 ;;1.0;PHARMACY DATA MANAGEMENT;**22**;9/30/97
 ;
 ; reference to ^PS(56 supported by IA #2133
 ;
 W !!,"This report gives you a printed copy of locally added drug interactions and ",!,"their severity. You may queue the report to print, if you wish.",!
 S DIC="^PS(56,",L=0,FLDS="[PSNLOCAL]",BY="NATIONALLY ENTERED=""""",DHD="LOCALLY ADDED DRUG INTERACTION LIST" D EN1^DIP
 K DIC,DHD,BY,FLDS,L
 Q
