IBCB ;ALB/MRL - BILLING BEGINNING POINT/SELECT BILL OR PATIENT ;01 JUN 88 12:00
 ;;2.0;INTEGRATED BILLING;**52,80,106,51,137,161,199,348**;21-MAR-94;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRB
 ;
EN ;
 D HOME^%ZIS Q:'$D(IBAC)
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCB" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBCB-"_$G(IBAC) D T0^%ZOSV ;start rt clock
 ;
 S:'$D(IBV) IBV=1 L  K ^UTILITY($J),DFN,IBIFN,DIC,IBPOPOUT S DIC(0)="EQMZ" R !!,"Enter BILL NUMBER or PATIENT NAME: ",IBX:DTIME I IBX["^"!(IBX="") S IBAC1=0 Q
 K ^TMP("IBCRRX",$J)
 S IBAC1=1
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 I IBX?1A4N!(IBX?2A.AP)!(IBX?2.A1",".AP)!(IBX?1A1P.AP) S DIC="^DPT(",X=IBX D ^DIC G EN:Y'>0 S DFN=+Y D HINQ S X=$S('$D(^DGCR(399,"C",DFN)):1,'$D(^DGCR(399,"AOP",DFN)):2,1:0)
 I $D(DFN),X,IBAC<4 W !!,"No ",$S(X=1:"",1:"OPEN "),"billing records on file for this patient." D ASK I '$D(IBIFN) G EN
 I $D(DFN) D  G EN
 . D DATE:'$D(IBIFN),ASK:'$D(IBIFN)
 . I $D(IBIFN) D ST
 S DIC("S")=$S(IBAC'=4&(IBAC'=4.1):"I $P(^(0),U,13)<3 D EN^DDIOL($P(^(0),U))",1:"I $P(^(""S""),U,17)="""""_$S(IBAC=4.1:",$P(^(0),U,13)=3,+$$LAST364^IBCEF4(+Y),""PX""[$P($G(^IBA(364,+$$LAST364^IBCEF4(+Y),0)),U,3)",1:""))
 S DIC="^DGCR(399,",X=IBX
 D ^DIC G:Y'>0 EN S IBIFN=+Y,DFN=$P(Y(0),"^",2)
 ;
 D HINQ,ST G EN
 G EN
HINQ I $S('$D(^DPT(DFN,.361)):1,$P(^(.361),"^",1)'="V":1,1:0) W !?17,"*** ELIGIBILITY NOT VERIFIED ***" D HINQ1
MT ;I $D(DFN) D ^DGMT1 K DGMTLL
 I $D(DFN) D DIS^DGMTU(DFN)
 Q
HINQ1 I $P($G(^IBE(350.9,1,1)),"^",16) S X="DVBHQZ4" X ^%ZOSF("TEST") K X I $T W ! D EN^DVBHQZ4 Q
 ;I $P($G(^IBE(350.9,1,1)),"^",16) F X="DVBHQZ4","DGHINQZ4" X ^%ZOSF("TEST") I $T S DGROUT=X K X W ! D @("EN^"_DGROUT) K DGROUT Q
 K Y Q
ASK I IBAC'=1 K IBIFN Q
 W !!,"DO YOU WANT TO ESTABLISH A NEW BILLING RECORD FOR '",$P(^DPT(DFN,0),"^",1),"'" S %=2 D YN^DICN
 I '% W !!?4,"YES - To establish a new billing record in the billing file.",!?4,"NO  - To discontinue this process immediately." G ASK
 I %'=1 K IBIFN Q
 K DA,Y,DINUM,IBIFN S (IBNEW,IBYN)=1 D ^IBCA Q
DATE I $D(^DGCR(399,"C",DFN)) S DA="" F I=1:1 S DA=$O(^DGCR(399,"APDT",DFN,DA)) Q:DA=""  D DATE1
 I IBAC=4,'$D(^UTILITY($J,"IB")) W !,"No ",$S($D(^DGCR(399,"C",DFN)):"UNCANCELLED ",1:""),"billing records on file for this patient." Q
 S CT=0,CT1=1,IBT="" F J=1:1 S IBT=$O(^UTILITY($J,"IB",IBT)) Q:IBT=""  F J1=0:0 S J1=$O(^UTILITY($J,"IB",IBT,J1)) Q:J1=""  S X=J1 D SET
CT W ! S G="",CT2=$S(CT<(CT1+4):CT,1:(CT1+4)) F K=CT1:1:CT2 I $D(^UTILITY($J,"UB",K)) D WRLINE
 S X="" D WDATE Q:X["^"  I '$D(IB),$D(^UTILITY($J,"UB",K+1)) S CT1=K+1 G CT
 K CT,CT1,CT2,K,^UTILITY($J,"UB") Q
WRLINE N IBX S IBDATA=^UTILITY($J,"UB",K),IBX=$G(^DGCR(399,+$P(IBDATA,"^",2),0))
 W !?2,K,?6 S Y=+IBDATA X ^DD("DD") W Y,?27,$P(IBX,"^",1),?35,$S($P(IBX,U,21)="S":"s",$P(IBX,U,21)="T":"t",1:""),?38,$P(IBDATA,"^",3),?59,$E($P(IBDATA,"^",4),1,10),?70,$E($P(IBDATA,"^",5),1,10)
 Q
DATE1 S IBT=$O(^DGCR(399,"APDT",DFN,DA,0)) I $D(^DGCR(399,+DA,0)),$S(IBAC<3:$P(^(0),U,13)<2,IBAC=3:$P(^(0),U,13)<3,'$D(^("S")):0,$P(^("S"),"^",17)]"":0,1:1) S ^UTILITY($J,"IB",IBT,DA)=""
 Q
WDATE Q:'CT  W !! W:K<CT "PRESS <RETURN> TO CONTINUE, OR",! W "CHOOSE 1",$S(CT=1:"",1:"-"_K),": " R X:DTIME Q:X["^"!(X="")  I X["?" W !!,"Select one of the above or <RETURN> to establish a new billing record." G WDATE
 I $S('$D(^UTILITY($J,"UB",+X)):1,+X>K:1,+X<1:1,'(X?.N):1,1:0) W !!,"NOT A VALID CHOICE!!",*7 G WDATE
 S IBIFN=$P(^UTILITY($J,"UB",X),"^",2),IB=1
 Q
 ;
KEYOK(IBIFN,DUZ) ; Check if COB bill, does user have key
 ; IBIFN = ien of bill (file 399)
 ;
 N IBCOB,IBOK,DIR,X,Y
 S IBOK=1,IBCOB=$$COBN^IBCEF(IBIFN)
 I IBCOB>1 D
 . S IBCOB=$P("^SECONDARY^TERTIARY",U,IBCOB)
 . S DIR(0)="YA",DIR("A",1)="YOU ARE ABOUT TO EDIT A "_IBCOB_" BILL",DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE?: ",DIR("B")="NO" W ! D ^DIR K DIR W !
 . I Y'=1 S IBOK=0
 Q IBOK
 ;
SET I $S(IBV:1,$P(^DGCR(399,+X,0),"^",13):1,1:0) S CT=CT+1 D SET2
 Q
SET2 S IBND0=^DGCR(399,+X,0)
 N IBFTP
 S IBFTP=$S($$FT^IBCEF(+X)=3:"/UB",$$FT^IBCEF(+X)=2:"/1500",1:"")
 S ^UTILITY($J,"UB",CT)=9999999-IBT_"^"_+X_"^"_$P($G(^DGCR(399.3,+$P(IBND0,"^",7),0)),"^",4)_"-"_$$BCHGTYPE^IBCU(+X)_"^"_$P($P($P($P(^DD(399,.13,0),"^",3),$P(IBND0,"^",13)_":",2),";",1),"/",1)
 S ^UTILITY($J,"UB",CT)=^UTILITY($J,"UB",CT)_"^"_$S($P(IBND0,U,27)=1:"INST"_IBFTP,$P(IBND0,U,27)=2:"PROF"_IBFTP,1:"")
 Q
ST ; Do not use the variable IBH when calling this entry point
 L ^DGCR(399,IBIFN):5 I '$T W !,"No further processing of this record permitted at this time.",!,"Record locked by another user.  Try again later." Q
 D RECALL^DILFD(399,IBIFN_",",DUZ)
 D NOPTF^IBCB2 I 'IBAC1 D NOPTF1^IBCB2 Q
 I IBAC'=1&(IBAC'=4.1) G ST2
ST1 K ^UTILITY($J) S IBPOPOUT=0
 ; Only allow view of bill waiting for MRA or pending extract
 I $P($G(^DGCR(399,IBIFN,0)),U,13)=2 D  G Q
 . W !,"This bill is requesting an MRA - can only view bill data"
 . S IBV=1 D VIEW^IBCB2
 I IBAC=4.1 D  G Q
 . Q:$P($G(^DGCR(399,IBIFN,0)),U,13)'=3
 . N Z
 . S Z=$P($G(^IBA(364,+$$LAST364^IBCEF4(IBIFN),0)),U,3)
 . I Z'="X"&(Z'="P") Q
 . W !,"This bill has a transmit status of ",$$EXPAND^IBTRE(364,.03,Z)," - can only view bill data"
 . S IBV=1 D VIEW^IBCB2
 D ^IBCSCU,^IBCSC1 G Q:'$T!($G(IBPOPOUT))
ST2 K IBTXPRT,IBPOPOUT
 D ^IBCB1                 ; perform IB edits/authorize the bill
 I $G(IBCIREDT) G ST1     ; Re-edit the bill
 KILL IBCIREDT            ; clean up
 QUIT
 ;
Q ;
 K IBIFN,IBV,IBAC
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCB" D T1^%ZOSV ;stop rt clock
 Q
 ;
EDI S IBAC=1,IBV=0 D EN G Q:'IBAC1,EDI
REV G Q
AUT S IBAC=3,IBV=0 D EN G Q:'IBAC1,AUT
GEN S IBAC=4,IBV=1 D EN G Q:'IBAC1,GEN
VIEW S IBAC=4.1,IBV=1 D EN G Q:'IBAC1,VIEW
 Q
 ;
