ECXPCT ;BIR/CML-Print List of Primary Care Teams ; [ 02/28/97  12:16 PM ]
 ;;3.0;DSS EXTRACTS;;Dec 22, 1997
EN ;entry point from option
 W !!,"This option prints a list of all Primary Care Teams.  The list is sorted",!,"alphabetically by TEAM name and displays the pointer to the TEAM file (#404.51)."
 I '$O(^SCTM(404.51,0)) W !!,"The TEAM file (#404.51) does not exist on your system!" G QUIT
 W !!,"The right margin for this report is 80.",!!
 W ! K DIC S DIC="^SCTM(404.51,",FLDS=".01;""TEAM NAME"",NUMBER;""TEAM FILE POINTER"";C45;R9",BY=".01",(FR,TO)="",DHD="Primary Care Teams",L=0
 D EN1^DIP
QUIT Q
