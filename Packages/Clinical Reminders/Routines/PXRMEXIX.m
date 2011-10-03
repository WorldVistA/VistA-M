PXRMEXIX ;SLC/PJH - Reminder Dialog Exchange checks. ;10/10/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;
 ;=====================================================================
 ;
 ;Yes/No Prompts
 ;--------------
ASK(YESNO,TEXT,HELP) ;
 W !
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 M DIR("A")=TEXT
 S DIR("B")="Y"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HLP^PXRMEXIX(HELP)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) S PXRMDONE=1 Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;Dialog check - all exist, none exist or some exist
 ;--------------------------------------------------
EXIST(ALL,DNAME,DTYP,INAME) ;
 ;0 - None exist
 ;1 - All exist
 ;2 - Some exist
 ;
 ;Look for component dialogs in DMAP node from PXRMEXIC
 N DONE,DOTHER,EXISTS,FILE,MODE
 S ALL="",DONE=0,MODE="",NAME=""
 ;
 I DTYP="reminder dialog" D
 .F  S NAME=$O(^TMP("PXRMEXTMP",$J,"DMAP",NAME)) Q:NAME=""  D  Q:DONE
 ..;Check if dialog exists
 ..S EXISTS=$$EXISTS^PXRMEXIU(801.41,NAME)
 ..;If exists accumulate list of ancestors
 ..I EXISTS D OTHER(NAME,.DOTHER)
 ..;Quit if some exist and some don't
 ..I MODE=1,'EXISTS S MODE=2,DONE=1 Q
 ..I MODE=0,EXISTS S MODE=2,DONE=1 Q
 ..;Set all exists flag if dialog found
 ..I MODE="",EXISTS S MODE=1
 ..;Set none exists flag if dialog not found
 ..I MODE="",'EXISTS S MODE=0
 ;
 I DTYP'="reminder dialog" D
 .F  S NAME=$O(INAME(NAME)) Q:NAME=""  D  Q:DONE
 ..;Treat namechanges as 'done'
 ..I $D(PXRMNMCH(801.41,NAME)) Q
 ..;Check if dialog exists
 ..S EXISTS=$$EXISTS^PXRMEXIU(801.41,NAME)
 ..;If exists accumulate list of ancestors
 ..I EXISTS D OTHER(NAME,.DOTHER)
 ..;Quit if some exist and some don't
 ..I MODE=1,'EXISTS S MODE=2,DONE=1 Q
 ..I MODE=0,EXISTS S MODE=2,DONE=1 Q
 ..;Set all exists flag if dialog found
 ..I MODE="",EXISTS S MODE=1
 ..;Set none exists flag if dialog not found
 ..I MODE="",'EXISTS S MODE=0
 ;
 ;If all or none exist give option to install all without prompting
 N ANS,TEXT
 I MODE=0 D 
 .S TEXT(1)="All dialog components for "_DNAME_" are new."
 I MODE=1 D
 .S TEXT(1)="All dialog components for "_DNAME_" already exist."
 .S TEXT(2)="",TEXT(4)=""
 .S TEXT(3)="Components not used by any other dialogs."
 .;Warn if used by other dialogs
 .I $D(DOTHER) D
 ..S TEXT(3)="WARNING - some components already used by:"
 ..N CNT,DLIT,DNAME,DTYP,FIRST,NAME
 ..S CNT=4,DNAME="",TEXT(CNT)=""
 ..F  S DNAME=$O(DOTHER(DNAME)) Q:DNAME=""  D
 ...S NAME="",FIRST=1,CNT=CNT+1
 ...S DTYP=DOTHER(DNAME)
 ...I DTYP="R" S DTYP="Reminder Dialog"
 ...I DTYP="G" S DTYP="Dialog Group"
 ...I DTYP="E" S DTYP="Dialog Element"
 ...;S CNT=CNT+1,FIRST=0,TEXT(CNT)=DLIT_NAME_" ("_DTYP_")"
 ...S CNT=CNT+1,FIRST=0,TEXT(CNT)=DNAME_" ("_DTYP_")"
 ..S CNT=CNT+1,TEXT(CNT)=""
 S TEXT="Install "_DTYP_" and all components with no further changes: "
 ;Give option to install all descendents
 D ASK(.ANS,.TEXT,2) I $G(ANS)="Y" S ALL=1
 I $G(ANS)="N" S ALL=0
 Q
 ;
 ;Check if used by other dialogs
 ;------------------------------
OTHER(NAME,LIST) ;
 N DDATA,DIEN,DNAME,DTYP,IEN
 S IEN=$O(^PXRMD(801.41,"B",NAME,0)) Q:'IEN
 ;Check if used by other dialogs
 I '$D(^PXRMD(801.41,"AD",IEN)) Q
 ;Build list of dialogs using this component
 S DIEN=0
 F  S DIEN=$O(^PXRMD(801.41,"AD",IEN,DIEN)) Q:'DIEN  D
 .S DDATA=$G(^PXRMD(801.41,DIEN,0)) Q:DDATA=""
 .S DNAME=$P(DDATA,U),DTYP=$P(DDATA,U,4) Q:DNAME=""
 .;Include only dialogs that are not part of this reminder dialog
 .I $D(^TMP("PXRMEXTMP",$J,"DMAP",DNAME)) Q
 .S LIST(DNAME)=DTYP
 Q
 ;
 ;General help text routine.
 ;--------------------------
HLP(CALL) ;
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C75",DIWL=0,DIWR=75
 ;
 I CALL=1 D
 .S HTEXT(1)="Enter 'Yes' to install all sub-components or"
 .S HTEXT(2)="enter 'No' to install only the selected dialog."
 I CALL=2 D
 .S HTEXT(1)="Enter 'Yes' to install without changes."
 .S HTEXT(2)="Enter 'No' to install with changes."
 I CALL=3 D
 .S HTEXT(1)="Select IFE to INSTALL reminder or dialog from this exchange"
 .S HTEXT(2)="entry. Select DFE to DELETE this entry from the exchange file. "
 .S HTEXT(3)="Select IH to view the installation HISTORY for this entry."
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
