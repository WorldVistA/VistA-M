RCTCSJS1 ;ALBANY/LEG - RCTCS REFERRAL REJECTS SUPPORT RTN;02/19/14 3:21 PM
V ;;4.5;Accounts Receivable;**301,324**;Mar 20, 1995;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;Overflow Program for RCTCSJS, to process CS REJECT server messages from AITC
 ;
 ;Patch PRCA*4.5*324 Modify internal resolution of reject reason
 ;                   display on profile view of bills
 ;
 ;Variables
 ; Input
 ; XMZ - (r) MailMan internal message number (IEN)
 ; 
 ;;RCTCS REFERRAL REJECTS SUPPORT RTN
 ;===============================================================================
 Q  ; 
PROFRJ(D0) ; displays Reject History on ACCOUNT RECEIVABLE PROFILE
 ;
 ; display summary
 K ARY N CDINT
 I '$D(^PRCA(430,D0,18)) Q  ;
 W !,"CS REJECTS:" S D1=0
 ; collapses rejects records 
 F  S D1=$O(^PRCA(430,D0,18,D1)) Q:'D1  D  ;
 . S RJREC=^PRCA(430,D0,18,D1,0)
 . S FDAT=$P(RJREC,"^")   ; date
 . S SRCE=$P(RJREC,"^",2) ;source
 . S ERRCDS=$S($D(ARY(FDAT,SRCE)):ARY(FDAT,SRCE),1:",")
 . F PC=3:1:11 S ERRCD=$P(RJREC,"^",PC) Q:'$L(ERRCD)  D  ;
 . . S ARY(FDAT,SRCE,PC)=$P($G(^RC(348.5,ERRCD,0)),"^")_U_ERRCD,ERRCD=$P($G(^RC(348.5,ERRCD,0)),U)   ;PRCA*4.5*324
 . . I ERRCDS'[(","_ERRCD_",") S ERRCDS=ERRCDS_ERRCD_","
 . S ARY(FDAT,SRCE)=ERRCDS
 . ;
 S FDAT=""
 F  S FDAT=$O(ARY(FDAT)),SRCE="" Q:FDAT=""  D  ; 
 . S Y=FDAT D DD^%DT S EXTDAT=Y ; 
 . F  S SRCE=$O(ARY(FDAT,SRCE)),CDIDX="" Q:SRCE=""  D  ;
 . . S ERRCDS=$TR($E(ARY(FDAT,SRCE),2,$L(ARY(FDAT,SRCE))-1),",","-")
 . . W ?12,"DATE: ",EXTDAT
 . . W ?33,"CODE(s): ",ERRCDS
 . . W ?71,"SOURCE: ",SRCE
 . W !
 ;
 ; display detail
 S FDAT="" N CDINT
 F  S FDAT=$O(ARY(FDAT)),SRCE="" Q:FDAT=""  D  ;
 . S Y=FDAT D DD^%DT S EXTDAT=Y ;
 . F  S SRCE=$O(ARY(FDAT,SRCE)),CDIDX="" Q:SRCE=""  D  ; 
 . . W !!,"CS REJECT DATE:",?16,EXTDAT
 . . W ?34,"REJECT SOURCE: ",SRCE
 . . F RR=1:1 S CDIDX=$O(ARY(FDAT,SRCE,CDIDX)) Q:CDIDX=""  D  ;
 . . . W !?2,"REJECT REASON",RR,":"
 . . . W ?18,$P(ARY(FDAT,SRCE,CDIDX),U) S CDINT=$P(ARY(FDAT,SRCE,CDIDX),U,2) ; code   ;PRCA*4.5*324
 . . . S (X,DESC)=$P(^RC(348.5,CDINT,0),"^",2)_"~"_$G(^RC(348.5,CDINT,1))   ;PRCA*4.5*324
 . . . I $L(DESC)<60 S ARY(FDAT,SRCE,CDIDX,1)=X
 . . . I $L(DESC)>59 D  ;
 . . . . F LN=1:1 S STR=$E(X,1,59) D  Q:'$L(X)  ;
 . . . . . I $L(X)<60 S ARY(FDAT,SRCE,CDIDX,LN)=X,X="" Q
 . . . . . F L=$L(STR):-1:1 I $F(STR," ",L) S ARY(FDAT,SRCE,CDIDX,LN)=$E(X,1,L),X=$E(X,L+1,999) Q  ;
 . . . F LN=1:1 Q:'$D(ARY(FDAT,SRCE,CDIDX,LN))  W:LN>1 ! W ?21,ARY(FDAT,SRCE,CDIDX,LN)
 . W !
 Q  ;
 ;
