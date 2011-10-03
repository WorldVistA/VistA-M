PXRMDLGH ; SLC/PJH - Reminder Dialog History ;08/16/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Called from PXRMDLGZ
 ;
START(PXRMITEM,PXRMDIEN,PXRMNAM) ;
 N PXRMBG,PXRMLINK,PXRMREAD,PXRMSRC,PXRMVARM
 N VALM,VALMAR,VALMBCK,VALMBG,VALMCNT,VALMHDR,VALMSG,X,XMZ
 S X="IORESET",PXRMLINK=$P($G(^PXD(811.9,PXRMITEM,51)),U),PXRMDIEN=""
 D ENDR^%ZISS,EN^VALM("PXRM DIALOG HISTORY")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;Labels called from list 'PXRM DIALOG HISTORY'
 ;
EXIT ;Exit code
 D CLEAN^VALM10,FULL^VALM1
 S VALMBCK="Q"
 K ^TMP("PXRMDLGH",$J)
 Q
 ;
HDR ; Header code
 S VALMHDR(1)=PXRMHD
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
HELP ;Help code
 N ORU,ORUPRMT,XQORM,PXRMTAG
 S PXRMTAG="GDLGH"
 D EN^VALM("PXRM DIALOG MAIN HELP")
 Q
 ;
INIT ;Init
 S VALMCNT=0
 ;Get linked dialog
 S PXRMLINK=$P($G(^PXD(811.9,PXRMITEM,51)),U)
 ;Load details of reminder dialog
 D BUILD(PXRMITEM,PXRMLINK)
 ;Reset Menu
 D XQORM
 Q
 ;
PEXIT ;PXRM DIALOG HISTORY MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 D XQORM
 Q
 ;
 ;Other Subroutines
 ;
 ;Build workfile (Entry action for protocol PXRM DIALOG HISTORY)
BUILD(PXRMITEM,PXRMLINK) ;
 ;
 N ARRAY,DARRAY,DDAT,DIEN,DNAM,DSEQ,FIRST,HDR,RIEN,RNAM,TXT
 ;Clear existing file
 S VALMCNT=0,VALMBCK="R",FIRST=1,DSEQ=0 K ^TMP("PXRMDLG",$J)
 ;Get the linked dialog first
 I PXRMLINK D
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",79)
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)="This reminder is linked to dialog:"
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",79)
 .D SET(PXRMITEM,PXRMLINK)
 .;Get list of other reminders and display
 .D OTHER(PXRMLINK),OLST("")
 ;
 ;Then other dialogs generated from this reminder (ALPHA order)
 S DIEN=""
 F  S DIEN=$O(^PXRMD(801.41,"AG",PXRMITEM,DIEN)) Q:'DIEN  D
 .Q:DIEN=PXRMLINK
 .S DNAM=$P($G(^PXRMD(801.41,DIEN,0)),U) Q:DNAM=""
 .S DARRAY(DNAM)=DIEN
 ;
 S DNAM="",HDR=1
 F  S DNAM=$O(DARRAY(DNAM)) Q:DNAM=""  D
 .S DIEN=DARRAY(DNAM) Q:'DIEN
 .S RIEN=$P($G(^PXD(811.9,DIEN,51)),U),FIRST=1
 .;Get list of other reminders
 .D OTHER(DIEN)
 .;Other dialogs header
 .I HDR D
 ..S VALMCNT=VALMCNT+1
 ..S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",79)
 ..S VALMCNT=VALMCNT+1
 ..S ^TMP("PXRMDLG",$J,VALMCNT,0)="Other dialogs generated from this reminder:"
 ..S VALMCNT=VALMCNT+1,HDR=0
 ..S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",79)
 .;If this reminder isn't linked display the one that is
 .I 'RIEN D
 ..N RNAM
 ..S RNAM=$O(ARRAY("")) Q:RNAM=""
 ..S RIEN=$G(ARRAY(RNAM)) S:RIEN FIRST=0
 .;Dialog detail
 .D SET(RIEN,DIEN)
 .;Additional reminder detail
 .S:FIRST RIEN="" D OLST(RIEN)
 ;
 I VALMCNT=0 D
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)="    * NO DIALOGS DEFINED *"
 ;
 S VALMCNT=VALMCNT+1
 S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",79)
 S ^TMP("PXRMDLG",$J,"VALMCNT")=VALMCNT
 ;
 Q
 ;
OTHER(DIEN) ;Other reminders linked to this dialog
 N DLG,DNAM,RNAM,RSUB
 ;Linked reminders
 S RNAM="" K ARRAY
 F  S RNAM=$O(^PXD(811.9,"B",RNAM)) Q:RNAM=""  D
 .S RSUB=$O(^PXD(811.9,"B",RNAM,"")) Q:'RSUB  D
 ..S DLG=$P($G(^PXD(811.9,RSUB,51)),U) Q:DLG'=DIEN
 ..S RNAM=$P($G(^PXD(811.9,RSUB,0)),U) Q:RNAM=""
 ..S ARRAY(RNAM)=RSUB
 Q
 ;
OLST(REM) ;List Other Reminders
 N RNAM
 S RNAM=""
 F  S RNAM=$O(ARRAY(RNAM)) Q:RNAM=""  D
 .Q:ARRAY(RNAM)=REM  Q:ARRAY(RNAM)=PXRMITEM
 .S VALMCNT=VALMCNT+1
 .S ^TMP("PXRMDLG",$J,VALMCNT,0)=$J("",59)_RNAM
 Q
 ;
SET(RIEN,DIEN) ;
 N RNAM,DNAM,DDAT
 S RNAM="*NONE*",DSEQ=DSEQ+1
 ;Dialog details
 S DNAM=$P($G(^PXRMD(801.41,DIEN,0)),U)
 S DDAT=$P($G(^PXRMD(801.41,DIEN,99)),U,1)
 S:DDAT="" DDAT=$P($G(^PXRMD(801.41,DIEN,99)),U,2)
 S DDAT=$$FMTE^XLFDT(DDAT,"1D")
 ;Reminder details
 I RIEN D
 .S RNAM=$P($G(^PXD(811.9,RIEN,0)),U)
 .I RIEN=PXRMITEM S RNAM=""
 ;Update display
 S TXT=$J(DSEQ,4)_"  "_$E(DNAM,1,32)_$J("",32-$L(DNAM))
 S TXT=TXT_" "_DDAT_$J("",20-$L(DDAT))_RNAM
 S VALMCNT=VALMCNT+1
 S ^TMP("PXRMDLG",$J,VALMCNT,0)=TXT
 S ^TMP("PXRMDLG",$J,"IDX",DSEQ,DIEN)=""
 Q
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM SELECTION ITEM",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Item: "
 Q
