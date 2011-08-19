DGCRNS ;ALB/AAS - IS INSURANCE ACTIVE ; 22-JULY-91
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;
 ;Input   -  DFN       = patient
 ;        -  DGCRINDT  = (optional) date to check ins active for or today if not defined
 ;        -  DGCROUTP  = (optional) 1 if want active insurance returned in DGCRDD(insurance company)=node in patient file
 ;        -            = 2 if want all ins returned
 ;
 ;Output  -  DGCRINS   = 1 if has active ins., 0 if no active ins.
 ;        -  DGCRDD()  = internal node in patient file of valid ins.
 ;        -  DGCRDDI() = internal node in patient file of invalid ins.
 ;
% N J,X S DGCRINS=0 K DGCRDD,DGCRDDI
 S J=0 F  S J=$O(^DPT(DFN,.312,J)) Q:'J  I $D(^DPT(DFN,.312,J,0)) S X=^(0) D CHK
 Q
 ;
CHK ;
 ;Input   -  DGCRI  = entry in insurance multiple
 ;
 S Z=$S($D(DGCRINDT):DGCRINDT,1:DT),Z1=$S($D(DGCROUTP):DGCROUTP,1:0)
 G:'$D(^DIC(36,+X,0)) CHKQ S X1=^(0) ;insurance company entry doesn't exist
 I $P(X,"^",8) G:Z<$P(X,"^",8) CHKQ ;effective date later than care
 I $P(X,"^",4) G:Z>$P(X,"^",4) CHKQ ;care after expiration date
 I $P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",11) G CHKQ ;plan is inactive
 G:$P(X1,"^",5) CHKQ ;insurance company inactive
 G:$P(X1,"^",2)="N" CHKQ ;insurance company will not reimburse
 S DGCRINS=1 I Z1 S DGCRDD(+X)=X
CHKQ S:Z1=2&('$D(DGCRDD(+X))) DGCRDDI(+X)=X
 K X,X1,Z,Z1 Q
 ;
DD ;  - called from input transform and x-refs for field 101,102,103
 ;  - input requires da=internal entry number in 399
 ;  - outputs dgcrdd(ins co.) array
 N DFN S DFN=$P(^DGCR(399,DA,0),"^",2),DGCROUTP=1,DGCRINDT=$S(+$G(^DGCR(399,DA,"U")):+$G(^("U")),1:DT)
 D %
DDQ K DGCROUTP,DGCRINDT Q
 ;
 ;
DISP ;  -Display all insurance company information
 ;  -input DFN
 ;
 Q:'$D(DFN)  D:'$D(IOF) HOME^%ZIS
 S DGCROUTP=2 D DGCRNS
 ;
 D HDR
 I '$D(DGCRDD),'$D(DGCRDDI) W !,"No Insurance Information" G DISPQ
 ;
 S X="" F  S X=$O(DGCRDD(X)) Q:X=""  S IBINS=DGCRDD(X) D D1 ;active insurance
 S X="" F  S X=$O(DGCRDDI(X)) Q:X=""  S IBINS=DGCRDDI(X) D D1 ;inactive ins
 ;
DISPQ K DGCRDD,DGCRDDI,DGCRX
 Q
 ;
HDR W !?4,"Insurance Co.",?22,"Policy #",?40,"Group",?52,"Holder",?60,"Effective",?70,"Expires" S X="",$P(X,"=",IOM-4)="" W !?4,X
 Q
 ;
 ;
D1 N X Q:'$D(IBINS)
 W !?4,$S($D(^DIC(36,+IBINS,0)):$E($P(^(0),"^",1),1,16),1:"UNKNOWN")
 W ?22,$E($P(IBINS,"^",2),1,16),?40,$E($S($P(IBINS,"^",15)'="":$P(IBINS,"^",15),1:$P(IBINS,"^",3)),1,10)
 S X=$P(IBINS,"^",6) W ?52,$S(X="v":"SELF",X="s":"SPOUSE",1:"OTHER")
 W ?60,$$DAT1^IBOUTL($P(IBINS,"^",8)),?70,$$DAT1^IBOUTL($P(IBINS,"^",4))
 Q