PROFRJA(D0,LN,OUTARY) ; sets into ^TMP Reject History on BILL PROFILE
 ;
 ; display summary
 S BLANK="",$P(BLANK," ",99)=""
 K ARY,OUTARY N CDINT
 I '$D(^PRCA(430,D0,18)) Q  ;
 S LN=LN+1,OUTARY(LN,0)="CS REJECTS: " S D1=0
 ; collapses rejects records 
 F  S D1=$O(^PRCA(430,D0,18,D1)) Q:'D1  D  ;
 . S RJREC=^PRCA(430,D0,18,D1,0)
 . S FDAT=$P(RJREC,"^")   ; date
 . S SRCE=$P(RJREC,"^",2) ;source
 . S ERRCDS=$S($D(ARY(FDAT,SRCE)):ARY(FDAT,SRCE),1:",")
 . F PC=3:1:11 S ERRCD=$P(RJREC,"^",PC) Q:'$L(ERRCD)  D  ;
 . . S ARY(FDAT,SRCE,PC)=$P(^RC(348.5,ERRCD,0),"^")_U_ERRCD,ERRCD=$P($G(^RC(348.5,ERRCD,0)),U)   ;PRCA*4.5*324
 . . I ERRCDS'[(","_ERRCD_",") S ERRCDS=ERRCDS_ERRCD_","
 . S ARY(FDAT,SRCE)=ERRCDS
 . ;
 S FDAT=""
 F  S FDAT=$O(ARY(FDAT)),SRCE="" Q:FDAT=""  D  ; 
 . S Y=FDAT D DD^%DT S EXTDAT=Y ; 
 . F  S SRCE=$O(ARY(FDAT,SRCE)),CDIDX="" Q:SRCE=""  D  ;
 . . S ERRCDS=$TR($E(ARY(FDAT,SRCE),2,$L(ARY(FDAT,SRCE))-1),",","-")
 . . S OUTARY(LN,0)=$E(OUTARY(LN,0)_BLANK,1,11)_"DATE: "_EXTDAT
 . . S OUTARY(LN,0)=$E(OUTARY(LN,0)_BLANK,1,32)_"CODE(s): "_ERRCDS
 . . S OUTARY(LN,0)=$E(OUTARY(LN,0)_BLANK,1,70)_"SOURCE: "_SRCE
 . S LN=LN+1,OUTARY(LN,0)=""
 ;
 ; display detail
 S FDAT=""
 F  S FDAT=$O(ARY(FDAT)),SRCE="" Q:FDAT=""  D  ;
 . S Y=FDAT D DD^%DT S EXTDAT=Y ;
 . F  S SRCE=$O(ARY(FDAT,SRCE)),CDIDX="" Q:SRCE=""  D  ; 
 . . S LN=LN+1,(OUTARY(LN,0),OUTARY(LN+1,0))=""
 . . S LN=LN+1,OUTARY(LN,0)="CS REJECT DATE: "_EXTDAT
 . . S OUTARY(LN,0)=$E(OUTARY(LN,0)_BLANK,1,34)_"REJECT SOURCE: "_SRCE
 . . F RR=1:1 S CDIDX=$O(ARY(FDAT,SRCE,CDIDX)) Q:CDIDX=""  D  ;
 . . . S LN=LN+1,OUTARY(LN,0)="  REJECT REASON"_RR_": "
 . . . S OUTARY(LN,0)=OUTARY(LN,0)_$P(ARY(FDAT,SRCE,CDIDX),U)_" ",CDINT=$P(ARY(FDAT,SRCE,CDIDX),U,2) ; code   ;PRCA*4.5*324
 . . . S (X,DESC)=$P(^RC(348.5,CDINT,0),"^",2)_"~"_$G(^RC(348.5,CDINT,1))   ;PRCA*4.5*324
 . . . I $L(DESC)<60 S ARY(FDAT,SRCE,CDIDX,1)=X
 . . . I $L(DESC)>59 D  ;
 . . . . F LN2=1:1 S STR=$E(X,1,59) D  Q:'$L(X)  ;
 . . . . . I $L(X)<60 S ARY(FDAT,SRCE,CDIDX,LN2)=X,X="" Q
 . . . . . F L=$L(STR):-1:1 I $F(STR," ",L) S ARY(FDAT,SRCE,CDIDX,LN2)=$E(X,1,L),X=$E(X,L+1,999) Q  ;
 . . . F LN2=1:1 Q:'$D(ARY(FDAT,SRCE,CDIDX,LN2))  D  ;
 . . . . S:LN2>1 LN=LN+1,OUTARY(LN,0)="                     "
 . . . . S OUTARY(LN,0)=OUTARY(LN,0)_ARY(FDAT,SRCE,CDIDX,LN2)
 . S LN=LN+1,OUTARY(LN,0)=""
 Q  ;
 ;
