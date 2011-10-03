IBRFN ;ALB/AAS - Supported functions for AR ;5-MAY-1992
 ;;2.0;INTEGRATED BILLING;**52,130,183,223,309,276,347,411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ERR(Y) ; Input Y = -1^error code[;error code...]^literal message
 ; Output IBRERR = error message 1
 ;        if more than one code then
 ;        IBRERR(n)=error code n
 N N,X,X1,X2 K IBRERR S IBRERR=""
 G:+Y>0 ERRQ
 S X2=$P(Y,U,2) F N=1:1 S X=$P(X2,";",N) Q:X=""  S X1=$P($G(^IBE(350.8,+$O(^IBE(350.8,"AC",X,0)),0)),U,2) D
 .I N=1 S IBRERR=X1
 .I $P(Y,U,3)]""!($P(X2,";",2,99)]"") S IBRERR(N)=X1
 I $P(Y,U,3)]"" S N=N+1,IBRERR(N)=$P(Y,U,3)
ERRQ Q IBRERR
 ;
MESS(Y) ;  -input y=error code - from file 350.8 (piece 3)
 ;   output error message
 Q $P($G(^IBE(350.8,+$O(^IBE(350.8,"AC",Y,0)),0)),U,2)
 ;
SVDT(BN,VDT) ;returns service dates for a specific bill
 ;  Input:  BN bill number (external form)
 ;          VDT name of array to hold outpatient visit dates, pass by value (if needed)
 ; Output:  X function value, string, = 0 if bill not found
 ;          = 1 (Inpt) or 2 (Outpt)^event date^stmt from date^stmt to date^LOS (I)^Number of visit dates (O)
 ;          all are internal form, any piece may be null if not defined for the bill
 ;          array containing outpatient visit dates as subscripts/no data, if VDT passed by value
 N X,Y,IFN S X=0,BN=$G(BN)
 I BN'="" S IFN=+$O(^DGCR(399,"B",BN,0)),Y=$G(^DGCR(399,IFN,0)) I Y'="" D
 . S X=$S(+$P(Y,U,5)<1:"",+$P(Y,U,5)<3:1,+$P(Y,U,5)<5:2,1:"")_U_$P(Y,U,3),Y=$G(^DGCR(399,IFN,"U"))
 . S X=X_U_$P(Y,U,1)_U_$P(Y,U,2)_U_$P(Y,U,15)_U_$P($G(^DGCR(399,IFN,"OP",0)),U,4)
 . S Y=0 F  S Y=$O(^DGCR(399,IFN,"OP",Y)) Q:'Y  S VDT(Y)=""
 Q X
 ;
 ;
REC(IBSTR,IBTYPE) ; Find the AR for an Authorization or Rx number
 ;   Input: IBSTR - FI Authorization Number or Rx Number
 ;  Output: IBAR  >0 => ptr to claim/AR in files 399/430
 ;                -1 => No receivable found
 ;          IBTYPE (by ref) - how the IBSTR was recognized: 1-Auth,2-ECME,3-Rx#,0-Unknown
 ;
 N IBAR,IBARR,IBRX,IBKEY,IBKEYS,IBREF,IBPREF
 S IBTYPE=0
 S IBAR=-1
 I $G(IBSTR)="" G RECQ
 ;
 ; extended syntax to indicate the type:
 ; T.000000 for TRICARE, E.7000000 for ECME, R.50000000 for Rx
 I $L($P(IBSTR,"."))=1,$P(IBSTR,".",2)'="" D
 . S IBPREF=$TR($P(IBSTR,"."),"ter","TER")
 . S IBSTR=$P(IBSTR,".",2,255)
 . I $E(IBPREF)="T" S IBTYPE=1 ; TRICARE Auth#
 . I $E(IBPREF)="E" S IBTYPE=2 ; ECME #
 . I $E(IBPREF)="R" S IBTYPE=3 ; Rx #
 ;
 ; look for TRICARE number
 I (IBTYPE=0)!(IBTYPE=1) S IBAR=$$AREC(IBSTR) I IBAR>0 S IBTYPE=1 G RECQ
 ;
 ; - look for ecme number
 I (IBTYPE=0)!(IBTYPE=2) S IBAR=$$EREC(IBSTR) I IBAR>0 S IBTYPE=2 G RECQ
 ;
 I IBTYPE,IBTYPE'=3 G RECQ
 ;
 ; - treat as an rx number
 S IBAR=$$RXREC(IBSTR) I IBAR>0 S IBTYPE=3
 ;
