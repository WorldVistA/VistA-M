PSNTER ;BIR/WRT-REPORT TO DISPLAY INFO IN DRUG INTERACTION FILE ;09/11/98 13:21
 ;;4.0; NATIONAL DRUG FILE;**116**;30 Oct 98
 ;PSN*4*116;Added Inactivation Date to the PSNACTION Print template and comment that the report will now print as 132 columns
 W !!,"This report gives you a printed copy of the Drug Interaction name, Severity,",!,"and whether it was entered Nationally.  This report requires 132 columns.",!,"You may queue the report to print, if you wish.",!
 S DIC="^PS(56,",L=0,FLDS="[PSNACTION]",BY="NAME",DHD="DRUG INTERACTION LIST" D EN1^DIP
 Q
