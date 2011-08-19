PSNODDI ;BIR/WRT-REPORT TO DISPLAY EXEMPTIONS FOR DDI CHECKING IN VA PRODUCT FILE ; 07/02/03 14:36
 ;;4.0; NATIONAL DRUG FILE;**70**; 30 Oct 98
 ;Reference to ^PSDRUG supported by DBIA #2192
 ;
 D TXT,RPT K CLCODE,CLPTR,DFRM,FORM,NDF,PROD,PSNDRG,VAPN
 Q
TXT W !!,"This report gives you a printed copy of Dispense Drugs from your",!,"local file which are matched to VA Products that are marked as ",!,"EXCLUDE from Drug-Drug Interaction checking."
 W !,"You may queue the report to print, if you wish.",!
 Q
RPT S DIC="^PSDRUG(",L=0,FLDS="[PSNODDI1]",BY="@.01",DHD="[PSNODDI2]" D EN1^DIP
 Q