RECQ Q IBAR
 ;
RXREC(IBRXN) ; Search the Rx
 N IBR,IBX,IBARR,IBY,IBBIL,IBTRKN,IBFIL,IBRX
 I $L(IBRXN)<5,'$D(^IBA(362.4,"B",IBRXN)) Q -1
 ; Scan 362.4
 ; 1) check the exact match:
 S IBX=0 F  S IBX=$O(^IBA(362.4,"B",IBRXN,IBX)) Q:'IBX  D
 . S IBBIL=$P($G(^IBA(362.4,IBX,0)),U,2) Q:'IBBIL
 . I $P($G(^DGCR(399,IBBIL,0)),U,13)=7 Q  ; ignore cancld
 . S IBARR(IBBIL)=""
 ; 2) check Rx with postfixes like "A","B" etc
 S IBR=IBRXN_" " F  S IBR=$O(^IBA(362.4,"B",IBR)) Q:$E(IBR,1,$L(IBRXN))'=IBRXN  D
 . I $E(IBR,$L(IBRXN)+1)'?1A Q  ; only letters in postfx
 . S IBX=0 F  S IBX=$O(^IBA(362.4,"B",IBR,IBX)) Q:'IBX  D
 . . S IBBIL=$P($G(^IBA(362.4,IBX,0)),U,2) Q:'IBBIL
 . . I $P($G(^DGCR(399,IBBIL,0)),U,13)=7 Q  ; ignore cancld
 . . S IBARR(IBBIL)=""
 ; 3) Now scan CT (356):
 S DIC=52,DIC(0)="BO",X=IBSTR D DIC^PSODI(52,.DIC,X) S IBRX=+Y K DIC,X,Y
 I IBRX S IBFIL="" F  S IBFIL=$O(^IBT(356,"ARXFL",IBRX,IBFIL)) Q:IBFIL=""  D
 . S IBTRKN="" F  S IBTRKN=$O(^IBT(356,"ARXFL",IBRX,IBFIL,IBTRKN)) Q:IBTRKN=""  D
 .. S IBBIL=$P($G(^IBT(356,IBTRKN,0)),U,11) Q:'IBBIL
 .. I $P($G(^DGCR(399,IBBIL,0)),U,13)=7 Q  ; ignore cancld
 .. S IBARR(IBBIL)=""
 ;
 S IBY=$O(IBARR("")) I IBY'>0 Q -1  ;not found
 I '$O(IBARR(IBY)) D DTL(+IBY,"Rx#",IBRXN) Q +IBY  ;one only
 W !!,"More than one fill for Rx# ",IBSTR," has been billed."
 S IBY=$$SEL(.IBARR)
 D DTL(IBY,"Rx#",IBRXN)
 Q IBY
 ;
AREC(AUTH) ; Find the Receivable for a TRICARE FI Authorization Number
 ;   Input: AUTH - Fiscal Intermediary Authorization Number
 ;  Output: IBIFN  >0 => ptr to claim/AR in files 399/430
 ;                 -1 => No receivable found
 N IBIFN
 S IBIFN=-1
 I $G(AUTH)="" G ARECQ
 S IBIFN=$P($G(^IBA(351.5,+$O(^IBA(351.5,"AUTH",AUTH,0)),0)),U,9)
 S:'IBIFN IBIFN=-1
ARECQ ;
 D DTL(IBIFN,"TRICARE#",AUTH)
 Q IBIFN
 ;
 ;
