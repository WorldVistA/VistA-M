IBCD2 ;ALB/ARH - AUTOMATED BILLER (CREATE - SETUP/GATHER DATA FIELDS) ; 8/6/93
 ;;2.0;INTEGRATED BILLING;**4,55,91,106,384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
FIND ;
 S IBX=$$CHKSYS^IBCD4 I 'IBX D TERR(0,0,$P(IBX,U,2)) G EXIT
 S IBS="IBC0" F  S IBS=$O(^TMP(IBS)) Q:IBS=""  S IBX=$E(IBS,4,99) Q:$E(IBS,1,3)'="IBC"!'+IBX  D
 . N IBQUERY
 . S IBDFN=0 F  S IBDFN=$O(^TMP(IBS,$J,IBDFN)) Q:'IBDFN  D
 .. S IBSTDT="" F  S IBSTDT=$O(^TMP(IBS,$J,IBDFN,IBSTDT)) Q:IBSTDT=""  D  I $D(IBCT)>9 D CREATE(.IBQUERY)
 ... K IBCT S IBTRN=0 F  S IBTRN=$O(^TMP(IBS,$J,IBDFN,IBSTDT,IBTRN)) Q:'IBTRN  S IBCT(IBTRN)="",IBTF=^TMP(IBS,$J,IBDFN,IBSTDT,IBTRN)
 .I $G(IBQUERY) D CLOSE^IBSDU(IBQUERY)
EXIT K IBS,IBDFN,IBSTDT,IBCT,IBTRN,IBTF,IBX,X,DFN
 Q
 ;
CREATE(IBQUERY) ;set up a bill,  required: IBCT(IBTRN),IBDFN,IBSTDT
 ; IBQUERY, if defined, will be used to activate the outpt visit QUERY
 Q:$D(IBCT)<9  K IB
 S IBSP=$G(^IBE(350.9,1,1)),IBDIV=$P(IBSP,U,25),IBTRN=+$O(IBCT(0))
 S IBTRND=$G(^IBT(356,IBTRN,0)) I 'IBTRND D TERR(+IBTRN,0,"Claims Tracking Record not found or not complete.") G QUIT
 S IBTYPE=$P(IBTRND,U,18) S IBX=$$CHK I 'IBX D TERR(+IBTRN,0,$P(IBX,U,2)) G QUIT
 ;
 S IBX=$$ARSET I 'IBX D TERR(IBTRN,0,$P(IBX,U,2)) G QUIT
 S IBIFN=+IBX,IB(.01)=$P(IBX,U,2),IB(.17)=$P(IBX,U,3),IB(.2)=1,IB(.22)=IBDIV
 S (IB(.02),DFN)=IBDFN,IB(.06)=IBTF
 S IB(.07)=$O(^DGCR(399.3,"B","REIMBURSABLE INS.",0)) I 'IB(.07) S IB(.07)=8
 S IBX=$O(^IBT(356.2,"ATRTP",IBTRN,1,"")) I +IBX S IB(163)=$P($G(^IBT(356.2,IBX,0)),U,28) ;pre-cert #
 ;
 S IBX=$P($G(^IBE(356.6,+IBTYPE,0)),U,1)
 I IBX="INPATIENT ADMISSION" D INPT^IBCD5 G CONT
 I IBX="PRESCRIPTION REFILL" D RXRF G CONT
 I IBX="OUTPATIENT VISIT" D OUTPT G CONT
 G QUIT
 ;
CONT S IBX=$$BDT^IBCU3(IBDFN,IB(.03)) S IB(.17)=$S(+IBX:IBX,1:IBIFN) ; continuing episode of care
 ;Note if a primary bill is found for an outpatient bill then it allows them to choose the bill during bill creation,  .17 is not editable on the screens
 S IB(.18)=$$SC^IBCU3(IBDFN) ; SC at time of care
 ;
 ; Note: variable IBQUERY used in this call to ^IBCD3
 D EN^IBCD3(.IBQUERY) ; create bill
 ;
 S IBTRN=0 F  S IBTRN=$O(IBCT(IBTRN)) Q:'IBTRN  D
 . D TERR(IBTRN,IBIFN,"") ; bill created
 . I ",2,3,"'[+$G(IB(.06)) D TEABD(IBTRN,0) ; remove eabd for final bills
 . D TBILL(IBTRN,IBIFN) ; set index for bill and event (356.399)
 . I $O(IB(43,0)),$$NABSCT^IBCU81(IBTRN) D TERR(IBTRN,IBIFN,"Stop/Clinic flagged to be ignored by auto biller but another visit is billed on same date.")
 . I $O(IB(43,0)),$$NBOE^IBCU81(+$P($G(^IBT(356,+IBTRN,0)),U,4)) D TERR(IBTRN,IBIFN,"Visit flagged as SC in source file but has no RNB.")
 ;
 S IBTRN=$O(IBCT(IBTRN)) Q:'IBTRN  D
 . I $G(IB(.05))>2,$G(IB(.27))=1,+$G(^DGCR(399,IBIFN,"MP")),'$O(^DGCR(399,IBIFN,"RC",0)) D TERR(IBTRN,IBIFN,"This RC Opt bill appears to have no institutional charges but may have professional charges.")
 ;
 S X=$$PRCDIV^IBCU71(IBIFN) ; reset bill division from site default to first procedures division
 ;
