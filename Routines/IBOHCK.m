IBOHCK ;ALB/EMG - CHECK FOR IB CHARGES ON HOLD ; MAR 21 1997
 ;;2.0; INTEGRATED BILLING ;**70**; 21-MAR-94
 ;
FIND(DFN,IBIFN) ;  find all related IB charges on hold for episodes of care
 ;  being billed on this third party claim.
 ;  once IB Charge is found, set ON HOLD DATE in file 350 to date
 ;  third party claim is authorized.
 ;
 ;  Input:  DFN -- pointer to the patient in file #2
 ;          IBIFN -- ien of third party Claim
 ;
 I '$G(DFN)!('$G(IBIFN)) G ALLQ
 ;
 N Y,Y1,IBAUTH,IBDT,IBBEG,IBEND,IBERR,IBX,IBOHD
 S IBBEG=$P(^DGCR(399,IBIFN,"U"),"^",1),IBEND=$P(^DGCR(399,IBIFN,"U"),"^",2)
 S IBAUTH=$P($G(^DGCR(399,IBIFN,"S")),"^",10)
 I $D(^IBA(362.4,"AIFN"_+IBIFN)) D RXCHG
 ;
 ;
 ; - find related inpatient/outpatient patient charges on hold
 S IBDT="" F  S IBDT=$O(^IB("AFDT",DFN,IBDT)) Q:'IBDT  I -IBDT'>IBEND S Y=0 F  S Y=$O(^IB("AFDT",DFN,IBDT,Y)) Q:'Y  D
 .S Y1=0 F  S Y1=$O(^IB("AF",Y,Y1)) Q:'Y1  D
 ..Q:'$D(^IB(Y1,0))  S IBX=^(0)
 ..I $P(IBX,"^",14)<IBBEG!($P(IBX,"^",15)>IBEND) Q
 ..I ($P(IBX,"^",5)'=8) Q
 ..S IBOHD=$P($G(^IB(Y1,1)),"^",6) D UPDT
 ..Q
 Q
 ;
UPDT ; Update Integrated Billing Action (#350) On Hold Date field (#16)
 N IBNOHD,FDA
 S IBERR=""
 S IBNOHD=$S(IBAUTH>IBOHD:IBAUTH,1:IBOHD)
 S FDA(350,Y1_",",16)=IBNOHD
 D FILE^DIE("K","FDA")
 ;S DIE="^IB(",DA=Y1,DR="16///^S X=IBNOHD" D ^DIE
 Q
 ;
ALLQ K Y,Y1,IBAUTH,IBBEG,IBC,IBCRG,IBDT,IBEND,IBERR,IBIFN,IBNOHD,IBOHD,IBRXBN,IBRXDT,IBRXEND,IBRXN,IBX
 Q
 ;
 ;
RXCHG ; - find related rx copay's on hold in file 350
 N IBRXN,IBRXBN,IBRXEND,IBRXDT,IBCRG,IBC
 S IBRXN=0 F  S IBRXN=$O(^IBA(362.4,"AIFN"_+IBIFN,IBRXN)) Q:'IBRXN  S IBRXBN=0 F  S IBRXBN=$O(^IBA(362.4,"AIFN"_+IBIFN,IBRXN,IBRXBN)) Q:'IBRXBN  D
 .S IBRXDT=+$P($G(^IBA(362.4,IBRXBN,0)),"^",3)
 .I IBRXDT<IBBEG!(IBRXDT>IBEND) Q
 .S IBRXEND=+IBRXDT+.999999 F  S IBRXDT=$O(^IB("APTDT",DFN,IBRXDT)) Q:'IBRXDT!(IBRXDT>IBRXEND)  S Y1=0 F  S Y1=$O(^IB("APTDT",DFN,IBRXDT,Y1)) Q:'Y1  S IBC=$G(^IB(Y1,0)),IBOHD=$P($G(^IB(Y1,1)),"^",6) D
 ..I $P(IBC,"^",5)'=8 Q
 ..D UPDT Q
 .Q
 ;
