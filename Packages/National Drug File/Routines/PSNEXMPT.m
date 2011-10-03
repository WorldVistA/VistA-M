PSNEXMPT ;BIR/WRT-REPORT TO DISPLAY EXEMPTIONS FOR DDI CHECKING IN VA PRODUCT FILE ; 06/12/03 10:20
 ;;4.0; NATIONAL DRUG FILE;**70**; 30 Oct 98
 D RPT K ACT,NODE
 Q
RPT W !!,"This report gives you a printed copy of active VA Products marked as",!,"EXCLUDE from Drug-Drug Interaction checking.",!,"You may queue the report to print, if you wish.",!
 S DIC="^PSNDF(50.68,",L=0,FLDS="[PSNEXMP1]",BY="@.01",DHD="VA Products Marked As Exclude From Drg-Drg Interaction Checking" D EN1^DIP
 Q
