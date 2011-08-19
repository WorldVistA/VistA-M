IBTRKR2 ;ALB/AAS - ADD/TRACK SCHEDULED ADMISSION ;9-AUG-93
 ;;2.0;INTEGRATED BILLING;**43,62,214,312**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
EN ; -- add scheduled admissions to claims tracking file
 N I,J,X,Y,IBTRKR,IBI,IBJ,DFN,IBDATA
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI()                   ;IB*2.0*312
 S IBTRKR=$G(^IBE(350.9,1,6))
 G:'$P(IBTRKR,"^",2) ENQ ; inpatient tracking off
 S:'$G(IBTSBDT) IBTSBDT=$$FMADD^XLFDT(DT,-3)-.1
 S:'$G(IBTSEDT) IBTSEDT=$$FMADD^XLFDT(DT,7)+.9
 I IBTSBDT<+IBTRKR S IBTSBDT=+IBTRKR-.1 ; start date can't be before ct start date
 S IBI=IBTSBDT-.0001
 F  S IBI=$O(^DGS(41.1,"C",IBI)) Q:'IBI!(IBI>IBTSEDT)  S IBJ="" F  S IBJ=$O(^DGS(41.1,"C",IBI,IBJ)) Q:'IBJ  D
 .;
 .;Do NOT PROCESS on VistA if IBI/Sched DT>=Switch Eff Dt  ;CCR-930
 .I +IBSWINFO,(IBI+1)>$P(IBSWINFO,"^",2) Q                 ;IB*2.0*312
 .;
 .S IBDATA=$G(^DGS(41.1,IBJ,0))
 .S DFN=+IBDATA
 .Q:'DFN  ;  no patient
 .Q:$P(IBDATA,"^",17)  ; already admitted
 .;
 .S IBTRN=$O(^IBT(356,"ASCH",IBJ,0))
 .I $P(IBDATA,"^",13) D:IBTRN INACTIVE^IBTRKRU(IBTRN) Q  ; canceled
 .;
 .; - if not in ct add
 .I 'IBTRN D  Q
 ..I $P(IBTRKR,"^",2)=2 D SCH^IBTUTL2(DFN,IBI,IBJ) Q
 ..I $P(IBTRKR,"^",2)=1,$S('$$INSURED^IBCNS1(DFN,+IBI):0,1:$$PTCOV^IBCNSU3(DFN,+IBI,"INPATIENT")) D SCH^IBTUTL2(DFN,IBI,IBJ) Q
 ..D TRKR^IBCNRDV(DFN,IBI,IBJ,$P(IBDATA,"^",11))
 ..Q
 .;
 .; - if inactive re-activate
 .I '$P(^IBT(356,+IBTRN,0),"^",20) D
 ..N X,Y,I,J,DA,DR,DIE,DIC
 ..S DA=IBTRN,DR=".2////1",DIE="^IBT(356," D ^DIE
 .Q
 ;
ENQ K IBTSEDT,IBTSBDT
 ; add cleanup of ARDV
 S X=0 F  S X=$O(^IBT(356,"ARDV",X)) Q:X<1  S Y=0 F  S Y=$O(^IBT(356,"ARDV",X,Y)) Q:Y<1  I Y<DT K ^IBT(356,"ARDV",X,Y)
 Q
 ;
SCH(DGPMCA) ; -- is this admission movement a scheduled admission
 ; -- output scheduled admission pointer
 ;
 N IBTSA S IBTSA=0
 I '$G(DGPMCA) G SCHQ
 S IBTSA=+$O(^DGS(41.1,"AMVT",DGPMCA,0))
SCHQ Q IBTSA
