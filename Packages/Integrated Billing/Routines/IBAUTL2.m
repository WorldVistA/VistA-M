IBAUTL2 ;ALB/CPM-MEANS TEST BILLING UTILITIES ;30-AUG-91
 ;;2.0;INTEGRATED BILLING;**52,153,167,187,183**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CHFIND ; Find open charge for a billable event
 ;  Input:  IBEVDA, IBX (C=copay/P=per diem)
 ;  Output: IBCH*DA=0/ien of charge      also IBCH* if IBCH*DA>0
 N J,X S J=0
 F  S J=$O(^IB("ACT",IBEVDA,J)) Q:'J  S X=$G(^IB(J,0)) I X]"",(($P(X,"^",8)["CO-PAY"&(IBX="C"))!($P(X,"^",8)["PER DIEM"&(IBX="P"))) Q:$P(X,"^",5)=1
 S:J IBCHTOTL=$P(X,"^",7),IBCHFR=$P(X,"^",14),IBCHTO=$P(X,"^",15)
 S @("IBCH"_IBX_"DA")=+J Q
 ;
CHADD ; Add a new IB Action in #350
 D ADD^IBAUTL I Y<1 S IBY=Y G CHADDQ
 S $P(^IB(IBN,0),"^",2,16)=DFN_"^"_IBATYP_"^"_IBSL_"^1^1^"_IBCHG_"^"_IBDESC_"^"_IBN_"^^^^"_IBFAC_"^"_IBDT_"^"_IBDT_"^"_IBEVDA
 I $G(IBGMTR) S $P(^IB(IBN,0),"^",21)=1 ; GMT RELATED field #.21
 D NOW^%DTC S $P(^IB(IBN,1),"^")=DUZ,$P(^(1),"^",3,4)=DUZ_"^"_%
 S DIK="^IB(",DA=IBN D IX1^DIK K DIK,DA
 ;I $G(IBJOB)=1 S ^TMP($J,"IBAMTC","I",DFN,IBN)=""
CHADDQ Q
 ;
CHUPD ; Update an IB Action charge
 ;  Input:  IBCHTOTL, IBCHFR, IBDT, IBX(P/C), IBN, IBCHG, DUZ, IBGMTR(opt)
 N TOT,UNIT S UNIT=1
 I IBX="P" S X1=IBDT,X2=IBCHFR D ^%DTC S UNIT=X+1,TOT=UNIT*IBCHG
 I IBX="C" S TOT=IBCHTOTL+IBCHG
 D NOW^%DTC S $P(^IB(IBN,0),"^",6,7)=UNIT_"^"_TOT,$P(^(0),"^",15)=IBDT,$P(^(1),"^",3,4)=DUZ_"^"_%
 I $G(IBGMTR) S $P(^IB(IBN,0),"^",21)=1 ; GMT RELATED field #.21
 S DIK="^IB(",DA=IBN D IX1^DIK K DIK,DA
 ;I $G(IBJOB)=1 S ^TMP($J,"IBAMTC","I",+$G(DFN),IBN)=""
 Q
 ;
SERV ; Find the service pointer for MAS.
 S IBSERV=$P($G(^IBE(350.9,1,1)),"^",14) I '$D(^DIC(49,+IBSERV,0)) S IBY="-1^IB003"
 Q
 ;
TYPE ; Find the IB action type and rate for per diem and OPT co-payment charges.
 ;  Input:   IBDT, IBBS (if IBX=P), IBX (O=opt copay/P=per diem)
 ;           IBTYPE (only if outpatient, specify Basic or Specialty)
 ;  Output:  IBATYP, IBCHG, IBDESC, IBRTED
 N J,IBOLDBS S IBCHG=0,IBDESC=""
 I IBX="O" D
 .S IBBS=$$ITPTR^IBCRU2(9,$S(IBTYPE=2:"SPECIALTY CARE",1:"BASIC CARE"))
 .S IBCS=$$CSN^IBCRU3("TL-MT OPT COPAY")
 .S IBOLDBS=$$MCCRUTL^IBCRU1("OUTPATIENT VISIT",5)
 .D COPAY
 ;
 I IBX="P" S IBATYP=+$P($G(^DGCR(399.1,IBBS,0)),"^",8) I IBATYP D COST X:$D(^IBE(350.1,IBATYP,20)) ^(20)
 I 'IBATYP S IBY="-1^IB008" G TYPEQ
 I 'IBCHG S IBY="-1^IB029"
TYPEQ Q
 ;
COST ; - find per diem charge.   Input:  IBATYP, IBDT   Output:  IBCHG
 N X S X=$O(^IBE(350.2,"AIVDT",IBATYP,-(IBDT+.1))),X=$O(^(+X,0)) I $D(^IBE(350.2,+X,0)) S X=$P(^(0),"^",4)
 S IBCHG=+X Q
 ;
COPAY ; Find the Inpatient/NHCU daily copay rate and IB action type
 ;  Input:  IBBS, IBDT, IBCS (for the opt copay only)
 ; Output:  IBATYP, IBCHG, IBDESC, IBRTED
 ;
 S (IBATYP,IBCHG)=0,IBDESC=""
 S IBATYP=$P($G(^DGCR(399.1,$S($D(IBOLDBS):IBOLDBS,1:IBBS),0)),"^",7) I 'IBATYP S IBY="-1^IB008" G COPAYQ
 I $D(^IBE(350.1,+IBATYP,20)) X ^(20)
 ;
 ; - charge set is not defined as input for inpatient rates
 I '$G(IBCS) S IBCS=$$CSN^IBCRU3("TL-INPT (INCLUSIVE)")
 S IBCHG=$$ITCHG^IBCRCI(IBCS,IBBS,IBDT)
 S IBRTED=$P(IBCHG,"^",2),IBCHG=+IBCHG
 ;
 I 'IBCHG S IBY="-1^IB030"
COPAYQ K IBCS
 Q