SENDBUL ;
 I '$G(BADQUE) D  ;
 . S FROM=$G(H4DATE)_$G(ZBAT1),TO=$G(H4DATE)_$G(ZBAT2)
 . S BATMSG="     from MM Message"_$S(XMZ1=XMZ2:": "_XMZ1,1:"es: "_XMZ1_" to "_XMZ2)
 . S BATMSG=BATMSG_"     from Batch"_$S(FROM=TO:": "_FROM,1:"es: "_FROM_" to "_TO)
 ;
 D NOW^%DTC,YX^%DTC
 S DTTM=$E(Y,5,6)_" "_$E(Y,1,3)_" "_$E(Y,11,12)_" "_$E(Y,14,18)_" "
 ;
 ; If there is no Source data or Errors, check and send Bulletin Data if available
 I $O(^XTMP("RCTCSJS",$J,"SRC",""))=""&($O(^XTMP("RCTCSJS",$J,"ERR",""))="") D BULERR
 ;
 F SOURCE="AITC","DMC","TREASURY" S SRC=$E(SOURCE) I $D(^XTMP("RCTCSJS",$J,"SRC",SRC)) D  ;
 . D REJMSG
 . D ALPHA
 . S XMSUB="CS REJECTS ("_SOURCE_") ["_XMZ_"] "_DTTM_" "_CNTR_" lines"
 . D SEND
 . ;
 Q
SENDERR ;
 I $D(^XTMP("RCTCSJS",$J,"ERR")) D  ;
 . S SOURCES=""
 . F SRCPC=1:1:3 Q:$E(CSRCS,SRCPC)=""  D
 . . S SOURCE=$P("???,AITC,DMC,TREASURY",",",$F("ADT",$E(CSRCS,SRCPC)))
 . . S SOURCES=SOURCES_","_$S(SOURCE="":"???",1:SOURCE)
 . S SOURCES=$E(SOURCES,2,999)
 . I '$L(SOURCES) S SOURCES="UNSPECIFIED SOURCE"
 . D ERRMSG
 . D ERRSFND
 . S XMSUB="CS ("_SOURCES_") REJECT RECORD ***ERRORS FOUND***  ["_XMZ_"] "_DTTM_" "_CNTR_" lines"
 . D SEND
 . ;
 Q  ;
CLEANUP ; This cleans up the ^XTMP global.
 ;K ^XTMP("RCTCSJS",$J)
 Q
 ;
