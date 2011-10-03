PSNVAGN ;BIR/WRT-REPORT TO DISPLAY VA GENERIC NAMES FROM THE NATIONAL DRUG FILE  ;08/28/98 14:09
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 W !!,"This report gives you a printed copy of the VA Generic Names from the National Drug File. This report may assist you in the matching process.",!,"You may queue the report to print, if you wish.",!
 S DIC="^PSNDF(50.6,",L=0,FLDS=".01",BY=".01",DHD="VA GENERIC NAMES FROM THE NATIONAL DRUG FILE  " D EN1^DIP
 Q
