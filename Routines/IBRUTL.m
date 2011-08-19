IBRUTL ;ALB/CPM-INTEGRATED BILLING - A/R INTERFACE UTILITIES ;03-MAR-92
 ;;2.0;INTEGRATED BILLING;**70,82,132,142,176,179,202,223,363**;21-MAR-94;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
IB(IEN,RETN) ; Are there any IB Actions on hold for this bill?
 ;         Input:   IEN         -- ien of Bill(#399), A/R(#430)
 ;                  RETN (opt)  -- Want array of IB Actions? (1-Yes,0-No)
 ;                                 if yes, returns IBA(num)=ibn
 ;         Returns: 1 -- Yes, 0 -- No
 ;
 N ATYPE,BTYPE,BILLS,DFN,IBFR,IB0,IBTO,IBU,IBN,IBND,IBNUM,IBOK
 S:'$D(RETN) RETN=0 S BILLS=0
 ;
 ; - determine patient, bill type and billing dates
 S IB0=$G(^DGCR(399,IEN,0)),IBU=$G(^("U")),DFN=+$P(IB0,"^",2)
 S BTYPE=$S(+$P(IB0,"^",5)<3:"I",1:"O"),IBFR=+IBU,IBTO=$P(IBU,"^",2)
 ;
 ; - loop through all bills on hold, and set flag if there is an
 ; - IB Action of the same type as the UB-82 which has been billed
 ; - within the statement dates of the UB-82.  Store all actions
 ; - in the array IBA if required.
 S (IBN,IBNUM)=0 F  S IBN=$O(^IB("AH",DFN,IBN)) Q:'IBN  D  I IBOK Q:'RETN  S IBNUM=IBNUM+1,IBA(IBNUM)=IBN
 . S IBOK=0,IBND=$G(^IB(IBN,0)) Q:'IBND
 . S ATYPE=$S($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")["OPT":"O",1:"I") Q:ATYPE'=BTYPE
 . Q:$P(IBND,"^",15)<IBFR!($P(IBND,"^",14)>IBTO)  S (IBOK,BILLS)=1
 ;
 Q BILLS
 ;
 ;
HOLD(X,IBN,IBDUZ,IBSEQNO) ; Place IB Action on hold?
 ;         Input:        X -- Zeroth node of IB Action
 ;                     IBN -- ien of IB Action
 ;                   IBDUZ -- User ID
 ;                 IBSEQNO -- 1 (New Action), 3 (Update Action)
 ;         Returns:      1 -- Yes, 0 -- No
 ;
 N DFN,IBCOV,IBINDT,IBOUTP,HOLD,IBHOLDP,IBDUZ,I
 N IBVDT,IBAT,IBCAT,IBALTC
 ;
 S HOLD=0
 S IBHOLDP=$P($G(^IBE(350.9,1,1)),"^",20) ; Site parameter - HOLD MT BILLS W/INSURANCE
 S DFN=+$P(X,"^",2)
 ;
 ;check if ECME RX copay needs to be placed on HOLD
 I $$HOLDECME^IBNCPUT1(X)=0 G HOLDQ
 ;
 I $P(X,"^",5)=8 G HOLDQ ; action is already on hold
 I '$P($G(^IBE(350.1,+$P(X,"^",3),0)),"^",10) G HOLDQ ; action can't be placed on hold
 ;
 ; - see if patient has insurance on Charge 'To' Date (otherwise Event date)
 ; - includes check of plan coverage limitation
 S IBINDT=+$P($G(^IB(+$G(IBN),0)),U,15)
 I 'IBINDT S IBINDT=+$P($G(^IB(+$P(X,"^",16),0)),"^",17) I 'IBINDT S IBINDT=DT
 S IBOUTP=1
 D ^IBCNS
 S IBVDT=$S(IBINDT'="":IBINDT,1:DT),IBAT=$P(^IBE(350.1,(+$P(X,U,3)),0),U,11)
 S IBCAT=$S(IBAT<4:"INPATIENT",IBAT=4:"OUTPATIENT",IBAT=5:"PHARMACY",IBAT=8:"OUTPATIENT",IBAT=9:"INPATIENT",1:"")
 S IBCOV="" I IBCAT'="" S IBCOV=$$PTCOV^IBCNSU3(DFN,IBVDT,IBCAT),HOLD=IBCOV
 I 'IBCOV,+$$BUFFER^IBCNBU1(DFN) S (IBCOV,HOLD)=1 ; if patient has a buffer entry place charge on hold
 ;
 ;
 ; - generate bulletin if patient has insurance, bulletin not suppressed
 I IBCOV,'$P($G(^IBE(350.9,1,0)),"^",15),'$$ECME(IBN) D ^IBRBUL
 ;
 ; - update action to 'Hold' if parameter is set and vet has insurance
 I IBHOLDP,IBCOV S DIE="^IB(",DA=IBN,DR=".05////8" D ^DIE,UP3^IBR:IBSEQNO=3 K DA,DIE,DR
 ;
HOLDQ Q +$G(HOLD)
 ;
ECME(IBN) ; return 1 if ECME billed already and bulleting should not go
 N IBX,IBR,IBZ
 S (IBR,IBX)=0,IBZ=^IB(IBN,0)
 F  S IBX=$O(^IBA(362.4,"B",$P($P(IBZ,"^",8),"-"),IBX)) Q:'IBX!(IBR)  I $P($G(^DGCR(399,+$P(^IBA(362.4,IBX,0),"^",2),0)),"^",13)=4,$$FMDIFF^XLFDT($P(IBZ,"^",17),$P(^(0),"^",3),1)<6 S IBR=1
 Q IBR
