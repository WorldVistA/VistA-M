IBCD4 ;ALB/ARH - AUTOMATED BILLER (ADD NEW BILL - GATHER DX AND PROCEDURES)  ;9/5/93
 ;;2.0;INTEGRATED BILLING;**14,80,106,160,309,276,347,522**;21-MAR-94;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
IDX(PTF,DT1,DT2) ; find 501 movement Diagnosis and 701 Discharge Diagnosisfor a PTF record within bill range
 ; check for billable bedsection and SC treatement and duplicates
 ; results: IBT = number of billable movements within date range
 ;          IBMSG(X)=" error message " if any errors found
 ;         ^TMP("IBDX",$J) = PTF IFN
 ;         ^TMP("IBDX",$J,"DX",DX) = MOVE DATE/TIME ^ MOVE IEN ^ POA
 ;         ^TMP("IBDX",$J,-MOVE DATE/TIME, MOVE IEN) = Dx ^ ^ POA
 N IBMVT,IBN,IBDT,IBCNT,IBBS,IBSC,IBMV,IBDX,IBI,IBX K IBMSG,IBT,^TMP("IBDX",$J)
 ;
 D PTFDXDT^IBCSC4F(PTF,DT1,DT2) S IBMVT="M" I +$P($G(^TMP($J,"IBDX","D")),U,3) S IBMVT="D"
 ;
 S ^TMP("IBDX",$J)=+PTF S (IBT,IBBS,IBSC)=0,IBCNT=1
 F IBN="D","M" S IBDT="" F  S IBDT=$O(^TMP($J,"IBDX",IBN,IBDT)) Q:'IBDT  D
 . S IBMV=$G(^TMP($J,"IBDX",IBN,IBDT)) Q:IBMV=""
 . ;
 . I IBN="M" S IBT=IBT+1,IBX="" D  Q:+IBX
 .. I $P(IBMV,U,3)=1 S IBSC=IBSC+1,IBMSG(IBCNT)=$$FMTE^XLFDT(IBDT)_" movement related to an SC condition.",IBCNT=IBCNT+1,IBX=1
 .. I $P($G(^DIC(42.4,+$P(IBMV,U,2),0)),U,5)="" S IBBS=IBBS+1,IBMSG(IBCNT)=$$FMTE^XLFDT(IBDT)_" movement is for a non-billable bedsection.",IBCNT=IBCNT+1,IBX=1
 .. I '$P(IBMV,U,4) S IBMSG(IBCNT)=$$FMTE^XLFDT(IBDT)_" movement does not have a DRG as required for Reasonable Charges.",IBCNT=IBCNT+1
 . I IBN'=IBMVT Q
 . ;
 . S IBI="" F  S IBI=$O(^TMP($J,"IBDX",IBN,IBDT,IBI)) Q:'IBI  D
 .. S IBDX=$G(^TMP($J,"IBDX",IBN,IBDT,IBI)) Q:'IBDX
 .. I '$P(IBDX,U,2),IBDT>+$G(^TMP("IBDX",$J,"DX",+IBDX)) S ^TMP("IBDX",$J,"DX",+IBDX)=IBDT_U_IBI_U_$P(IBDX,U,3)
 ;
 S IBDX="" F  S IBDX=$O(^TMP("IBDX",$J,"DX",IBDX)) Q:'IBDX  D
 . S IBX=^TMP("IBDX",$J,"DX",IBDX) I +IBX S ^TMP("IBDX",$J,-IBX,+$P(IBX,U,2))=IBDX_U_U_$P(IBX,U,3)
 K ^TMP($J,"IBDX")
 ;
 I +IBSC S IBMSG(IBCNT)="PTF record indicates "_+IBSC_" of "_IBT_" movements are for Service Connected Care.",IBCNT=IBCNT+1
 I +IBBS S IBMSG(IBCNT)="PTF record indicates "_+IBBS_" of "_IBT_" movements are for a non-billable bedsection.",IBCNT=IBCNT+1
 S IBT=IBT-IBSC-IBBS I 'IBT S IBMSG(IBCNT)="0 movements are billable."
IDXE Q
 ;
RXRF(PIFN,RIFN,IBDT) ; returns data on fill on date for rx (RX # ^ DRUG ^ DAYS SUPPLY ^ FILL DATE ^ QTY ^ NDC #)
 N X,Y,PLN,RLN,IBFILL,PDFN,LIST,NODE
 S X=""
 S PDFN=$$FILE^IBRXUTL(PIFN,2)
 S LIST="IBRXARR"
 S NODE="R^^"
 I +$G(PIFN) S PLN=$$RXZERO^IBRXUTL(PDFN,PIFN) I PLN'="" D
 . D RX^PSO52API(PDFN,LIST,PIFN,,NODE,,)
 . I $G(IBDT) D REF^PSO52EX($G(IBDT),$G(IBDT),LIST) S RIFN=$O(^TMP($J,LIST,"AD",IBDT,PIFN,""))
 . S RLN="",IBFILL="^^" I $G(RIFN)="" S X="" Q
 . I (RIFN=0)!(RIFN=-1) S RLN=$$RXSEC^IBRXUTL(PDFN,PIFN) Q:RLN=""  S IBFILL=$P(PLN,U,8)_"^"_$P(RLN,U,2)_"^"_$P(PLN,U,7)
 . I RIFN>0 S RLN=$$ZEROSUB^IBRXUTL(PDFN,PIFN,RIFN) Q:RLN=""  S IBFILL=$P(RLN,U,10)_"^"_$P(RLN,U,1)_"^"_$P(RLN,U,4)
 . S X=$P(PLN,U,1)_"^"_$P(PLN,U,6)_"^"_IBFILL_"^"_$$GETNDC^PSONDCUT(+PIFN,+RIFN)
 E  S X=""
 K ^TMP($J,LIST)
 Q X
 ;
CHK() ;other checks
 N X S X=1 I $G(^DPT(+$G(IBDFN),0))="" S X="0^Patient information lacking."
 Q X
 ;
CHKSYS() ;various checks to determine if bill can be created, returns true if passes   XXXXXX
 ;if fails then returns "0^error message"
 ;requires nothing
 N X,Y,I S X=1
 I '$P($G(^IBE(350.9,1,1)),U,14) S X="0^MAS SERVICE PARAMETER UNKNOWN" G CHKSYSE
 I +$P($$SITE^VASITE,U,3)<1 S X="0^ACILITY UNDEFINED" G CHKSYSE
 ;G:$D(IBB) CHKSYSE
 ;I '$D(DUZ(0)) S X="0^FILEMAN ACCESS UNDEFINED" G CHKSYSE
 ;I $S($D(DLAYGO):2\1-(DLAYGO\1),1:1),DUZ(0)'="@",$D(^DIC(399,0,"LAYGO"))  S DLAYGO=399
CHKSYSE Q X
 ;
 ;GVARS(IFN) ;get data on bill IFN  (commented out patch 80, does not appear to be used)
 ;N I S X=1 I '$G(^DGCR(399,+$G(IFN),0)) S X=0 G GVARSE
 ;F I=0,"M" S IB(I)=$G(^DGCR(399,+IFN,I))
 ;S DGINPAR=$P($G(^DIC(36,+IB("MP"),0)),U,6,10)
 ;GVARSE Q X
