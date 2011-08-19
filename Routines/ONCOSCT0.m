ONCOSCT0 ;WASH ISC/SRR-SETUP FOR CROSS-TABS ;9/22/92  15:55
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
 ;ask all questions to enable quing report
 ;GET FILE # AND NAME
ST ;ENTRY CROSS TAB ROUTINES-DEFINITIONS
 W @IOF,!?25,"CROSS TAB ROUTINES"
 W !!!?15,"CREATE your own Cross-Tab Reports!!",!!
1 W ?15,"1 - Select File (usually Primary)",!
 W ?15,"2 - Select a field for the ROW",!
 W ?15,"3 - Select a field for the Column",!
 W ?15,"4 - Optional: choose Column cutpoints ",!
 W ?15,"5 - Choose a SEARCH template to select cases",!!!
 W ?20,"REMEMBER - type a '?' for HELP!!"
FIL ;SELECT FILE
 K DIR,DIC S DIR(0)="S^1:PRIMARY;2:PATIENT;3:CONTACT",DIR("A")="     Select File to Search",DIR("B")=1,DIR("?")="^D HLP^ONCOSCT0" D ^DIR G EX:Y["^"!(Y="")
 S (OF,ONCOS("F"))="ONCOLOGY "_$P($P(DIR(0),";",Y),":",2),ONCOS("FI")=$S(Y=1:165.5,2:160,1:165)_U_ONCOS("F")
 S FNUM=$S(Y=1:"165.5",Y=2:160,1:165),GLB=^DIC(FNUM,0,"GL"),ONCOS("FI")=FNUM_U_OF_GLB
R ;S DIC("A")="     Select Row (field for Cross Tabs) ",DIC(0)="AEQZ",DIC="^DD("_FNUM_"," D ^DIC G EX:Y>0 S ONCOS("R")=+Y
SER ;REQUEST FILE TO SEARCH, THEN SEARCH CRITERIA
 W !!!?5,"We will build Crosstabs on entries in "_OF_" file...",!!
 ;
TEM ;TEMPLATE LOOKUP
 K DIR,DIC S DIR("A")="     Select Search template to filter cases",DIR("B")="Yes",DIR(0)="Y" D ^DIR G EX:Y="^"!(Y=""),GET:Y,ALL
ALL ;ALL CASES
 W ! S DIR("A")="      Cases will cover entire registry - OK",DIR(0)="Y",DIR("B")="No" D ^DIR G EX:Y["^"!(Y=""),GET:Y=0 S ONCOS("T")="ALL" D PRINT^ONCOSCT G EX
GET ;GET TEMPLATE
 W ! K DIC,DIR S DIC("A")="     Select Search Template (Type ONCOS for list): ",DIC(0)="AEQZ",DIC="^DIBT(",D="F"_FNUM G EX:D="F" D IX^DIC G EX:Y="^",EX:Y=-1 S ONCOS("T")=Y
 W !!,?5,"REMINDER: Run Define Search Criteria option",!
 W ?5,"to be sure selected entries are up-to-date!!",!!
 S DIR("A")="Continue ",DIR("B")="Y",DIR(0)="Y" D ^DIR G EX:Y'=1
 D PRINT^ONCOSCT G EX
EX ;EXIT
 K ONCOS,DIR,ONCOEX,ROWDEF
 Q
HLP ;HELP SELECTING FILES
 W !!?10,"The Primary File contains the 'cancer case' data.",!
 W ?10,"The Oncology Patient File contains demographic data,",!?14,"Patient history, and Followup History.",!
 W ?10,"The Contact File contains the contacts for all patients.",!!
 Q
 ;ONCOSCT0
