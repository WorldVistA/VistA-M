IBCNS ;ALB/AAS - IS INSURANCE ACTIVE ; 22-JULY-91
 ;;2.0;INTEGRATED BILLING;**28,43,80,82,133,399,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRNS
 ;
 ;Input   -  DFN       = patient
 ;        -  IBINDT  = (optional) date to check ins active for or today if not defined
 ;        -  IBOUTP  = (optional) 1 if want active insurance returned in IBDD(insurance company)=node in patient file
 ;        -            = 2 if want all ins returned
 ;
 ;Output  -  IBINS   = 1 if has active ins., 0 if no active ins.
 ;        -  IBDD()  = internal node in patient file of valid ins.
 ;        -  IBDDI() = internal node in patient file of invalid ins.
 ;
% N J,X S IBINS=0 K IBDD,IBDDI
 ;IB*2.0*516/TAZ - Retrieve Insurance data with HIPAA compliant Fields
 ;S J=0 F  S J=$O(^DPT(DFN,.312,J)) Q:'J  I $D(^DPT(DFN,.312,J,0)) S X=^(0) D CHK
 S J=0 F  S J=$O(^DPT(DFN,.312,J)) Q:'J  I $D(^DPT(DFN,.312,J,0)) S X=$$ZND^IBCNS1(DFN,J) D CHK
 Q
 ;
CHK ;
 ;Input   -  IBI  = entry in insurance multiple
 ;
 S Z=$S($D(IBINDT):IBINDT,1:DT),Z1=$S($D(IBOUTP):IBOUTP,1:0)
 G:'$D(^DIC(36,+X,0)) CHKQ S X1=^(0) ;insurance company entry doesn't exist
 I $P(X,"^",8) G:Z<$P(X,"^",8) CHKQ ;effective date later than care
 I $P(X,"^",4) G:Z>$P(X,"^",4) CHKQ ;care after expiration date
 I $P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",11) G CHKQ ;plan is inactive
 G:$P(X1,"^",5) CHKQ ;insurance company inactive
 I '$G(IBWNR) G:$P(X1,"^",2)="N" CHKQ ;insurance company will not reimburse
 ;IB*2.0*516/TAZ - Return Valid Insurance with HIPAA compliant fields
 S IBINS=1 I Z1 S IBDD(+X)=X
 ;S IBINS=1 I Z1 D
 ;.S IBDD(+X)=X
 ;.Q:'$P(IBDD(+X),"^",18)
 ;.S Y=$G(^IBA(355.3,+$P(IBDD(+X),"^",18),0))
 ;.I $P(Y,"^",4)'="" S $P(IBDD(+X),"^",3)=$P(Y,"^",4) ; move group number
 ;.I $P(Y,"^",3)'="" S $P(IBDD(+X),"^",15)=$P(Y,"^",3) ; move group name
