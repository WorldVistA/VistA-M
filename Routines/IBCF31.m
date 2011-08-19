IBCF31 ;ALB/BGA -UB92 HCFA-1450 (GATHER CODES) ;25-AUG-1993
 ;;2.0;INTEGRATED BILLING;**17,52,80,51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;This routine requires prior execution of ibcf3.
 ; OUTPUT FORMATTER DOES NOT USE THIS ROUTINE - MAY BE OBSOLETE
 ;Field locators 22-62 are addressed here.
 ;
 S IBMAIL1=$G(^DGCR(399,IBIFN,"M1"))
 ;
22 ;patient status
 S IBFL(22)="" I +IBINPAT,$P(IBSTATE,U,12) S IBX=$P(IBSTATE,U,12),IBFL(22)=$P($G(^DGCR(399.1,+IBX,0)),U,2)
23 ;medical/health record number ssn
 S IBFL(23)=$P(VADM(2),U,2)
 ;
24 ;condition codes 24-30
 S (IBI,IBJ)=0 F  S IBJ=$O(^DGCR(399,+IBIFN,"CC",IBJ)) Q:'IBJ  S IBX=+$G(^(IBJ,0)),IBI=IBI+1,IBFL(24,IBI)=$P($G(^DGCR(399.1,+IBX,0)),U,2)
 S IBFL(24)=IBI_U_0
 ;
 S IBX=$P(IBCUF3,U,3) D SPLIT^IBCF3(31,2,6,IBX) ; set IBFL(31)
32 ;occurrence codes/span and dates 32-35 ,36
 ;S (IBI,IBJ,IBX)=0 F  S IBX=$O(^DGCR(399,+IBIFN,"OC",IBX)) Q:'IBX  S IBY=$G(^(IBX,0)),IBC=$G(^DGCR(399.1,+IBY,0)) I IBC'="" D
 ;. I +$P(IBC,U,10) S IBJ=IBJ+1,IBFL(36,IBJ)=$P(IBC,U,2)_U_$$DATE^IBCF3($P(IBY,U,2))_U_$$DATE^IBCF3($P(IBY,U,4)) Q
 ;. S IBI=IBI+1,IBFL(32,IBI)=$P(IBC,U,2)_U_$$DATE^IBCF3($P(IBY,U,2))
 ;S IBFL(32)=IBI_U_0
 ;S IBFL(36)=IBJ_U_0
 D 32^IBCF32
 ;
 F IBI=1:1:3 S IBFL(37,IBI)=$P(IBCUF3,U,(IBI+3))
 ;
38 ;responsible party with name and address
 S IBFL(38,1)="" I $P(IBPMAILN,U,4)'="" S IBJ=0 D
 . F IBI=4,5,6 I $P(IBPMAILN,U,IBI)'="" S IBJ=IBJ+1,IBFL(38,IBJ)=$P(IBPMAILN,U,IBI)
 . S IBX=$P(IBMAIL1,U,1) I IBX'="" S IBJ=IBJ+1,IBFL(38,IBJ)=IBX
 . K Y S Y=$P(IBPMAILN,U,9) D ZIPOUT^VAFADDR
 . S IBJ=IBJ+1,IBFL(38,IBJ)=$P(IBPMAILN,U,7)_", "_$$STATE(+$P(IBPMAILN,U,8))_" "_Y K Y
 ;
 ;
39 ;value codes, 39-41
 S (IBI,IBX)=0 F  S IBX=$O(^DGCR(399,+IBIFN,"CV",IBX)) Q:'IBX  S IBY=$G(^(IBX,0)),IBJ=$G(^DGCR(399.1,+IBY,0)) I IBJ'="" D
 . S IBI=IBI+1,IBFL(39,IBI)=$P(IBJ,U,2)_U_$P(IBY,U,2)_U_$P(IBJ,U,12)
 S IBFL(39)=IBI_U_0
 ;
 S IBFL(57)=$P(IBCUF31,U,1)
 S IBX=$P(IBCUF3,U,7) D SPLIT^IBCF3(56,5,14,IBX) ; set IBFL(56)
 I IBX="" F IBI=2,3,4 S IBX=+$P(IBMAIL1,U,(IBI+3)) I +IBX S IBFL(56,IBI)=$$BN1^PRCAFN(IBX) ; use prior bills
 ;
