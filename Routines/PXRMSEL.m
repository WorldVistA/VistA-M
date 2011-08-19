PXRMSEL ; SLC/PJH - PXRM Selection ;01/04/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Selection screen for all dialog files
 ;
START(HEADER,PXRMGTYP,PXRMNAM) ;
 N PXRMREAD,PXRMSHD,PXRMSRC,PXRMVARM
 N VALM,VALMAR,VALMBCK,VALMBG,VALMCNT,VALMHDR,VALMSG,X,XMZ
 S X="IORESET"
 D ENDR^%ZISS,EN^VALM("PXRM SELECTION")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;Labels called from list 'PXRM SELECTION'
 ;
 ;Add new entry
ADD ;
 N ANS,ARRAY,ARRAYN,DIROUT,DIRUT,DTOUT,DUOUT
 ;Health factor resolutions
 I PXRMGTYP="SHFR" D  Q:$D(DTOUT)!$D(DUOUT)  Q:ANS="A"
 .D ^PXRMSEL2 S:$D(DUOUT) VALMBCK="R"
 ;Add entry
 D ADD^PXRMGEDT(PXRMGTYP),INIT
 Q
 ;
 ;Copy any dialog
COPY D ANY^PXRMDCPY
 D:PXRMGTYP="DLGE" INIT
 Q
 ;
 ;Copy selected reminder dialog
COPYS N DIC,DUOUT,DTOUT,DIROUT,DIRUT,X,Y
 D SEL^PXRMDCPY(PXRMDIEN,"")
 Q
 ;
 ;Change dialog view
CHNG K PXRMBG D SEL^PXRMSEL2(.PXRMDTYP),INIT
 Q
 ;
 ;Change reminder view
CHNGR(VIEW) ;
 S $E(PXRMVIEW)=VIEW K PXRMBG
 D INIT
 Q
 ;
 ;Toggle view name/print name 
CHNGV N VIEW
 S VIEW=$E(PXRMVIEW,2)
 I VIEW="P" S $E(PXRMVIEW,2)="N"
 I VIEW="N" S $E(PXRMVIEW,2)="P"
 D INIT
 Q
 ;
 ;Change between dialog view and reminder view
DIDL(VIEW) ;
 K PXRMBG S PXRMGTYP=VIEW
 D INIT
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10,FULL^VALM1
 S VALMBCK="Q"
 K ^TMP("PXRMSEL",$J)
 Q
 ;
HDR ; Header code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Non-Dialog options
 I PXRMGTYP'["DLG" S VALMHDR(1)=HEADER Q
 ;Dialog Options
 S VALM("TITLE")=PXRMHD,VALMHDR(1)=PXRMSHD
 Q
 ;
HELP ;Help code
 N ORU,ORUPRMT,XQORM,PXRMTAG S PXRMTAG=PXRMGTYP
 D EN^VALM("PXRM DIALOG MAIN HELP")
 S VALMBCK="R"
 Q
 ;