CHKQ ;
 ;IB*2.0*516/TAZ - Return Invalid Insurance with HIPAA compliant Fields
 I Z1=2&('$D(IBDD(+X))) S IBDDI(+X)=X
 ;I Z1=2&('$D(IBDD(+X))) D
 ;.S IBDDI(+X)=X
 ;.Q:'$P(IBDDI(+X),"^",18)
 ;.S Y=$G(^IBA(355.3,+$P(IBDDI(+X),"^",18),0))
 ;.I $P(Y,"^",4)'="" S $P(IBDDI(+X),"^",3)=$P(Y,"^",4) ; move group number
 ;.I $P(Y,"^",3)'="" S $P(IBDDI(+X),"^",15)=$P(Y,"^",3) ; move group name
 K X,X1,Z,Z1,Y Q
 ;
DD ;  - called from input transform and x-refs for field 101,102,103
 ;  - input requires da=internal entry number in 399
 ;  - outputs IBdd(ins co.) array
 ; patch 80 - Companies that Will Not Reimburse should be included so they can be added to the bill
 N DFN,IBWNR S DFN=$P(^DGCR(399,DA,0),"^",2),IBOUTP=1,IBINDT=$S(+$G(^DGCR(399,DA,"U")):+$G(^("U")),1:DT),IBWNR=1
 D %
DDQ K IBOUTP,IBINDT Q
 ;
 ;
DISP ;  -Display all insurance company information
 ;  -input DFN
 ;
 N IBDTIN
DISPDT ; Entrypoint if IBDTIN is to be used to display coverage
 Q:'$D(DFN)  D:'$D(IOF) HOME^%ZIS
 N X,IBINS,IBX
 D ALL^IBCNS1(DFN,"IBINS")
 ;
 D HDR
 I '$D(IBINS) W !,"    No Insurance Information" G DISPQ
 ;
 S X=0 F  S X=$O(IBINS(X)) Q:'X  S IBINS=IBINS(X,0) D D1 I +$G(IBCOVEXT) D D2EXT ; display
 ;
DISPQ W ! S X=+$G(^IBA(354,DFN,60)) I +X W !,?16,"*** Verification of No Coverage ",$$FMTE^XLFDT(X)," ***"
 I $$BUFFER^IBCNBU1(DFN) W !,?17,"***  Patient has Insurance Buffer entries  ***"
 Q
 ;
OLDISP ;  -Display all insurance company information
 ;  -input DFN
 ;
 Q:'$D(DFN)  D:'$D(IOF) HOME^%ZIS
 ;
 S IBOUTP=2 D IBCNS
 ;
 N IBDTIN
 D HDR
 I '$D(IBDD),'$D(IBDDI) W !,"    No Insurance Information" G DISPQ
 ;
 S X="" F  S X=$O(IBDD(X)) Q:X=""  S IBINS=IBDD(X) D D1 ;active insurance
 S X="" F  S X=$O(IBDDI(X)) Q:X=""  S IBINS=IBDDI(X) D D1 ;inactive ins
 ;
OLDISPQ K IBDD,IBDDI,IBX
 Q
 ;
HDR ; -- print standard header
 D HDR1("=",IOM-$S($G(IBDTIN):1,1:4))
 Q
 ;
HDR1(CHAR,LENG) ; -- print header, specify character
 N OFF
 S OFF=$S($G(IBDTIN):0,1:2)
 W !?(1+OFF),"Insurance",?(13+OFF),"COB",?(17+OFF),"Subscriber ID",?(35+OFF),"Group",?(47+OFF),"Holder",?(55+OFF),"Effect"_$S('OFF:"",1:"i")_"ve",?(65+OFF+$S('OFF:0,1:1)),"Expires" W:'OFF ?75,"Only"
 I $G(CHAR)'="",LENG S X="",$P(X,CHAR,LENG)="" W !?(1+OFF),X
 Q
 ;
D1 ; If IBDTIN is defined, this date is used for displaying insurance
 ; coverage if plan does not provide not full coverage for all categories
 N X,Y,Z,CAT,OFF Q:'$D(IBINS)
 S OFF=$S($G(IBDTIN):0,1:2)
 W !?(1+OFF),$S($D(^DIC(36,+IBINS,0)):$E($P(^(0),"^",1),1,10),1:"UNKNOWN")
 S X=$P(IBINS,U,20) I X'="" S X=$S(X=1:"p",X=2:"s",X=3:"t",1:"")
 W ?(14+OFF),X
 W ?(17+OFF),$E($P(IBINS,"^",2),1,16)
 ;W ?40,$E($S($P(IBINS,"^",15)'="":$P(IBINS,"^",15),1:$P(IBINS,"^",3)),1,10)
 W ?(35+OFF),$E($$GRP($P(IBINS,"^",18)),1,10)
 S X=$P(IBINS,"^",6) W ?(47+OFF),$S(X="v":"SELF",X="s":"SPOUSE",1:"OTHER")
 W ?(55+OFF),$$DAT1^IBOUTL($P(IBINS,"^",8)),?(65+OFF+$S(OFF:1,1:0)),$$DAT1^IBOUTL($P(IBINS,"^",4))
 I 'OFF D
 .I $P($G(^DIC(36,+IBINS,0)),U,2)="N" W ?74,"*WNR*" Q
 .S X="" F CAT="INPATIENT","OUTPATIENT","PHARMACY","MENTAL HEALTH","DENTAL","LONG TERM CARE" D
 .. S Y=$$PLCOV^IBCNSU3(+$P(IBINS,"^",18),$G(IBDTIN),+$O(^IBE(355.31,"B",CAT,"")))
 .. I +Y S Z=$S(CAT="PHARMACY":"R",1:$E(CAT)) S:Y>1 Z=$C($A(Z)+32) S X=X_Z
 .S:X="" X="no CV" I X'?6U W ?74,X
 Q
 ;
GRP(IBCPOL) ; -- return group name/group policy
 ;     input:   IBCPOL = pointer to entry in 355.3
 ;    output:   group name or group number, if both group NUMBER
 ;              if neither 'Individual PLAN'
 ;
 ;IB*2.0*516/TAZ Get HIPAA Compliant Fields
 ;original code:
 ;N X,Y S X=""
 ;S X=$G(^IBA(355.3,+$G(IBCPOL),0))
 ;S Y=$S($P(X,"^",4)'="":$P(X,"^",4),1:$P(X,"^",3))
 ;I $P(X,"^",10) S Y="Ind. Plan "_Y
 ;
 N Y
 S Y=$$GET1^DIQ(355.3,+$G(IBCPOL)_",",2.02) ;Group Number
 I Y="" S Y=$$GET1^DIQ(355.3,+$G(IBCPOL)_",",2.01) ;Group Name
 I $$GET1^DIQ(355.3,+$G(IBCPOL)_",",.1) S Y="Ind. Plan "_Y
GRPQ ;
 Q Y
 ;
D2EXT ; display Conditional Coverage Comments and Riders (DFN,IBINS,X required)
 N Y,CAT,IBX,IBY,IBZ,ARR,IBCDFN S IBCDFN=X,IBZ=0 N X
 F CAT="INPATIENT","OUTPATIENT","PHARMACY","MENTAL HEALTH","DENTAL","LONG TERM CARE" D
 . S Y=$$PLCOV^IBCNSU3(+$P(IBINS,"^",18),$G(IBDTIN),+$O(^IBE(355.31,"B",CAT,"")),.ARR)
 . S IBY=CAT_" Conditional: "
 . I +Y>1 S IBX=0 F  S IBX=$O(ARR(IBX)) Q:'IBX  W !,?17,IBY,?47,ARR(IBX) S IBY="",IBZ=1
 ;
 K ARR D RIDERS^IBCNSU3(DFN,IBCDFN,.ARR)
 S IBY="Policy Riders: " S IBX=0 F  S IBX=$O(ARR(IBX)) Q:'IBX  W !,?17,IBY,?35,ARR(IBX) S IBY="",IBZ=1
 I +IBZ W !
 Q
