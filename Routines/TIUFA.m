TIUFA ; SLC/MAM - LM Template A (DDEFs By Attribute) INIT ;10/26/95  15:33
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
EN ; -- main entry point for Options TIUFA SORT DDEFS CLIN/MGR/NATL
 ; Requires TIUFWHO, set in above options
 N TIUF,TIUFTMPL,TIUFATTR,TIUFAVAL,TIUFSTRT,TIUFVCN1,TIUFXNOD
 N TIUFREDO,X,XQORM,TIUFLFT
 S TIUFTMPL="A",TIUFREDO=0
 N TIUFPRIV D SETUP^TIUFL S:$D(DTOUT) VALMQUIT=1 G:$G(VALMQUIT) ENX
 S TIUFXNOD="^^Sort^"
 S X=^TMP("TIUF",$J,"SORT")_";ORD(101," D EN^XQOR
 G:$D(DTOUT)!'$D(TIUFSTRT) ENX
 I TIUFWHO="C" D EN^VALM("TIUFA SORT DDEFS CLIN")
 I "MN"[TIUFWHO D EN^VALM("TIUFA SORT DDEFS MGR")
ENX Q
 ;
HDR ; -- header code
 ; Requires Attribute TIUFATTR as set in protocols TIUF SORT BY (ALL,
 ;TYPE, OWNER, STATUS, WAY USED, PARENTAGE):
 ;  TIUFATTR = A^ALL, T^TYPE, O^OWNER, S^STATUS, U^WAY USED, P^PARENTAGE;
 ; Requires Attribute Value TIUFAVAL as set in TIUF SORT BY ALL;
 ;TIUF TYPE /CLASS,DOCUMENT CLASS,MULTIAUTHOR DC,DOCUMENT,COMPONENT,NONE;
 ;TIUF OWNER /CLASS,INDIVIDUAL,PERSONAL,NONE; TIUF STATUS /INACTIVE,
 ;TEST,ACTIVE,NONE; TIUF USED BY DOCMTS/YES,NO,NA,UNKNOWN; TIUF PARENTAGE/ORPHAN,NONORPHAN.
 ; e.g. TIUFAVAL =
 ;      ALL^ALL if attribute is ALL;
 ;      CL^CLASS if attribute is Type and Type is Class;
 ;      NONE^NONE if attr is Type and attr value is NONE.
 ;      546^PROVIDER^C if attr is Owner, Kind of Owner is Class Owner,
 ;        and Class Owner is Provider Class (IFN 546).
 ;      0^NONE if attr is Owner, attr value is NONE.
 ;      13^INACTIVE if attr is Status and Status is Inactive (IFN 13).
 ;      0^NONE if attr is Owner and Owner is NONE.
 ;      YES if attr is Way Used and Way Used is YES:
 ;        YES/NO/NA
 ;      O^ORPHAN if attr is ORPHAN and attr value is Orphan.
 ;      N^NONORPHAN if attr  is ORPHAN and attr value is Nonorphan.
 ; Requires TIUFSTRT = e.g. " ^ZZZZZZZZ" as set in SELSTART^TIUFLA.
 N ATTR1,HDR2,MODE,OWN,FROM,TO,HDR3,VHDR1,VHDR2
 S ATTR1=$P(TIUFATTR,U)
 I ATTR1="T" S HDR2=$S($P(TIUFAVAL,U)'="NONE":" of Type "_$P(TIUFAVAL,U,2),1:" with NO Type")
 I ATTR1="O" S MODE=$P(TIUFAVAL,U,3),OWN=$P(TIUFAVAL,U,2) D
 . S HDR2=$S(MODE="P":" Personally Owned by "_OWN,MODE="C":" Owned by Class "_OWN,MODE="I":" Owned by Individual "_OWN,1:" with No Owner")
 I ATTR1="S" S HDR2=$S($P(TIUFAVAL,U)'="N":" of Status "_$P(TIUFAVAL,U,2),1:" with NO Status")
 S FROM=$S($P(TIUFSTRT,U)=" ":"FIRST",1:$P(TIUFSTRT,U))
 S TO=$S($P(TIUFSTRT,U)=" ":"LAST",$P(TIUFSTRT,U,2)="ZZZZZZZZ":"LAST",1:$P(TIUFSTRT,U,2))
 S HDR3=$S(TIUFSTRT'=" ^ZZZZZZZZ":" from "_FROM_" to "_TO,1:"")
 I ATTR1="U" S MODE=TIUFAVAL D
 . S HDR2=$S(MODE="YES":" In Use",1:" NOT In Use")
 . I HDR3'="" S HDR2=HDR2_","
 I ATTR1="P" S HDR2=$S($P(TIUFAVAL,U)="O":" which are ORPHANS",1:" which are NOT ORPHANS")
 I "TOSUP"[ATTR1 S VALMHDR(1)=$$CENTER^TIUFL("Entries"_HDR2_HDR3,79)
 I ATTR1="A" S VALMHDR(1)=$$CENTER^TIUFL("ALL Entries"_$S(HDR3'="":", "_HDR3,1:""),79)
HDRX ;
 Q
 ;
INIT ; -- init variables and list array. Called by Templates A and J AND by Subtemplates.
 ; Requires TIUFATTR, TIUFAVAL, TIUFSTRT.  See HDR^TIUFA
 K ^TMP("TIUF1",$J),^TMP("TIUF1IDX",$J),^TMP("TIUFB",$J),^TMP("TIUFBIDX",$J)
 I '$D(TIUFSTMP) D CLEAN^VALM10 ; Clean IF called from active Template.
 N LINENO,STRTNM,ENDNM,FILEDA,NAME,PASTEND
 I '$D(TIUFSTMP) S VALM("TITLE")=$S(TIUFTMPL="J":"Objects",$P(TIUFATTR,U)'="A":"Sort by "_$S($P(TIUFATTR,U,2)="WAY USED":"IN USE Value",1:$P(TIUFATTR,U,2)),1:"ALL Document Definitions")
 S (TIUFVCN1,LINENO)=0,STRTNM=$P(TIUFSTRT,U),ENDNM=$P(TIUFSTRT,U,2)
 I $O(^TIU(8925.1,"B",STRTNM,"")) D
 . S FILEDA=""
 . F  S FILEDA=$O(^TIU(8925.1,"B",STRTNM,FILEDA)) Q:'FILEDA  D INIT1
 G:$D(DTOUT) INITX
 S NAME=STRTNM
 F  S NAME=$O(^TIU(8925.1,"B",NAME)) Q:NAME=""  D  Q:$G(PASTEND)  G:$D(DTOUT) INITX
 . I NAME]ENDNM S PASTEND=1 Q
 . S FILEDA=""
 . F  S FILEDA=$O(^TIU(8925.1,"B",NAME,FILEDA)) Q:'FILEDA  D INIT1
 . Q
 I LINENO D UPDATE^TIUFLLM1("A",LINENO,0) S TIUFVCN1=TIUFVCN1+LINENO
INITX ;
 S:$D(DTOUT) VALMQUIT=1
 S:'$D(TIUFSTMP) VALMCNT=TIUFVCN1
 Q
 ;
INIT1 ; Puts FILEDA in Buffer array.
 N NODE0,INFO
 Q:'$D(^TIU(8925.1,FILEDA,0))
 Q:'$$MATCH^TIUFLA(FILEDA)
 S LINENO=LINENO+1 ; Needed for NINFO.
 D NINFO^TIUFLLM(LINENO,FILEDA,.INFO),PARSE^TIUFLLM(.INFO),NODE0ARR^TIUFLF(FILEDA,.NODE0) Q:$D(DTOUT) 
 I NODE0="" W !!," Entry "_FILEDA_" in 'B' Cross Reference does not exist in the file; See IRM",! D PAUSE^TIUFXHLX S LINENO=LINENO-1 Q
 D BUFENTRY^TIUFLLM2(.INFO,.NODE0,TIUFTMPL) W "."
 Q
 ;
EXIT ; -- exit code
 K ^TMP("TIUF1",$J),^TMP("TIUFB",$J),^TMP("TIUF1IDX",$J),^TMP("TIUFBIDX",$J),^TMP("TIUF",$J),IOELALL
 D CLEAN^VALM10
 Q
 ;
