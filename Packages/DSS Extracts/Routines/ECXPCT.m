ECXPCT ;BIR/CML-Print List of Primary Care Teams ;5/9/14  12:37
 ;;3.0;DSS EXTRACTS;**149**;Dec 22, 1997;Build 27
EN ;entry point from option
 N ECXPORT ;149
 W !!,"This option prints a list of all Primary Care Teams.  The list is sorted",!,"alphabetically by TEAM name and displays the pointer to the TEAM file (#404.51)."
 I '$O(^SCTM(404.51,0)) W !!,"The TEAM file (#404.51) does not exist on your system!" G QUIT
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D EXPORT Q  ;149
 W !!,"The right margin for this report is 80.",!!
 W ! K DIC S DIC="^SCTM(404.51,",FLDS=".01;""TEAM NAME"",NUMBER;""TEAM FILE POINTER"";C45;R9",BY=".01",(FR,TO)="",DHD="Primary Care Teams",L=0
 D EN1^DIP
QUIT Q
 ;
EXPORT ;149 Export team information to spreedsheet - entire section added
 N DIC,FLDS,BY,FR,TO,L,DIOBEG,DHD,POP,X,%ZIS,IOP
 W !!,"To ensure all data is captured during the export:"
 W !!,"1. Select 'Logging...' from the File Menu. Select your file, and where to save."
 W !,"2. On the Setup menu, select 'Display...',then 'screen' tab and modify 'columns'",!,"   setting to at least 225 characters."
 W !,"3. The DEVICE input for the columns should also contain a large enough",!,"   parameter (e.g. 225).  The DEVICE prompt is defaulted to 0;225;99999 for you.",!,"   You may change it if need be."
 W !,"Example: DEVICE: 0;225;99999 *Where 0 is your screen, 225 is the margin width",!?17,"and 99999 is the screen length."
 W !!,"NOTE:  In order for all number fields, such as SSN and Feeder Key, to be",!,"displayed correctly in the spreadsheet, these fields must be formatted as Text",!,"when importing the data into the spreadsheet.",!
 S DIC="^SCTM(404.51,",FLDS="NAME_""^""_NUMBER",BY="@.01",(FR,TO)="",DHD="@@",L=0,DIOBEG="W ""TEAM NAME^TEAM FILE POINTER"""
 S %ZIS="N",%ZIS("B")="0;225;99999" D ^%ZIS Q:POP  S IOP=ION_";"_IOM_";"_IOSL
 D EN1^DIP
 I '$G(POP) D  ;Don't print the following lines if the report didn't print
 .W !!,"Turn off your logging..."
 .W !,"...Then, pull your export text file into your spreadsheet.",!
 .S DIR(0)="E",DIR("A")="Press any key to continue" D ^DIR
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 Q
