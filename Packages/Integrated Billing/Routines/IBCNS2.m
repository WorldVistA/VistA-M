IBCNS2 ;ALB/AAS - INSURANCE POLICY CALLS FROM FILE 399 DD ;22-JULY-91
 ;;2.0;INTEGRATED BILLING;**28,43,80,51,137,155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
DD(IBX,IBDA,LEVEL) ;  - called from input transform for field 111,112,113
 ; -- input   ibx = x from input transform
 ;           ibda = internal entry in 399
 ;          level = 1=primary, 2=secondary, 3=tertiary
 ; -- output  returns x=internal entry in 2.3121 (ins. Mult.) if valid
 ;   
 N DFN,ACTIVE,INSDT
 D VAR
 S X=$$SEL(IBX,DFN,INSDT,ACTIVE)
 I +X<1 K X
DDQ Q
 ;
VAR S DFN=$P(^DGCR(399,IBDA,0),"^",2),ACTIVE=1,INSDT=$S(+$G(^DGCR(399,IBDA,"U")):+$G(^("U")),1:DT)
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
 I '$G(ACTIVE) S ACTIVE=1
 S:'$G(INSDT) INSDT=DT
 I '$G(DFN) G SELQ
 D BLD
 ;
 ; -- call DIC to choose from list
 S X=IBX
 S DIC="^DPT("_DFN_",.312,",DIC(0)="EQMN"
 S DIC("S")="I $D(IBDD(+Y))" ; add not other selection
 S DIC("W")="W $P(^DIC(36,+^(0),0),U)_""  Group: ""_$$GRP^IBCNS($P(^DPT(DFN,.312,+Y,0),U,18))"
 D ^DIC
SELQ Q +Y
 ;
BLD K IBD,IBDD
 S (IBDD,IBCDFN)=0 F  S IBCDFN=$O(^DPT(DFN,.312,IBCDFN)) Q:'IBCDFN  I $D(^DPT(DFN,.312,IBCDFN,0)) D CHK(IBCDFN,ACTIVE,INSDT)
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
 ;G:$P(X1,"^",2)="N" CQ ;              ;ins company will not reimburse
 G CHKQ
CQ K IBDD(IBCDFN)
CHKQ S:$D(IBDD(IBCDFN)) IBDD=IBDD+1,IBD(IBDD)=IBCDFN
 Q
 ;
 ;
DDHELP(IBDA,LEVEL) ; -- Executable help
 ; -- write out list to choose from
 N DFN,ACTIVE,INSDT,I,IBINS
 D VAR,BLD
 ;
 I $G(IBDD)=0 W !,"No Insurance Policies to Select From" G DDHQ
 ;
 I '$D(IOM) D HOME^%ZIS
 N IBDTIN
 S IBDTIN=$G(INSDT)
 W ! D HDR^IBCNS
 S I=0 F  S I=$O(IBD(I)) Q:'I  D
 .S IBINS=$G(^DPT(DFN,.312,$G(IBD(I)),0))
 .D D1^IBCNS
DDHQ Q
 ;
TRANS(IBDA,Y) ; -- output transform
 N DFN,ACTIVE,INSDT
 D VAR
 S Y=$P($G(^DIC(36,+$P($G(^DPT(DFN,.312,+$G(Y),0)),U),0)),U)
 Q Y
 ;
INSCO(IBDA,IBCDFN) ; -- return pointer value of 36 from pt. file
 N DFN,ACTIVE,INSDT
 D VAR
 S Y=+$G(^DPT(DFN,.312,IBCDFN,0))
 Q Y_$S(Y>0:"^"_$P($G(^DIC(36,+Y,0)),"^"),1:"")
 ;
IX(DA,XREF) ; -- create i1, aic xrefs for fields 112, 113, 114
 ;
 S ^DGCR(399,DA,XREF)=$$ZND^IBCNS1($P($G(^DGCR(399,DA,0)),"^",2),X)
 S ^DGCR(399,DA,"AIC",+$G(^DPT($P($G(^DGCR(399,DA,0)),"^",2),.312,+X,0)))=""
 Q
 ;
KIX(DA,XREF) ; -- kill logic for above xref
 K ^DGCR(399,DA,XREF)
 K ^DGCR(399,DA,"AIC",+$G(^DPT($P($G(^DGCR(399,DA,0)),"^",2),.312,+X,0)))
 Q
 ;
BPP(IBDA,IBMCR) ; Find Bill Payer Policy based on Payer Sequence and the P/S/T payers assigned to the bill,Ins Co must reimburse
 ; IBMCR = flag that says include MEDICARE WNR
 ; returns - Bill Payer Policy (ifn of policy entry in patient file)
 ;         - null if either no Payer Sequence or there is no policy defined for the payer sequence
 ;           or the policy defined by the payer sequence Will Not Reimburse and is not MEDICARE
 ;
 N IBI,IBX,IBY,IBP,IBC,IBM0 S IBX="",(IBP,IBC)=0
 S IBMCR=+$G(IBMCR)
 S IBY=$$COBN^IBCEF(+IBDA) I IBY S IBY=IBY+11
 I IBY S IBM0=$G(^DGCR(399,+IBDA,"M")),IBP=$P(IBM0,U,IBY)
 I IBP S IBY=IBY-11,(IBI,IBY)=$P(IBM0,U,IBY) I +IBY S IBC=$P($G(^DIC(36,+IBY,0)),U,2)
 I IBP,IBI,$S(IBC'="N":1,'IBMCR:0,1:$$MCRWNR^IBEFUNC(+IBY)) S IBX=IBP
 Q IBX