BULERR ;  If there is Bulletin data, send email with error or note
 N HIT,CNT,CNTR
 S HIT=0,CNT=""
 I $O(^XTMP("RCTCSJS",$J,"BULTN",""))'="" S HIT=1
 I 'HIT Q
 S CNTR=$O(^XTMP("RCTCSJS",$J,"REC",$G(CNTR)),-1)
 S CNTR=CNTR+1
 S ^XTMP("RCTCSJS",$J,"REC",CNTR)="The following CS REJECTS transmissions have been processed"
 S CNTR=CNTR+1
 S ^XTMP("RCTCSJS",$J,"REC",CNTR)=BATMSG
 F  S CNT=$O(^XTMP("RCTCSJS",$J,"BULTN",CNT)) Q:CNT=""  S BULDAT=^(CNT) D
 . S CNTR=CNTR+1
 . S ^XTMP("RCTCSJS",$J,"REC",CNTR)=BULDAT
 S XMSUB="CS REJECTS ["_XMZ_"] "_DTTM_" "_CNTR_" lines"
 D SEND
 Q  ; BULERR
 ;
REJMSG ;Send list of rejected documents
 S ^XTMP("RCTCSJS",$J,"REC",1)="The following CS DEBT REFERRAL transmissions have been rejected"
 S ^XTMP("RCTCSJS",$J,"REC",2)=BATMSG
 S ^XTMP("RCTCSJS",$J,"REC",3)=""
 S ^XTMP("RCTCSJS",$J,"REC",4)="NAME                 SSN       BILL NUMBER TYPE ACTN ERROR CODES"
 S ^XTMP("RCTCSJS",$J,"REC",5)=""
 S CNTR=5
 Q  ; REJMSG
ALPHA ; orders BULLETIN by SRC, Patient NAME, BILL NO. sequence
 S NAM=""
 F  S NAM=$O(^XTMP("RCTCSJS",$J,"SRC",SRC,NAM)),SBILL="" Q:NAM=""  D  ;
 . F  S SBILL=$O(^XTMP("RCTCSJS",$J,"SRC",SRC,NAM,SBILL)),BLTNCNT="" Q:SBILL=""  D  ;
 .. F  S BLTNCNT=$O(^XTMP("RCTCSJS",$J,"SRC",SRC,NAM,SBILL,BLTNCNT)) Q:BLTNCNT=""  D  ;
 ... S BLTNREC=^XTMP("RCTCSJS",$J,"BULTN",BLTNCNT)
 ... S CNTR=CNTR+1,^XTMP("RCTCSJS",$J,"REC",CNTR)=BLTNREC
 Q  ;
 ;
ERRMSG ;Send list of ERRORS FOUND document
 S ^XTMP("RCTCSJS",$J,"REC",1)="The following **ERRORS** found in the ("_SOURCES_") CS DEBT REFERRAL Reject File"
 S ^XTMP("RCTCSJS",$J,"REC",2)=BATMSG
 S ^XTMP("RCTCSJS",$J,"REC",3)=""
 S ^XTMP("RCTCSJS",$J,"REC",4)="  #  REC#    TYPE OF ERROR ENCOUNTERED                                       "
 S ^XTMP("RCTCSJS",$J,"REC",5)=""
 S CNTR=5
 Q  ; ERRMSG
 ;
ERRSFND ; places ERRORS FOUND records into BULLETIN sequence
 ;      S ^XTMP("RCTCSJS",$J,"ERR",ERRCNT)=RECN_U_ERRDATA
 S ERRCNT=0
 F  S ERRCNT=$O(^XTMP("RCTCSJS",$J,"ERR",ERRCNT)) Q:'ERRCNT  D  ;
 . S REC=^XTMP("RCTCSJS",$J,"ERR",ERRCNT)
 . S RECN=$P(REC,U),ERRDATA=$P(REC,U,2)
 . S ERRREC=$E($J(ERRCNT,4)_BLNKS,1,5)_$E(RECN_BLNKS,1,8)_$E(ERRDATA_BLNKS,1,66)
 . S CNTR=CNTR+1
 . S ^XTMP("RCTCSJS",$J,"REC",CNTR)=ERRREC
 Q  ; ERRSFND
 ;
SEND ;
 S XMY("G.TCSP")="",XMDUZ="AR PACKAGE",XMTEXT="^XTMP(""RCTCSJS"","_$J_",""REC"","
 D ^XMD
 Q
