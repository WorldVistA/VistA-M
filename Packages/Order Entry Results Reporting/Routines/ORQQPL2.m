ORQQPL2 ; ALB/PDR/REV/TC - RPCs FOR CPRS GUI IMPLEMENTATION ;03/08/13  08:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,306,361**;Dec 17, 1997;Build 39
 ;
 ;  External References:
 ;  $$SITE^VASITE                   ICR #10112
 ;  $$FMTE/$$HTFM/$$NOW^XLFDT       ICR #10103
 ;  $$GET^XPAR                      ICR #2263
 ;  $$NAME^XUSER                    ICR #2343
 ;
 ; -------------- GET HISTORY FOR DETAIL DISPLAY ----------------------
 ;
HIST(RETURN,GMPIFN) ; GET AUDIT HISTORY
 ; taken from EN^GMPLDISP
 N IDT,AIFN,S,ORDT,TXT,I,L,GMPDT,LCNT
 S LCNT=0
 I +$O(^GMPL(125.8,"AD",GMPIFN,0))'>0 D  Q  ;BAIL OUT - NO CHANGES
 . S RETURN(0)="NONE"
 ;       get change history
 S IDT=""
 F  S IDT=$O(^GMPL(125.8,"AD",GMPIFN,IDT)) Q:IDT'>0  D
 . S AIFN=""
 . F  S AIFN=$O(^GMPL(125.8,"AD",GMPIFN,IDT,AIFN)) Q:AIFN'>0  D
 .. N FLD,GMPL0 S GMPL0=^GMPL(125.8,AIFN,0),FLD=$P(GMPL0,U,2)
 .. Q:(FLD=80201)!(FLD=80202)!(FLD=80002)
 .. D DT^GMPLHIST
 ;         Transfer data and clean up for return to GUI
 S S="",I=0,TXT=""
 F  S S=$O(GMPDT(S)) Q:S=""  D
 . S L=GMPDT(S,0)
 . I $L(L,": ")>1 D  Q  ; does line begin with date? (hope ": " can't be part of text)
 .. D FLUSH(.RETURN,.I,$G(ORDT),$G(TXT))
 .. S ORDT=$P(L,": ") ; get new date
 .. S TXT=$$STRIP($P(L,": ",2,999)) ; start new text string
 . S TXT=TXT_" "_$$STRIP(L)  ; line does not begin with date, so add to existing text line
 I '$D(RETURN(0)) S RETURN(0)=I
 D FLUSH(.RETURN,.I,$G(ORDT),$G(TXT))
 Q
 ;
FLUSH(RETURN,I,ORDT,TXT) ; FLUSH FORMATTED AUDIT STRING
  I I'=0 D  ; do we have a text string built?
 . S RETURN(I)=$$STRIP(ORDT)_U_TXT  ; return date and text
  S I=I+1
 Q
 ;
STRIP(VAL) ; STRIP LEADING SPACES FROM VALUES
 N J
 F J=1:1 Q:$E(VAL,J)'=" "
 Q $E(VAL,J,9999)
 ;
 ; ------------------- DELETE A PROBLEM FROM LIST ---------------------
 ;
DELETE(RESULT,GMPIFN,GMPROV,GMPVAMC,REASON) ; DELETE A PROBLEM
 ; From GMPL1 - silent version
 N CHNGE
 I REASON'="" D
 . S GMPFLD(10,"NEW",1)=REASON
 . D NEWNOTE^GMPLSAVE
 S CHNGE=GMPIFN_"^1.02^"_$$HTFM^XLFDT($H)
 S CHNGE=CHNGE_U_DUZ_"^P^H^Deleted^"_+$G(GMPROV)
 S $P(^AUPNPROB(GMPIFN,1),U,2)="H"
 S RESULT=1
 D AUDIT^GMPLX(CHNGE,"")
 D DTMOD^GMPLX(GMPIFN)
 K GMPFLD
 Q
 ; ------------------ REPLACE REMOVED PROBLEM ----------------------
 ;
REPLACE(RETURN,DA) ; -- replace problem on patient's list
 ; taken from REPLACE^GMPLRPTR
 N CHNGE,DIE,DR
 I $P($G(^AUPNPROB(DA,1)),U,2)'="H" D  Q  ; BAIL OUT - INVALID RECORD
 . S RETURN=0
 S DR="1.02////P"
 S DIE="^AUPNPROB("
 D ^DIE
 S CHNGE=DA_"^1.02^"_$$HTFM^XLFDT($H)_U_DUZ_"^H^P^Replaced^"_DUZ
 D AUDIT^GMPLX(CHNGE,"")
 D DTMOD^GMPLX(DA)
 S RETURN=1
 Q
 ;
 ; -------------------  VERIFY A PROBLEM ------------------------
 ;
VERIFY(RETURN,GMPIFN) ; -- verify a transcribed problem
 ; RETURN:  ;(consistent with UPDATE function)
 ;   SUCCESS:
 ;     RETURN>0, RETURN(0)=""
 ;   FAILURE:
 ;      RETURN<0, RETURN(0)=verbose error message
 N NOW,CHNGE
 S NOW=$$HTFM^XLFDT($H)
 I $P(^AUPNPROB(GMPIFN,1),U,2)'="T" D  Q  ; BAIL OUT - ALREADY VERIFIED
 . S RETURN=-1
 . S RETURN(0)="Problem Already Verified"
 L +^AUPNPROB(GMPIFN,0):10
 I '$T D  Q  ; BAIL OUT - NO LOCK
 . S RETURN=-1
 . S RETURN(0)="Record in use. Try again in a few moments"
 S $P(^AUPNPROB(GMPIFN,1),U,2)="P"
 S CHNGE=GMPIFN_"^1.02^"_NOW_U_DUZ_"^T^P^Verified^"_DUZ
 D AUDIT^GMPLX(CHNGE,"")
 D DTMOD^GMPLX(GMPIFN)
 L -^AUPNPROB(GMPIFN,0)
 S RETURN=1
 S RETURN(0)=""
 Q
INACT(RETURN,GMPIFN) ; -- inactivate a problem
 ; RETURN:  ;(consistent with UPDATE function)
 ;   SUCCESS:
 ;     RETURN>0, RETURN(0)=""
 ;   FAILURE:
 ;      RETURN<0, RETURN(0)=verbose error message
 N NOW,CHNGE
 S NOW=$$HTFM^XLFDT($H)
 I $P(^AUPNPROB(GMPIFN,0),U,12)'="A" D  Q  ; BAIL OUT - ALREADY INACTIVE
 . S RETURN=-1
 . S RETURN(0)="Problem Already Inactive"
 L +^AUPNPROB(GMPIFN,0):10
 I '$T D  Q  ; BAIL OUT - NO LOCK
 . S RETURN=-1
 . S RETURN(0)="Record in use. Try again in a few moments"
 S $P(^AUPNPROB(GMPIFN,0),U,12)="I"
 S CHNGE=GMPIFN_"^.12^"_NOW_U_DUZ_"^A^I^Inactivated^"_DUZ
 D AUDIT^GMPLX(CHNGE,"")
 D DTMOD^GMPLX(GMPIFN)
 L -^AUPNPROB(GMPIFN,0)
 S RETURN=1
 S RETURN(0)=""
 Q
OLDCOMM(ORY,PIFN) ; Return comments for a problem - SINGLE DIVISION!
 ;N FAC,NIFN,NOTE,NOTECNT
 ;S NOTECNT=0
 ;S FAC=$O(^AUPNPROB(PIFN,11,"B",+$G(DUZ(2)),0)) Q:'FAC
 ;F NIFN=0:0 S NIFN=$O(^AUPNPROB(PIFN,11,FAC,11,"B",NIFN)) Q:NIFN'>0  D
 ;. Q:$P($G(^AUPNPROB(PIFN,11,FAC,11,NIFN,0)),U,4)'="A"
 ;. S NOTE=$P($G(^AUPNPROB(PIFN,11,FAC,11,NIFN,0)),U,3)
 ;. S NOTECNT=NOTECNT+1,ORY(NOTECNT)=NOTE
 Q
GETCOMM(ORY,PIFN)       ; Return comments for a problem - MULTI-DIVISIONAL
 N FAC,NIFN,NOTE,NOTECNT
 S NOTECNT=0,FAC=0
 F  S FAC=$O(^AUPNPROB(PIFN,11,FAC)) Q:+FAC'>0  D
 . S NIFN=0
 . F  S NIFN=$O(^AUPNPROB(PIFN,11,FAC,11,NIFN)) Q:NIFN'>0  D
 . . Q:$P($G(^AUPNPROB(PIFN,11,FAC,11,NIFN,0)),U,4)'="A"
 . . S NOTE=$P($G(^AUPNPROB(PIFN,11,FAC,11,NIFN,0)),U,3)
 . . S NOTECNT=NOTECNT+1,ORY(NOTECNT)=NOTE
 Q
SAVEVIEW(Y,GMPLVIEW) ; -- save new view in File #200/Field #125
 N TMP
 Q:'$D(GMPLVIEW)
 S TMP=$P($G(^VA(200,DUZ,125)),U,2,999)
 S ^VA(200,DUZ,125)=$P(GMPLVIEW,U,1)_U_TMP
 S TMP=$$GET^XPAR(DUZ_";VA(200,","ORCH CONTEXT PROBLEMS",1)
 I TMP'="" D  Q
 . D CHG^XPAR(DUZ_";VA(200,","ORCH CONTEXT PROBLEMS",1,$P(GMPLVIEW,U,2))
 D ADD^XPAR(DUZ_";VA(200,","ORCH CONTEXT PROBLEMS",1,$P(GMPLVIEW,U,2))
 Q
NTRTBULL(ORY,ORTERM,ORNP,ORPT,ORCOMM) ; Send NTRT Request bulletin to CAC mailgroup
 N ORSITE,ORSVC,ORUSER,OREQSTR,OREQSVC,ORDGRP,XMB,XMDUZ,XMY
 D USERINFO^XUSRB2(.ORUSER) S ORSITE=$G(ORUSER(3)),ORSVC=$G(ORUSER(5))
 S OREQSTR=$S(DUZ'=ORNP:ORUSER(2)_" for "_$$NAME^XUSER(ORNP),1:ORUSER(2))
 S OREQSVC=$P($$SERVICE^GMPLX1(ORNP,1),U,2)
 S ORSVC=$S(ORSVC=OREQSVC:ORSVC,1:ORSVC_"/"_OREQSVC)
 S:ORSITE']"" ORSITE=$$SITE^VASITE
 I '$L(ORTERM) S ORY="0^Empty String - a valid term must be sent." Q
 I '+$G(DUZ)!'$D(^VA(200,+$G(DUZ))) S ORY="0^A valid user must be identified." Q
 S XMB="OR PROBLEM NTRT BULLETIN"
 S XMDUZ="OR PROBLEM NTRT BULLETIN"
 ; Recipients = g.OR CACS [defined in BULLETIN File entry] &
 ;              [Divisional mail group defined in OR PROBLEM NTRT BY DIVISION param]
 S ORDGRP=$$GET^XPAR("DIV.`"_DUZ(2),"OR PROBLEM NTRT BY DIVISION",1,"E")
 S:ORDGRP]"" XMY("G."_ORDGRP)=""
 S XMB(1)=ORTERM
 S XMB(2)=$$FMTE^XLFDT($E(($$NOW^XLFDT),1,12),2)
 S XMB(3)=OREQSTR
 S XMB(4)=ORSVC
 S XMB(5)=$P(ORSITE,U,2)_"("_$P(ORSITE,U,3)_")"
 S XMB(6)=$G(ORPT,"")
 S XMB(7)=$G(ORCOMM,"None")
 D ^XMB,KILL^XM S ORY=1
 Q
TESTBULL ; Test setting up and sending PL NTRT bulletin
 N ORY
 D NTRTBULL(.ORY,"PL NTRT Test!")
 W !,"Call Result: ",$S(+ORY:"Success!",1:$P(ORY,U,2))
 Q