50 F IBI=1:1:3 F IBJ=50:1:54,58:1:66 S IBFL(IBJ,IBI)=""
 I '$D(^DGCR(399,IBIFN,"AIC")) D  G 80
 . S IBFL(52,1)=$S(+$P(IBSTATE,U,5):"R",1:"Y") ; roi
 . S IBFL(53,1)=$S("Nn0"[$P(IBSTATE,U,6)&($P(IBSTATE,U,6)'=""):"N",1:"Y") ; assign of benifits
 . S IBFL(63,1)=$P(IBSTATE,U,13) ; tx auth cd
 . I $P($G(^DGCR(399.3,+$P(IBCBILL,U,7),0)),U,1)["MEDICARE ESRD" D
 .. S IBFL(50,1)="MEDICARE ESRD",IBFL(51,1)=$P(IBSIGN,U,21),IBFL(58,1)=VADM(1),IBFL(59,1)="01",IBFL(60,1)=$P(VADM(2),U,2)
 ;
INS ;list the primary, secondary .. insurance companies
 F IBI=1:1:3 S IBJ="I"_IBI S IBX=$G(^DGCR(399,IBIFN,IBJ)) I IBX'="" D
 . S IBY=$G(^DIC(36,+IBX,0)) Q:IBY=""
 . S IBFL(50,IBI)=$P(IBY,U,1) ; payer
 . S IBFL(51,IBI)=$P(IBMAIL1,U,(IBI+1)) ; provider #
 . S IBFL(52,IBI)=$S(+$P(IBSTATE,U,5):"R",1:"Y") ; roi
 . S IBFL(53,IBI)=$S("Nn0"[$P(IBSTATE,U,6)&($P(IBSTATE,U,6)'=""):"N",1:"Y") ;assign of benifits
 . S IBFL(54,IBI)=$P(IBCU2,U,3+IBI) ;prior payment
 . S IBFL(58,IBI)=$P(IBX,U,17) ; insureds name
 . S IBFL(59,IBI)=$P(IBX,U,16) ; pt. rel to insured
 . S IBFL(60,IBI)=$P(IBX,U,2) ; insurance number
 . S IBFL(61,IBI)=$P(IBX,U,15) ; insurance group name
 . S IBFL(62,IBI)=$P(IBX,U,3) ; insurance group number
 . S IBFL(63,IBI)="" I IBI=1 S IBFL(63,IBI)=$P(IBSTATE,U,13) ; tx auth cd
 . I $P(IBX,U,6)="v" D
 .. D OPD^VADPT S IBFL(64,IBI)=$P(VAPD(7),U,1) K VAPD I ",3,9,"[+IBFL(64,IBI) Q
 .. S VAOA("A")=5 D OAD^VADPT S IBFL(65,IBI)=VAOA(9),IBFL(66,IBI)=VAOA(4)_$S(VAOA(4)'="":", ",1:"")_$P(VAOA(5),U,2) K VAOA
 . I $P(IBX,U,6)="s" D
 .. S IBFL(64,IBI)=$P($G(^DPT(DFN,.25)),U,15) I ",3,9,"[+IBFL(64,IBI) Q
 .. S VAOA("A")=6 D OAD^VADPT S IBFL(65,IBI)=VAOA(9),IBFL(66,IBI)=VAOA(4)_$S(VAOA(4)'="":", ",1:"")_$P(VAOA(5),U,2)
 . I 'IBFL(64,IBI) S IBFL(64,IBI)=9
 ;
80 ;procedure field locator 80
 K IBPROC
 D PROC^IBCVA1 S IBFL(80)=IBPROC_U_0_U_1,IBFL(80,1)=""
 I +IBPROC S (IBI,IBX)=0 F  S IBX=$O(IBPROC(IBX)) Q:'IBX  D
 . S IBY=$P($$PRCD^IBCEF1($P(IBPROC(IBX),U)),U)
 . S IBI=IBI+1,IBFL(80,IBI)=IBY_U_$$DATE^IBCF3($P(IBPROC(IBX),U,2))
 . I $P(IBPROC(IBX),U,15)'="" S IBM=$P(IBPROC(IBX),U,15) D
 .. F I=1:1:$L(IBM,",") I $P(IBM,",",I)'="" S IBY=$P($$MOD^ICPTMOD($P(IBM,",",I),"I"),U,4) I IBY'="" S IBI=IBI+1,IBFL(80,IBI)=IBY_U_$$DATE^IBCF3($P(IBPROC(IBX),U,2))
 K IBPROC,I,J
 ;
 Q
 ;
STATE(X) ;returns 2 letter abbreviation for state pointer
 Q $P($G(^DIC(5,+$G(X),0)),U,2)
