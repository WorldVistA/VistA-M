IBAUTL5 ;ALB/CPM - MEANS TEST BILLING UTILITIES (CON'T.) ; 02-JAN-92
 ;;Version 2.0 ; INTEGRATED BILLING ;**15**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PASS ; Find unbilled charges for an event and pass to Accounts Receivable.
 ;  Input:  IBEVDA, IBY    Output:  IBCHCDA, IBCHPDA are reset to 0.
 N IBNOS,IBACTN
 S IBACTN=0 F  S IBACTN=$O(^IB("AF",IBEVDA,IBACTN)) Q:'IBACTN!(IBY<1)  I IBACTN'=IBEVDA,$P($G(^IB(IBACTN,0)),"^",5)=1 S IBNOS=IBACTN D FILER
 S (IBCHCDA,IBCHPDA)=0 Q
 ;
FILER ; Pass charge to Accounts Receivable.   Input:  IBNOS
 ; - first, get a bill number and build a complete charge..
 N IBATYP,IBNOW D NOW^%DTC S IBNOW=%
 ;S IBTOTL=0,IBATYP=$P($G(^IB(IBNOS,0)),"^",3)
 ;D BILLNO^IBAUTL K IBARTYP I Y<1 S IBY=Y G FILERQ
 ;S DIE="^IB(",DA=IBNOS,DR=".05////2;.11////"_IBIL_";.12////"_IBTRAN
 ;D ^DIE K DIE,DR,DA I $D(Y) S IBY="-1^IB020" G FILERQ
 ;
 ; - doing IVM-related back-billing?
 I $G(IBJOB)=9 S DIE="^IB(",DA=IBNOS,DR=".05////21" D ^DIE K DIE,DA,DR G FILERQ
 ;
 ; - and then pass the charge to A/R.
 S IBSEQNO=1,IBDUZ=DUZ D ^IBR K IBSEQNO,IBDUZ,IBARTYP,IBN
 I Y<1 S IBY=Y,IBWHER=IBWHER+25 G FILERQ
 ;I $G(IBJOB)=1,IBNOS S ^TMP($J,"IBAMTC","I",+$G(DFN),IBNOS)=""
FILERQ Q
 ;
LAST ; Find Last Billed date, if one exists, for pts. w/o billable events
 ;  Input:  DFN, IBADMDT    Output:  IBBDT (if past event exists)
 N IBD,IBDATE,IBTEMP,J,DA S IBD=IBADMDT\1,J=-9999999,(IBDATE,DA)=0
 F  S J=$O(^IB("AFDT",DFN,J)) Q:'J!(-J<IBD)  D
 . F  S DA=$O(^IB("AFDT",DFN,J,DA)) Q:'DA  D
 ..  I $P($G(^IB(DA,0)),"^",8)["ADMISSION" S IBTEMP=$P(^(0),"^",18) D
 ...   I 'IBDATE S IBDATE=IBTEMP Q
 ...   I IBTEMP>IBDATE S IBDATE=IBTEMP
 I IBDATE S X=IBDATE D H^%DTC S IBBDT=%H+1
 Q
 ;
DIEM() ; Find the earliest date for which the per diem charge may be billed.
 Q $S($P($G(^IBE(350.9,1,0)),"^",12):$P(^(0),"^",12),1:9999999)
 ;
SECT(FTS) ; Find the billable bedsection.
 ;  Input:     Facility Treating Specialty (IEN from file #45.7)
 ;  Returned:  Billable bedsection from file 399.1 (MCCR UTILITY), or
 ;             0 if the specialty does not have a corresp. bedsection
 S FTS=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+FTS,0)),"^",2),0)),"^",5)
 Q $S(FTS]"":+$O(^DGCR(399.1,"B",FTS,0)),1:0)
 ;
CONT(DFN) ; Find continuous patient discharge date.
 ;  Input:  DFN  Returned:        0 - not continuous
 ;                          9999999 - still continuous, or
 ;                          actual discharge date from continuous stay
 N X S X=0
 I $O(^IBE(351.1,"B",DFN,0)) S X=$P($G(^IBE(351.1,+$O(^(0)),0)),"^",2) S:'X X=9999999
 Q X
 ;
STD(DFN) ; Is the patient's A/R Statement date 4 days from now?
 ;  Input:  DFN    Returned:  Statement date in 4 days? (1 - yes, 0 - no)
 S X1=DT,X2=4 D C^%DTC
 Q $$PST^PRCAFN(DFN_";DPT(")=+$E(X,6,7)
 ;
OE(DGPMDA) ; Was the patient admitted for Observation & Examination?
 ;  Input:     DGPMDA - pointer to 0th node of pt mvt (adm) in file #405
 ;  Returned:  O&E Admission? (1 - yes, 0 - no)
 N AR,SOA,DGPM0
 S DGPM0=$G(^DGPM(+DGPMDA,0))
 S AR=+$P(DGPM0,"^",12),SOA=+$G(^DGPT(+$P(DGPM0,"^",16),101))
 Q $D(^DIC(43.4,"D",17.45,AR))!($D(^DIC(45.1,"B","1T",SOA)))
 ;
ASIH(PM) ; Is patient movement an ASIH movement?
 ;  Input:     PM - 0th node of patient movement in file #405
 ;  Returned:  ASIH Movement? (1 - yes, 0 - no)
 Q "^13^14^40^41^42^43^44^45^46^47^"[("^"_$P($G(PM),"^",18)_"^")
 ;
CVA(DFN) ; Is CHAMPVA the patient's Primary Eligibility?
 ;  Input:  DFN    Returned:  Prim Elig = CHAMPVA? (1 - yes, 0 - no)
 Q $P($G(^DIC(8,+$G(^DPT(+$G(DFN),.36)),0)),"^",9)=12