EREC(AUTH) ; Find the Receivable for an ECME FI Number
 ;   Input: AUTH  - Fiscal Intermediary ECME Number
 ;  Output: IBIFN  >0 => ptr to claim/AR in files 399/430
 ;                 -1 => No receivable found
 ;
 N IBIFN,IBC,IBX,IBA,IBE,IBES
 S IBIFN=-1,IBC=0
 I $G(AUTH)="" G ARECQ
 S (IBE,IBES)=$$BCID^IBNCPDP4(+AUTH,"")
 F  S IBE=$O(^DGCR(399,"AG",IBE)) Q:IBE'[IBES  D
 . S IBX=0 F  S IBX=$O(^DGCR(399,"AG",IBE,IBX)) Q:'IBX  D
 .. I $P($G(^DGCR(399,IBX,0)),U,13)=7 Q  ;exclude cancld
 .. S IBA(IBX)="",IBC=IBC+1
 I IBC'>1 S IBIFN=$O(IBA(0)) G ERECQ  ; only one found
 W !!,"More than one fill for ECME# ",AUTH," has been billed."
 S IBIFN=$$SEL(.IBA)
ERECQ S:'IBIFN IBIFN=-1
 D DTL(IBIFN,"ECME#",AUTH) ;details
 Q IBIFN
 ;
DTL(IBIFN,TYPE,AUTH) ;Details
 Q:IBIFN'>0  Q:AUTH=""
 N IBZ,IBBIL,IBPAT,IBPATN,IBRX,IB3624,IBDRUG,IBQTY,IBDAT,DIR
 S IBZ=$G(^DGCR(399,IBIFN,0))
 S IBBIL=$P(IBZ,U),IBPAT=$P(IBZ,U,2),IBDAT=$P(IBZ,U,3)
 S IBPATN=$P($G(^DPT(+IBPAT,0)),U)
 S IB3624=$G(^IBA(362.4,+$O(^IBA(362.4,"C",IBIFN,"")),0))
 D ZERO^IBRXUTL(+$P(IB3624,U,4))
 S IBDRUG=$G(^TMP($J,"IBDRUG",+$P(IB3624,U,4),.01))
 K ^TMP($J,"IBDRUG")
 S IBRX=$$FILE^IBRXUTL(+$P(IB3624,U,5),.01)
 S IBQTY=+$P(IB3624,U,7)
 W !!,"Found IB Bill ",IBBIL," matching to "_TYPE_" '",AUTH,"':"
 W !,"Rx#",IBRX," ",$$DAT3^IBOUTL(IBDAT),", ",IBPATN,", ",IBDRUG I IBQTY W " (",IBQTY,")"
 Q
 ;
AUD(IBIFN) ; Does the Accounts Receivable need to be audited?
 ;   Input: IBIFN  - ptr to claim/AR in files 399/430
 ;  Output: 0 => Claim does not have to be audited
 ;               (claim was set up automatically)
 ;          1 => Claim must be audited
 ;               (claim was established manually)
 ;
AUDQ Q $O(^IBA(351.5,"ACL",+$G(IBIFN),0))'>0
 ;
 ;
