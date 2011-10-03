PXRMDLG ; SLC/PJH - Reminder Dialog Edit/Inquiry ;09/14/2009
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;
 ;Labels called from list 'PXRM DIALOG LIST'
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 K ^TMP("PXRMDLG",$J)
 K ^TMP("PXRMDLG4",$J)
 Q
 ;
HDR ; Header code
 S VALMHDR(1)=PXRMHD
 S VALMHDR(2)=""
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HELP ;Help code
 N ORU,ORUPRMT,XQORM,PXRMTAG S PXRMTAG="GDLG"
 D EN^VALM("PXRM DIALOG MAIN HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 ;Delete any sequence numbers without dialogs
 D CHECK
 ;Load details of dialog
 D BUILD(0)
 Q
 ;
PEXIT ;PXRM DIALOG MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up or down
 D XQORM
 Q
 ;
 ;Other Subroutines
 ;
BUILD(INP) ;Build workfile (protocols PXRM DIALOG VIEW/LIST)
 ;
 ;Variable VIEW is set in the calling protocol
 ;
 ;0= DIALOG SUMMARY
 ;1= DIALOG DETAILS
 ;2= DIALOG TEXT
 ;3= PROGRESS NOTE TEXT
 ;4= INQUIRY (ALL FIELDS) - NO LISTMAN
 ;5= DIALOG OVERVIEW
 ;
 N DNAM,DNAME,VIEW
 S VIEW=INP,PXRMMODE=VIEW,VALMCNT=0,VALMBCK="R"
 I VIEW=5 S VALMBG=1
 K ^TMP("PXRMDLG",$J)
 ;Headers
 S DNAM=$P($G(^PXRMD(801.41,PXRMDIEN,0)),U)
 I $P($G(^PXRMD(801.41,PXRMDIEN,0)),U,3)>0 D
 .S DNAM=DNAM_" (Disabled)"
 S PXRMHD="DIALOG NAME: "_DNAM
 I $P($G(^PXRMD(801.41,PXRMDIEN,0)),U,4)="R" D
 .S PXRMHD="REMINDER "_PXRMHD
 I $P($G(^PXRMD(801.41,PXRMDIEN,0)),U,4)="G" D
 .S PXRMHD="DIALOG GROUP NAME: "_DNAM
 I $P($G(^PXRMD(801.41,PXRMDIEN,100)),U)="N" D
 .S PXRMHD=PXRMHD_" [NATIONAL] *LIMITED EDIT*"
 D HDR
 ;
 N DATA,DGRP,DHED,FGLOB,FIEN,FITEM,FNAME,FNUM,FTYP,RESULT,RESNM
 N NATIONAL,OIEN,ONAME,ONUM,PDIS,PIEN,PNAME,PTXT,PTYP,RIEN,RNAME,SEQ,SUB
 ;Build list of finding items
 N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 ;Check if nationalreminder dialog
 S NATIONAL=0 S:$P($G(^PXRMD(801.41,PXRMDIEN,100)),U)="N" NATIONAL=1
 ;Detail view of national dialogs allows only findings to be mapped 
 I VIEW=1,NATIONAL D ^PXRMDLG3,XQORM Q
 ;Build Listman array
 D ARRAY(PXRMDIEN)
 Q
 ;
ARRAY(DIEN) ;Build Dialog Display in list manager
 ;
 N DNLOCK,NLINE,NODE,NSEL
 S NLINE=0,NODE="PXRMDLG",NSEL=0
 K ^TMP("PXRMDLG4",$J)
 ;
 S DNLOCK=$P($G(^PXRMD(801.41,DIEN,100)),U,4)
 ;Group header
 I $P($G(^PXRMD(801.41,DIEN,0)),U,4)="G" D
 .D DLINE^PXRMDLG4(DIEN,"","",NODE)
 ;Other components
 D DETAIL^PXRMDLG4(DIEN,"",VIEW,NODE)
 ;
 ;Headers
 N HDR2
 I VIEW=0 S HDR2="Dialog Summary" I $G(VALMBG)="" S VALMBG=1
 I VIEW=1 S HDR2="Detailed Display"
 I VIEW=2 S HDR2="Dialog Text"
 I VIEW=3 S HDR2="Progress Note Text"
 I VIEW=5 S HDR2="Dialog Overview"
 ;
 ;Create headings
 D CHGCAP^VALM("HEADER1","Item  Seq.")
 D CHGCAP^VALM("HEADER2",HDR2)
 D CHGCAP^VALM("HEADER3","")
 ;
 S VALMCNT=NLINE
 S ^TMP(NODE,$J,"VALMCNT")=VALMCNT
 ;
 D XQORM
 Q
 ;
CHECK ;Search for sequence numbers with no dialog pointer
 N CNT,DA,DCNT,DEL,DELTMP,IEN,NODE,SCNT,SEQ,SEQTMP,SNUM
 S IEN=PXRMDIEN,DEL="",(CNT,DA,SCNT)=0
 F  S DA=$O(^PXRMD(801.41,IEN,10,DA)) Q:+DA=0  S NODE=^PXRMD(801.41,IEN,10,DA,0) D
 . I NODE'[U S CNT=CNT+1 S DELTMP(CNT)=DA
 . I NODE[U S SCNT=SCNT+1 S SEQTMP($P($G(NODE),U),SCNT)=DA
 ;I CNT>0 D DELBLANK(IEN,.DELTMP)
 S (SNUM,SEQ)=0
 F  S SEQ=$O(SEQTMP(SEQ)) Q:SEQ=""  D
 .S DCNT=0 F  S SNUM=$O(SEQTMP(SEQ,SNUM)) Q:+SNUM=0  D
 ..S DCNT=DCNT+1 I DCNT>1 S DELTMP(DCNT)=SEQTMP(SEQ,SNUM) S DEL="Y"
 ;I DEL="Y" D DELBLANK(IEN,.DELTMP)
 Q
 ;
DELBLANK(IEN,DELTMP) ;Delete dialog multiple entry if dialog missing
 N NUM,DA
 S DA(1)=IEN
 S NUM=0
 F  S NUM=$O(DELTMP(NUM)) Q:NUM=""  D 
 . S DA=DELTMP(NUM) Q:'DA
 . S DIK="^PXRMD(801.41,"_DA(1)_",10,"
 . D ^DIK
 K DIK
 Q
 ;
DESC(FIEN) ;Finding description
 ;Determine finding type
 S FGLOB=$P(FIEN,";",2) Q:FGLOB=""
 S FITEM=$P(FIEN,";") Q:FITEM=""
 ;Diagnosis POV
 I FGLOB["ICD9" D  Q
 .S FTYP="DIAGNOSIS",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,3)_" ["_FITEM_"]"
 ;Procedure CPT
 I FGLOB["ICPT" D  Q
 .S FTYP="PROCEDURE",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,2)_" ["_FITEM_"]"
 ;Quick order
 I FGLOB["ORD(101.41" D  Q
 .S FTYP="QUICK ORDER",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,2)_" ["_FITEM_"]"
 ;Short name for finding type
 S FTYP=$G(DEF1(FGLOB)) Q:FTYP=""
 S FNUM=" ["_FTYP_"("_FITEM_")]"
 ;Long name
 S FTYP=$G(DEF2(FTYP))
 S FGLOB=U_FGLOB_FITEM_",0)"
 S FNAME=$P($G(@FGLOB),U,1)
 I FNAME="" S FNAME=$P($G(@FGLOB),U)
 I FNAME]"" S FNAME=FNAME_FNUM Q
 S FNAME=FITEM
 Q
 ;
LIT(INP) ;Find description for dialog type
 Q:INP="G" "Dialog group: "
 Q:INP="F" "Forced value: "
 Q:INP="P" "Prompt: "
 Q:INP="E" "Dialog element: "
 Q "???"
 ;
REMD ;Reminder Details
 N ARRAY,SUB
 ;Change listman headings
 D CHGCAP^VALM("HEADER1","Reminder Inquiry")
 D CHGCAP^VALM("HEADER2","")
 D CHGCAP^VALM("HEADER3","")
 ;Check if dialog is linked to a reminder
 I 'PXRMITEM D  Q
 .S ^TMP("PXRMDLG",$J,2,0)=" *This dialog is not linked to a reminder*"
 ;Build array using print template
 D REMVAR^PXRMINQ(.ARRAY,PXRMITEM)
 ;Copy into Listman global
 S SUB=0
 F  S SUB=$O(ARRAY(SUB)) Q:'SUB  D
 .S VALMCNT=SUB
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=ARRAY(VALMCNT)
 Q
 ;
SEL ;PXRM DIALOG SELECTION ITEM validation
 N ERR,IEN,SEL
 S VALMBCK="",SEL=+$P(XQORNOD(0),"=",2)
 ;Invalid selection
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("IDX",SEL))) D  Q
 .W !,SEL_" is not an existing item number" H 2
 ;Valid selection
 S IEN=$O(@VALMAR@("IDX",SEL,"")) Q:'IEN
 ;Copy/Delete/Edit dialog element
 D IND^PXRMDEDI(IEN,SEL)
 Q
 ;
XQORM ;Protocol Menu reset
 S XQORM("#")=$O(^ORD(101,"B","PXRM DIALOG SELECTION ITEM",0))
 S XQORM("#")=XQORM("#")_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 I PXRMGTYP="DLGE" D
 .N FMENU
 .S FMENU=$O(^ORD(101,"B","PXRM DIALOG GROUP MENU",0))_";ORD(101,"
 .I FMENU S XQORM("HIJACK")=FMENU
 Q
 ;
XHLP(CALL) ;General help text routine.
 N HTEXT
 N DIWF,DIWL,DIWR,IC,X
 S DIWF="C75",DIWL=0,DIWR=75
 ;
 I CALL=1 D
 .S HTEXT(1)="Enter Yes to if you are adding a new sequence number or"
 .S HTEXT(2)="dialog element to this reminder dialog."
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
