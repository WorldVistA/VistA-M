PXRMRESN ; SLC/PJH - Edit/Inquire resolution statuses ;03/17/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
START N DIC,PXRMGTYP,PXRMHD,PXRMRESN,Y
 ;Select reminder category for display
SELECT ;General selection
 S PXRMHD="Reminder Resolution Status",PXRMGTYP="RESN",PXRMRESN=""
 D START^PXRMSEL(PXRMHD,PXRMGTYP,"PXRMRESN")
 ;Should return a value
 I PXRMRESN D  G SELECT
 .S PXRMHD="REMINDER RESOLUTION STATUS NAME:"
 .;Listman option
 .D START^PXRMGEN(PXRMHD,PXRMGTYP,PXRMRESN)
 ;
END Q
 ;
 ;REMINDER RESOLUTION STATUSES #801.9
 ;-----------------------------------
 ;Temporary list of STATUSES
DISP N CNT,CODE,DES,SUB,TXT
 W #,"REMINDER RESOLUTION STATUS SELECTION",!
 S CODE="",CNT=0
 F  S CODE=$O(^PXRMD(801.9,"B",CODE)) Q:CODE=""  D
 .S CNT=CNT+1
 .W !,CODE
 W !
 Q
 ;
 ;Build display for selected status - Called from PXRMGEN
 ;---------------------------------------------------------
RESN(PXRMRESN) ;
 N DATA,DARRAY,SUB
 S VALMCNT=0 K ^TMP("PXRMGENS",$J),^TMP("PXRMGEN",$J)
 ;
 ;Format headings to include resolution name
 S HEADER=PXRMHD_" "_$P(^PXRMD(801.9,PXRMRESN,0),U)
 ;
 ;Build Reminder Resolution Status Display
 D BUILD(.DARRAY,PXRMRESN) M ^TMP("PXRMGENS",$J)=DARRAY
 ; 
 ;Put the list into the array List Manager is using.
 S SUB=""
 S VALMCNT=0
 F  S SUB=$O(^TMP("PXRMGENS",$J,SUB)) Q:SUB=""  D
 .S DATA=$G(^TMP("PXRMGENS",$J,SUB))
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=DATA
 S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 K ^TMP("PXRMGENS",$J)
 ;Create headings
 D CHGCAP^VALM("HEADER1","")
 D CHGCAP^VALM("HEADER2","")
 D CHGCAP^VALM("HEADER3","")
 Q
 ;
 ;Build Resolution Status Inquiry array
 ;-------------------------------------
BUILD(ARRAY,D0) ;
 N DIWF,DIWL,DIWR,IC,SUB,TAB,TXT,X
 N ABBR,COL,CREA,DATA,DESC,FOUND,INACT,REST
 S DIWF="C70",DIWL=0,DIWR=70,IC=0
 K ^UTILITY($J,"W")
 ;Get Resolution status details
 S DATA=$G(^PXRMD(801.9,D0,0))
 S DESC=$P(DATA,U),ABBR=$P(DATA,U,2),COL=$P(DATA,U,3),INACT=$P(DATA,U,4)
 S CREA=$P(DATA,U,5),REST=$P(DATA,U,6)
 ;
 ;Resolution Status
 S TXT="Resolution Status: "_DESC
 ;Restricted edit is same as National
 S:REST TXT="National "_TXT D SET(0,TXT,1)
 ;
 S TXT="Resolution Status Description" D SET(0,TXT,0)
 ;Get Resolution Status description
 S SUB=0,TAB=0,FOUND=0
 F  S SUB=$O(^PXRMD(801.9,D0,1,SUB)) Q:SUB=""  D
 .S X=$G(^PXRMD(801.9,D0,1,SUB,0))
 .D ^DIWP
 F  S SUB=$O(^UTILITY($J,"W",0,SUB)) Q:SUB=""  D
 .D SET(5,^UTILITY($J,"W",0,SUB,0),0) S FOUND=1
 K ^UTILITY($J,"W")
 ;Display no description message
 I 'FOUND S TXT="*NONE*" D SET(5,TXT,0)
 D SET(0,"",1)
 ;
 ;Related National Status from cross reference
 I 'REST D
 .;Get national code from cross reference
 .N IEN S IEN=$O(^PXRMD(801.9,"AC",D0,""))
 .;If none allocated say so
 .I 'IEN S TXT="***UNDEFINED***"
 .;Get name of national status and display
 .I IEN S TXT=$P($G(^PXRMD(801.9,IEN,0)),U)
 .S TXT="Related National Status:  "_TXT D SET(3,TXT,0)
 ;
 ;Abbreviated Name
 S TXT="Abbreviated name:  "_ABBR D SET(10,TXT,0)
 ;Report Column Headings
 S TXT="Report Column Headings:  "_ABBR D SET(4,TXT,0)
 ;Inactive flag
 S TXT="Inactive Flag:  "_$S(INACT:"INACTIVE",1:"") D SET(13,TXT,0)
 ;Creator for local codes
 I CREA,'REST D
 .S TXT="Creator:  "_$$GET1^DIQ(200,CREA,.01) D SET(19,TXT,0)
 ;Local Resolution Statuses
 I REST D
 .N LARRAY,LIEN S SUB=0,FOUND=0
 .F  S SUB=$O(^PXRMD(801.9,D0,10,SUB)) Q:'SUB  D
 ..S LIEN=$P($G(^PXRMD(801.9,D0,10,SUB,0)),U)
 ..I LIEN S LARRAY(LIEN)="",FOUND=1
 .S TXT="Local Resolution Statuses:" D SET(0,"",1),SET(0,TXT,0)
 .I 'FOUND S TXT="*NONE*" D SET(5,TXT,0) Q 
 .S LIEN="" F  S LIEN=$O(LARRAY(LIEN)) Q:'LIEN  D
 ..S TXT=$P($G(^PXRMD(801.9,LIEN,0)),U) D SET(4,TXT,0)
 Q
 ;
 ;Save local array
 ;----------------
SET(TAB,TXT,LF) ;
 ;Save main line
 S IC=IC+1,ARRAY(IC)=$J("",TAB)_TXT
 ;Additional line feeds
 I LF D
 .N CNT F CNT=1:1:LF S IC=IC+1,ARRAY(IC)=$J("",79)
 Q