TYP(IBIFN) ; Determine the bill type for an Accounts Receivable.
 ;  Input:  IBIFN - ptr to claim/AR in files 399/430
 ; Output:  I => Inpatient bill
 ;          O => Outpatient bill
 ;          PH => Pharmacy bill
 ;          PR => Prosthetics bill
 ;
 ;          or -1 if the bill type can't be determined.
 ;
 N IBATYP,IBATYPN,IBBG,IBN,IBND,IBTYP,IBX
 S IBTYP=-1
 I '$G(IBIFN) G TYPQ
 ;
 ; - see if AR originated from file #399
 S IBX=$G(^DGCR(399,IBIFN,0))
 I IBX]"" D  G TYPQ
 .S IBTYP=$$BTYP^IBCOIVM1(IBIFN,IBX)
 .S IBTYP=$S(IBTYP="":-1,IBTYP="P":"PR",IBTYP="R":"PH",1:IBTYP)
 ;
 ; - get the bill number
 S IBX=$P($G(^PRCA(430,IBIFN,0)),U)
 I IBX="" G TYPQ
 ;
 ; - AR must have originated from file #350
 S IBN=$O(^IB("ABIL",IBX,0))
 I 'IBN G TYPQ
 S IBND=$G(^IB(IBN,0))
 I 'IBND G TYPQ
 S IBATYP=$G(^IBE(350.1,+$P(IBND,U,3),0)),IBBG=$P(IBATYP,U,11)
 ;
 ; - handle TRICARE charges first
 I IBBG=7 D  G TYPQ
 .S IBATYPN=$P(IBATYP,U)
 .S IBTYP=$S(IBATYPN["INPT":"I",IBATYPN["OPT":"O",1:"PH")
 ;
 S IBTYP=$S(IBBG=4:"O",IBBG=5:"PH",IBBG=8:"O",1:"I")
TYPQ Q IBTYP
 ;
RELBILL(IBIFN) ; given a Third Party Bill, find all related Third Party bills,
 ; then find all First Party bills related to any of the Third Party bills
 ; Input:  IBIFN = internal file number of a Third Party bill
 ; Output: Third Party Bills (#399)
 ;    ^TMP("IBRBT", $J, selected bill ifn) = PATIENT HAS ANY RX COVERAGE ON FROM DATE OF BILL?
 ;    ^TMP("IBRBT", $J, selected bill ifn, matching bill ifn) =
 ;                                        BILL FROM ^ BILL TO ^ CANCELLED? ^ AR BILL NUMBER ^
 ;                                        PAYER SEQUENCE ^ PAYER IS MEDICARE SUPPLEMENTAL (0/1) ^ PAYER NAME
 ; Output:  First Party Bills (#350)
 ;    ^TMP("IBRBF", $J , selected bill ifn ) = ""
 ;    ^TMP("IBRBF", $J , selected bill ifn , charge ifn) = 
 ;                                        BILL FROM ^ BILL TO ^ CANCELLED? ^ AR BILL NUMBER ^
 ;                                        TOTAL CHARGE ^ ACTION TYPE (SHORT) ^ # DAYS ON HOLD
 ;
 N IBIFN1 I '$D(^DGCR(399,+$G(IBIFN),0)) Q
 D TPTP^IBEFUR(IBIFN)
 S IBIFN1=0 F  S IBIFN1=$O(^TMP("IBRBT",$J,IBIFN,IBIFN1)) Q:'IBIFN1  D TPFP^IBEFUR(IBIFN1)
 Q
 ;
SEL(IBARR) ; Select an rx bill
 ;  Input: IBARR - Array of IBIFN
 ; Output: IBNUM - One of the bill iens, or -1
 ;
 N DIR,IBIFN,IBRXN,IBDT,IBZ,IBY,IBC,IBBIL,IBLNK,DFN,IBPT,I,IBINS,IBCOB
 ;
 S IBIFN=$O(IBARR(""))
 I 'IBIFN Q -1
 I '$O(IBARR(IBIFN)) Q IBIFN  ; no choice
 ;
 W !!?4,"Select one of the following:",!
 W !?8,"BILL",?19,"RX",?31,"DATE",?42,"INSURANCE",?60,"COB",?65,"PATIENT"
 W !?4 F I=1:1:75 W "-"
 ;
 S (IBIFN,IBC)=0
 F  S IBIFN=$O(IBARR(IBIFN)) Q:'IBIFN  D
 . S IBZ=$G(^DGCR(399,IBIFN,0)) Q:IBZ=""
 . S DFN=+$P(IBZ,U,2),IBPT=$P($G(^DPT(DFN,0)),U)
 . S IBBIL=$P(IBZ,U)
 . S IBDT=$P(IBZ,U,3)
 . S IBY=$G(^IBA(362.4,+$O(^IBA(362.4,"C",IBIFN,0)),0))
 . S IBRXN=$P(IBY,U)
 . S IBC=IBC+1
 . S IBLNK(IBC)=IBIFN
 . S IBCOB=$P(IBZ,U,21)
 . S IBINS=$P($G(^DIC(36,+$P($G(^DGCR(399,IBIFN,"MP")),U),0)),U)
 . W !?4,IBC,?8,IBBIL," ",?19,IBRXN," ",?31,$$DAT1^IBOUTL(IBDT)," ",?42,$E(IBINS,1,18),?61,IBCOB,?65,$E(IBPT,1,14)
 ;
 ;
 F  R !!?4,"Select one of the bills by number: ",IBY:DTIME  Q:'$T  Q:"^"[IBY  Q:$D(IBLNK(+IBY))  W:(IBY'="")&(IBY'["?") "  ??"  D
 . W !!?8,"Enter numeric value from 1 to ",IBC
 ;
 S IBIFN=$G(IBLNK(+IBY),-1)
 Q IBIFN