QUIT K X,Y,IBX,IBY,IBSP,IBDIV,IBTRN,IBTRND,IBTYPE,IB
 Q
 ;
OUTPT S IB(.04)=$S(+$P($G(^DG(40.8,+IBDIV,0)),U,3):7,1:1) ;division outpatient only or hospital
 S IB(.05)=3,IB(.06)=1,IB(.09)=4
 ;event dt is date of first visit, stmt from is first visit dt, stmt to is last visit dt on bill
 S (IB(.03),IB(151))=9999999,IB(152)=""
 S IBTRNX=0 F  S IBTRNX=$O(IBCT(IBTRNX)) Q:'IBTRNX  S IBX=$P($G(^IBT(356,IBTRNX,0)),U,6)\1 D
 . S IB(43,+IBX)="" S:IB(152)<IBX IB(152)=IBX F IBI=.03,151 I IB(IBI)>IBX S IB(IBI)=IBX
 I +$$BILLRATE^IBCRU3(+$G(IB(.07)),IB(.05),IB(.03),"RC") S IB(.27)=1 ; reasonable charges institutional bill
 K IBI,IBX,IBTRNX
 Q
RXRF S IB(.04)=$S(+$P($G(^DG(40.8,+IBDIV,0)),U,3):7,1:1) ;division outpatient only or hospital
 S IB(.05)=3,IB(.06)=1
 ;event dt is date of first visit, stmt from is first visit dt, stmt to is last visit dt on bill
 S (IB(.03),IB(151))=9999999,IB(152)=""
 S IBTRNX=0 F  S IBTRNX=$O(IBCT(IBTRNX)) Q:'IBTRNX  S IBRX=$G(^IBT(356,IBTRNX,0)) D
 . S IBX=$$RXRF^IBCD4(+$P(IBRX,U,8),+$P(IBRX,U,10)),IB(362.4,+$P(IBRX,U,8),+$P(IBRX,U,10))=IBX,IBX=$P(IBX,U,4)
 . S:IB(152)<IBX IB(152)=IBX F IBI=.03,151 I IB(IBI)>IBX S IB(IBI)=IBX
 . I $P(IBRX,U,31)>1 D  ;special consent roi
 .. S IB(155)=1,IB(157)=0 ; is dx sensitive
 .. I $P(IBRX,U,31)=2 S IB(157)=1 ; ROI obtained
 K IBI,IBX,IBTRNX,IBRX
 Q
 ;
ARSET() ; set up entry for new bill in AR returns IFN, bill number
 ;otherwise "0^error meaasge"
 N X S X="0^Can not set up bill in AR."
 S PRCASV("SER")=$P($G(^IBE(350.9,1,1)),U,14),PRCASV("SITE")=+$P($$SITE^VASITE,U,3)
 D SETUP^PRCASVC3
 I $P(PRCASV("ARBIL"),U)=-1 S X="0^"_$P(PRCASV("ARBIL"),U,2)_" - "_$$ETXT^IBEFUNC($P(PRCASV("ARBIL"),U,2)) G ARSETQ
 I $P(PRCASV("ARREC"),U)=-1 S X="0^"_$P(PRCASV("ARREC"),U,2)_" - "_$$ETXT^IBEFUNC($P(PRCASV("ARREC"),U,2)) G ARSETQ
 S X=PRCASV("ARREC")_U_$P(PRCASV("ARBIL"),"-",2)
ARSETQ K PRCASV
 Q X
 ;
CHK() ;other checks
 N X S X=1 I $G(^DPT(+$G(IBDFN),0))="" S X="0^Patient information lacking."
 Q X
 ;
TEABD(TRN,IBDT) ;
 S IBDT=+$G(IBDT),^TMP("IBEABD",$J,+TRN,+IBDT)=""
 Q
TERR(TRN,IFN,ER) ;
 N X S TRN=+$G(TRN),IFN=+$G(IFN),X=+$G(^TMP("IBCE",$J,DT,TRN,IFN))+1
 S ^TMP("IBCE",$J,DT,TRN,IFN,X)=$G(ER),^TMP("IBCE",$J,DT,TRN,IFN)=X
 Q
TBILL(TRN,IFN) ;
 I '$D(^IBT(356,+$G(TRN),0))!('$D(^DGCR(399,+$G(IFN),0))) Q
 S ^TMP("IBILL",$J,TRN,IFN)=""
 Q