INIT ;Init
 D CLEAN^VALM10
 S VALMCNT=0
 D BUILD
 D XQORM
 ;
 ;Set header and title for dialog options
 I PXRMGTYP["DLG" D
 .S PXRMHD="Dialog List",PXRMSHD="DIALOG VIEW ("
 .I PXRMGTYP="DLGE" D
 ..I PXRMDTYP="E" S PXRMSHD=PXRMSHD_"DIALOG ELEMENTS)"
 ..I PXRMDTYP="F" S PXRMSHD=PXRMSHD_"FORCED VALUES)"
 ..I PXRMDTYP="G" S PXRMSHD=PXRMSHD_"DIALOG GROUPS)"
 ..I PXRMDTYP="P" S PXRMSHD=PXRMSHD_"ADDITIONAL PROMPTS)"
 ..I PXRMDTYP="S" S PXRMSHD=PXRMSHD_"RESULT GROUPS)"
 ..I PXRMDTYP="T" S PXRMSHD=PXRMSHD_"RESULT ELEMENT)"
 .I PXRMGTYP="DLG" D
 ..S PXRMSHD=PXRMSHD_"REMINDER DIALOGS - "
 ..I $E(PXRMVIEW,2)="N" S PXRMSHD=PXRMSHD_"SOURCE REMINDER NAME)"
 ..I $E(PXRMVIEW,2)="P" S PXRMSHD=PXRMSHD_"SOURCE REMINDER PRINT NAME)"
 .I PXRMGTYP="DLGR" D
 ..S PXRMSHD="REMINDER VIEW ("
 ..I PXRMVIEW="AN" S PXRMSHD=PXRMSHD_"ALL REMINDERS BY NAME)"
 ..I PXRMVIEW="AP" S PXRMSHD=PXRMSHD_"ALL REMINDERS BY PRINT NAME)"
 ..I PXRMVIEW="LN" S PXRMSHD=PXRMSHD_"LINKED REMINDERS BY NAME)"
 ..I PXRMVIEW="LP" S PXRMSHD=PXRMSHD_"LINKED REMINDERS BY PRINT NAME)"
 .;Restore original place
 .S:$G(PXRMBG) VALMBG=PXRMBG
 .S VALMHDR(1)=PXRMSHD,VALM("TITLE")=PXRMHD
 ;
 S VALMBCK="R"
 Q
 ;
 ;
BUILD ;Build selection list
 ;
 D ^PXRMSEL1
 Q
 ;
LIST ;List All option
 W IORESET
 I PXRMGTYP["DLG" D ALL^PXRMDLST
 I PXRMGTYP="DTAX" D ALL^PXRMTDLG
 I PXRMGTYP="FIP" D ALL^PXRMFIP
 I PXRMGTYP="FPAR" D ALL^PXRMFLST
 I PXRMGTYP="RCAT" D ALL^PXRMCLST
 I PXRMGTYP="RESN" D ALL^PXRMSLST
 I PXRMGTYP="SHFR" D ALL^PXRMSHF
 ;
 N DIR S DIR(0)="E" D ^DIR
 ; 
 D XQORM
 S VALMBCK="R"
 Q
 ;
PEXIT ;PXRM SELECTION MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
SEL ;PXRM SELECT ITEM validation
 N ERR,IEN,SEL
 S VALMBCK="",SEL=+$P(XQORNOD(0),"=",2)
 ;Invalid selection
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("IDX",SEL))) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 ;Valid selection
 S IEN=$O(@VALMAR@("IDX",SEL,"")) Q:'IEN
 S VALMBCK="Q",@PXRMNAM=IEN
 ;Save place - reminder link only
 I PXRMGTYP["DLG" S PXRMBG=VALMBG
 Q
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM SELECTION ITEM",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 ;For finding type parameters dissallow add option
 I ((PXRMGTYP="FPAR")&(+$G(PXRMINST)=0))!(PXRMGTYP="DTAX") D
 .N FMENU
 .S FMENU=$O(^ORD(101,"B","PXRM FINDING SELECTION MENU",0))_";ORD(101,"
 .I FMENU S XQORM("HIJACK")=FMENU
 ;For dialog edit allow extra options
 I PXRMGTYP="DLGE" D
 .N FMENU
 .S FMENU=$O(^ORD(101,"B","PXRM DIALOG SELECTION MENU (DLGE)",0))_";ORD(101,"
 .I FMENU S XQORM("HIJACK")=FMENU
 ;For reminder dialog edit allow change view
 I PXRMGTYP="DLG" D
 .N FMENU
 .S FMENU=$O(^ORD(101,"B","PXRM DIALOG SELECTION MENU (DLG)",0))_";ORD(101,"
 .I FMENU S XQORM("HIJACK")=FMENU
 ;Reminder to dialog link
 I PXRMGTYP="DLGR" D
 .N FMENU
 .S FMENU=$O(^ORD(101,"B","PXRM DIALOG/REMINDER MENU",0))_";ORD(101,"
 .I FMENU S XQORM("HIJACK")=FMENU
 Q
 ;
 ;Select single HF or all HF's for the reminder
 ;---------------------------------------------
ZOPT(TYPE) ;
 N X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"I:Individual Health Factor;"
 S DIR(0)=DIR(0)_"A:All Health Factors for a Selected Reminder;"
 S DIR("A")="SELECTION OPTION"
 S DIR("B")="I"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D ZHELP^PXRMSEL(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYPE=Y
 Q
 ;
 ;Reminder selection
 ;------------------
ZREM(ARRAY) ;
 N X,Y,CNT,FSUB,FHF,FIND,FNAM,FOUND,REM
 K DIROUT,DIRUT,DTOUT,DUOUT
 S FOUND=0
 W !
 F  D  Q:$D(DTOUT)  Q:$D(DUOUT)  Q:FOUND
 .S DIC=811.9,DIC(0)="AEMQZ"
 .D ^DIC K DIC S:X=(U_U) DTOUT=1 Q:$D(DTOUT)!$D(DUOUT)!(+Y=-1)
 .;Reminder ien
 .S REM=$P(Y,U) Q:'REM
 .;Get health factor findings on this reminder
 .S FSUB=0
 .F  S FSUB=$O(^PXD(811.9,REM,20,FSUB)) Q:'FSUB  D
 ..S FIND=$P($G(^PXD(811.9,REM,20,FSUB,0)),U)
 ..Q:$P(FIND,";",2)'="AUTTHF("
 ..S FHF=$P(FIND,";") Q:'FHF
 ..S FNAM=$P($G(^AUTTHF(FHF,0)),U) Q:FNAM=""
 ..;Save array used by PXRMGEDT
 ..S FOUND=FOUND+1
 ..S ARRAY(FNAM)=FHF,ARRAYN(FHF)=""
 .I 'FOUND W !!,"No health factor findings on this reminder",! Q
 .S FNAM=""
 .W !!,"HEALTH FACTORS:",!
 .F  S FNAM=$O(ARRAY(FNAM)) Q:FNAM=""  D
 ..S FHF=$P(ARRAY(FNAM),U)
 ..W !,FNAM W:$D(^PXRMD(801.95,FHF,0)) " (Resolution defined)"
 .W !
 Q
 ;
 ;Reminders Health Factors
 ;------------------------
ZSKIP N ANS,FNAM,FHF,EXISTS,TEXT
 S FNAM=""
 F  S FNAM=$O(ARRAY(FNAM)) Q:FNAM=""  D  Q:$D(DUOUT)!$D(DTOUT)
 .S FHF=ARRAY(FNAM),EXISTS=$D(^PXRMD(801.95,FHF,0))
 .I 'EXISTS S TEXT="ADD resolution status for "_FNAM_": "
 .I EXISTS S TEXT="MODIFY resolution status for "_FNAM_": "
 .;Option to ADD/MODIFY
 .D ZASK(.ANS,TEXT) Q:$D(DTOUT)!$D(DUOUT)  Q:(ANS'="Y")
 .;Force entry of HF into 801.95
 .I 'EXISTS D
 ..N DA,DIC,DIK,DR
 ..;Store the unique name
 ..S DR=".01///"_FNAM,DIE="^PXRMD(801.95,",DA=FHF
 ..D ^DIE
 ..;Reindex the cross-references.
 ..S DIK="^PXRMD(801.95,",DA=FHF
 ..D IX^DIK
 .;Edit
 .D EDIT^PXRMGEDT(PXRMGTYP,FHF,1)
 Q
 ;
 ;Ask ADD/MODIFY or not
 ;---------------------
ZASK(YESNO,TEXT) ;
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")=TEXT
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D ZHELP^PXRMSEL(2)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;General help text routine.
 ;--------------------------
ZHELP(CALL) ;
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C75",DIWL=0,DIWR=75
 ;
 I CALL=1 D
 .S HTEXT(1)="Enter I to select an individual health factor. Enter A to"
 .S HTEXT(2)="process all health factor findings on a selected reminder."
 I CALL=2 D
 .S HTEXT(1)="Enter Yes to enter resolution status for this health"
 .S HTEXT(2)="factor. Enter No to continue to the next health factor."
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
