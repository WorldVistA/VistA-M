PXRMSHF ; SLC/PJH - Edit/Inquire Health Factor Resolutions ;03/17/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
START N DIC,PXRMGTYP,PXRMHD,PXRMSHF,Y
SELECT ;General selection
 S PXRMHD="Health Factor Resolutions",PXRMGTYP="SHFR",PXRMSHF=""
 D START^PXRMSEL(PXRMHD,PXRMGTYP,"PXRMSHF")
 ;Should return a value
 I PXRMSHF D  G SELECT
 .S PXRMHD="HEALTH FACTOR NAME:"
 .;Listman option
 .D START^PXRMGEN(PXRMHD,PXRMGTYP,PXRMSHF)
 ;
END Q
 ;
 ;List all HF resolutions (for protocol PXRM SELECTION LIST)
 ;-----------------------
ALL N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,NOW,TO,Y
 S Y=1
 D SET
 S DIC="^PXRMD(801.95,"
 S BY=".01"
 S FR=""
 S TO=""
 S DHD="W ?0 D HED^PXRMSHF"
 D DISP
 Q
 ;
 ;Inquire/Print Option (for protocol PXRM GENERAL INQUIRE/PRINT)
 ;--------------------
INQ(Y) N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,NOW,TO
 S DIC="^PXRMD(801.95,"
 S DIC(0)="AEMQ"
 D SET
 D DISP
 Q
 ;
 ;Display Header (see DHD variable)
 ;--------------
HED N TEMP,TEXTLEN,TEXTHED,TEXTUND
 S TEXTHED="HEALTH FACTOR RESOLUTION LIST"
 S TEXTUND=$TR($J("",IOM)," ","-")
 S TEMP=NOW_"  Page "_DC
 S TEXTLEN=$L(TEMP)
 W TEXTHED
 W ?(IOM-TEXTLEN),TEMP
 W !,TEXTUND,!!
 Q
 ;
 ;DISPLAY (Display from FLDS array)
 ;-------
DISP S L=0,FLDS="[PXRM HEALTH FACTOR RESOLUTIONS]"
 D EN1^DIP
 Q
 ;
SET ;Setup all the variables
 ; Set Date for Header
 S NOW=$$NOW^XLFDT
 S NOW=$$FMTE^XLFDT(NOW,"1P")
 ;
 ;These variables need to be setup every time because DIP kills them.
 S BY="NUMBER"
 S (FR,TO)=+$P(Y,U,1)
 S DHD="W ?0 D HED^PXRMSHF"
 ;
 Q
 ;
 ;Build display for selected HF - Called from PXRMGEN
 ;---------------------------------------------------
SHFR(PXRMSHFR) ;
 N DATA,DARRAY,SUB
 S VALMCNT=0 K ^TMP("PXRMGENS",$J),^TMP("PXRMGEN",$J)
 ;
 ;Format headings to include Health Factor name
 S HEADER=PXRMHD_" "_$P(^AUTTHF(PXRMSHF,0),U)_" - HF("_PXRMSHF_")"
 ;
 ;Build HF Resolutions Display
 D BUILD(.DARRAY,PXRMSHFR)
 Q
 ;
 ;Build Health Factor Resolutions Inquiry array
 ;---------------------------------------------
BUILD(ARRAY,D0) ;
 N DATA,LCT,RDES,RIEN,SUB
 S VALMCNT=0 K ^TMP("PXRMGENS",$J),^TMP("PXRMGEN",$J)
 ;
 S SUB=0
 ;Loop through all the resolution statuses
 F  S SUB=$O(^PXRMD(801.95,IEN,1,SUB)) Q:'SUB  D
 .;Get ien for resolution status
 .S RIEN=$P($G(^PXRMD(801.95,IEN,1,SUB,0)),U) Q:RIEN=""
 .;Get description
 .S RDES=$P($G(^PXRMD(801.9,RIEN,0)),U) I RDES="" S RDES=RIEN
 .;Save Resolution in alpha order
 .S ^TMP("PXRMGENS",$J,RDES)=SUB
 ;
 ;Put the list into the array List Manager is using.
 S RDES="",LCT=0
 S VALMCNT=0
 F  S RDES=$O(^TMP("PXRMGENS",$J,RDES)) Q:RDES=""  D
 .S DATA=$G(^TMP("PXRMGENS",$J,RDES))
 .S VALMCNT=VALMCNT+1,LCT=LCT+1
 .S ^TMP("PXRMGEN",$J,VALMCNT,0)=" "_RDES
 .S ^TMP("PXRMGEN",$J,"VALMCNT")=VALMCNT
 K ^TMP("PXRMGENS",$J)
 ;Create headings
 D CHGCAP^VALM("HEADER1","Resolution Status")
 D CHGCAP^VALM("HEADER2","")
 D CHGCAP^VALM("HEADER3","")
 Q
