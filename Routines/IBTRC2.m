IBTRC2 ;ALB/AAS - INSURANCE POLICY CALLS FROM FILE 356.2 DD ; 22-JULY-91
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
DD(IBX,IBDA) ;  - called from input transform for field 1.05
 ; -- input   ibx = x from input transform
 ;           ibda = internal entry in 356.2
 ; -- output  returns x=internal entry in 2.3121 (ins. Mult.) if valid
 ;   
 N DFN,INSDT,ACTIVE,IBDD,IBD,IBCDFN,DA,DR,DIC,DIE
 D VAR
 S X=$$SEL^IBCNS2(IBX,DFN,DT,ACTIVE)
 I +X<1 K X
DDQ Q
 ;
VAR S DFN=$P(^IBT(356.2,IBDA,0),"^",5)
 I DFN="" S DFN=$P($G(^IBT(356,+$P(^IBT(356.2,IBDA,0),"^",2),0)),"^",2)
 S ACTIVE=2,INSDT=DT
 Q
 ;
SEL(IBX,DFN,INSDT,ACTIVE) ; -- Select insurance policy
 ; -- Input    IBX  = x from input transform
 ;             DFN  = patient
 ;           INSDT  = (optional) Active date of ins. (default = dt)
 ;          ACTIVE  = (optional) 1 if want active (default)
 ;                  = 2 if want all ins returned
 ;
 ; -- Output      =  pointer to 36 ^ pointer to 2.3121 ^ pointer to 355.3
 ;
 N I,J,Y,DA,DE,DQ,DR,DIC,DIE,DIR,DIV,IBSEL,IBDD,IBD
 S IBSEL=1,Y=""
 I '$G(ACTIVE) S ACTIVE=2
 S:'$G(INSDT) INSDT=DT
 I '$G(DFN) G SELQ
 D BLD
 ;
 ; -- call DIC to choose from list
 S X=IBX
 S DIC="^DPT("_DFN_",.312,",DIC(0)="EQMN"
 S DIC("S")="I $D(IBDD(+Y))"
 S DIC("W")="W $P(^DIC(36,+^(0),0),U)_""  Group: ""_$$GRP^IBCNS($P(^DPT(DFN,.312,+Y,0),U,18))"
 D ^DIC
SELQ Q +Y
 ;
BLD K IBD,IBDD
 S (IBDD,IBCDFN)=0 F  S IBCDFN=$O(^DPT(+DFN,.312,IBCDFN)) Q:'IBCDFN  I $D(^DPT(DFN,.312,+IBCDFN,0)) D CHK(IBCDFN,ACTIVE,INSDT)
 Q
 ;
CHK(IBCDFN,ACTIVE,INSDT) ; -- see if active
 N X,X1
 S X=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBDD(IBCDFN)=+X_"^"_IBCDFN_"^"_$P(X,"^",18)
 I ACTIVE=2 G CHKQ
 S X1=$G(^DIC(36,+X,0)) I X1="" G CQ ;ins co entry doesn't exist
 I $P(X,"^",8) G:INSDT<$P(X,"^",8) CQ ;effective date later than care
 I $P(X,"^",4) G:INSDT>$P(X,"^",4) CQ ;care after expiration date
 I $P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",11) G CQ ;plan is inactive
 G:$P(X1,"^",5) CQ ;                  ;ins company inactive
 G:$P(X1,"^",2)="N" CQ ;              ;ins company will not reimburse
 G CHKQ
CQ K IBDD(IBCDFN)
CHKQ S:$D(IBDD(IBCDFN)) IBDD=IBDD+1,IBD(IBDD)=IBCDFN
 Q
 ;
 ;
DDHELP(IBDA) ; -- Executable help
 ; -- write out list to choose from
 N DFN,INSDT,ACTIVE,IBDD,IBD,IBCDFN,I,IBINS
 D VAR,BLD
 ;
 I $G(IBDD)=0 W !,"No Insurance Policies to Select From" G DDHQ
 ;
 I '$D(IOM) D HOME^%ZIS
 W ! D HDR^IBCNS
 S I=0 F  S I=$O(IBD(I)) Q:'I  D
 .S IBINS=$G(^DPT(DFN,.312,$G(IBD(I)),0))
 .D D1^IBCNS
DDHQ Q
 ;
TRANS(IBDA,Y) ; -- output transform
 N DFN,INSDT,ACTIVE,IBDD,IBD,IBCDFN
 D VAR
 S Y=$P($G(^DIC(36,+$P($G(^DPT(DFN,.312,+$G(Y),0)),U),0)),U)
 Q Y
 ;
INSCO(IBDA,IBCDFN) ; -- return pointer value of 36 from pt. file
 N DFN,INSDT,ACTIVE,IBDD,IBD
 D VAR
 S Y=+$G(^DPT(DFN,.312,IBCDFN,0))
 Q Y_$S(Y>0:"^"_$P($G(^DIC(36,+Y,0)),"^"),1:"")
