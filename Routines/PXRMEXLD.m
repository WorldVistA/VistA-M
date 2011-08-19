PXRMEXLD ;SLC/PJH - Reminder Dialog Exchange Main Routine. ;04/28/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
START N PXRMBG,PXRMMODE,VALMBCK,VALMBG,VALMCNT,VALMSG,X,XMZ
 S X="IORESET"
 D EN^VALM("PXRM EX LIST DIALOG")
 ;Rebuild Display
 D CDISP^PXRMEXLC(PXRMRIEN)
 K ^TMP("PXRMEXDGH",$J)
 Q
 ;
ENTRY ; Entry point for List Manager
 D FIND Q
 ;
DETAIL ;Detailed display
 S PXRMMODE=0 D DISP(PXRMMODE) Q
 ;
FIND ;Display findings
 S PXRMMODE=2 D DISP(PXRMMODE) Q
 ;
SUM ;Display dialog summary
 S PXRMMODE=3 D DISP(PXRMMODE) Q
 ;
USE ;Display dialog usage
 S PXRMMODE=4 D DISP(PXRMMODE) Q
 ;
TEXT ;Display dialog text
 S PXRMMODE=1 D DISP(PXRMMODE) Q
 ;
EXIT ;
 K ^TMP("PXRMEXLD",$J)
 K ^TMP("PXRMEXDGH",$J)
 Q
 ;
DISP(VIEW) ;Build the requested view and display it.
 D BLDDISP^PXRMEXDB(VIEW)
 ;Change header
 I VIEW=0 D CHGCAP^VALM("HEADER2","Dialog Details")
 I VIEW=1 D CHGCAP^VALM("HEADER2","Dialog Text")
 I VIEW=2 D CHGCAP^VALM("HEADER2","Dialog Findings")
 I VIEW=3 D CHGCAP^VALM("HEADER2","Dialog Summary")
 I VIEW=4 D CHGCAP^VALM("HEADER2","Dialog Usage")
 S VALMCNT=^TMP("PXRMEXLD",$J,"VALMCNT"),VALMBG=1,VALMBCK="R"
 ;Reset protocol
 D XQORM
 Q
 ;
HELP ;
 N ORU,ORUPRMT,XQORM,PXRMTAG
 S PXRMTAG="DLG"
 D EN^VALM("PXRM EX DIALOG HELP")
 Q
 ;
HDR ;
 S VALMHDR(1)="Packed reminder dialog: "
 S VALMHDR(1)=VALMHDR(1)_$G(^TMP("PXRMEXTMP",$J,"PXRMDNAME"))
 I $D(^TMP("PXRMEXTMP",$J,"PXRMDNAT")) S VALMHDR(1)=VALMHDR(1)_" [NATIONAL DIALOG]"
 S VALMHDR("TITLE")=VALMHDR(1)
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
PEXIT ;PXRM EXCH DIALOG MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
VALID(STRING) ;Validate sequence numbers
 N CNT,FOUND,OK
 S FOUND=0,OK=1
 F CNT=1:1 S SEL=$P(STRING,",",CNT) Q:'SEL  D
 .;Invalid selection
 .I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("SEL",SEL))) D  Q
 ..S OK=0 W $C(7),!,SEL_" is not a valid item number." H 2
 .S FOUND=1
 Q:OK&FOUND 1
 Q 0
 ;
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXCH SELECT DIALOG",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Action: "
 Q
 ;
XSEL ;PXRM EXCH SELECT DIALOG validation
 N ALL,CNT,ERR,IEN,IND,NAME,PXRMDONE,SELECT,SEL
 S ALL="",PXRMDONE=0,PXRMBG=$G(VALMBG)
 ;Invalid selection
 S SELECT=$P(XQORNOD(0),"=",2) I '$$VALID(SELECT) S VALMBCK="R" Q
 ;
 ;Sort the SELECTION into reverse order
 D ORDER^PXRMEXLC(.SELECT,-1)
 ;
 ;Lock the file
 I '$$LOCK^PXRMEXID S VALMBCK="R" Q
 ;
 S NAME=$G(^TMP("PXRMEXTMP",$J,"PXRMDNAME"))
 ;Install dialog component(s)
 S CNT=0
 F CNT=1:1 S SEL=$P(SELECT,",",CNT) Q:'SEL  D  Q:PXRMDONE
 .D INSCOM^PXRMEXID(NAME,SEL,0)
 ;
 ;Unlock file
 D UNLOCK^PXRMEXID
 ;
 ;Rebuild Workfile
 D DISP^PXRMEXLD(PXRMMODE)
 ;
 ;Refresh
 S VALMBCK="R" I $D(PXRMBG) S VALMBG=PXRMBG
 Q
