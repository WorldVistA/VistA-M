IB20PT6 ;ALB/AAS - Insurance post init stuff ; 2/22/93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% S IBFORCE=1
 I '$O(^IBA(355.3,0)) D  ; -- one time updates (ins policy alerady exists
 .D PAT ;            x-ref patient file by ins. co., add hip pointer
 .D 399^IB20PT61 ;   add ae x-ref to file 399
 .D INPT ;           load current inpatients into claims tracking
 ;
 K IBFORCE
 Q
 ;
PAT ; -- create AB x-ref on patient file for all insurance co. pointers
 W !!!,"<<< Patient file insurance conversion"
 W !,"    Cross-reference patient file by Insurance company and",!,"    Update Health Insurance Policy Pointers"
 S ZTRTN="PATDQ^IB20PT6",ZTDESC="IB - v2 PATIENT FILE POST INIT UPDATE",ZTIO="" S:$G(IBFORCE) ZTDTH=$$15
 W ! D ^%ZTLOAD I '$D(ZTSK) D  Q:'IBOK
 .D MANUAL^IB20PT61
 .I 'IBOK,$P($G(^IBE(350.9,1,3)),"^",18)="" W !!,"You must run the v2.0 post init routine IB20PT6 before allowing users to",!,"edit insurance information"
 I $D(ZTSK) W !,"    Patient file update queued as task ",ZTSK K ZTSK Q
 ;
PATDQ D NOW^%DTC S IBSPDT=%
 I '$D(ZTQUEUED) D
 .W !!,"    I'll write a dot for each 100 entries"
 .W !,"    Start time: " S Y=IBSPDT D DT^DIQ
 N DFN,IBI,IBCPOL,IBCDFND,DA,DR,DIE,DIC,IBCNT,IBCNTP,IBCNTPP,IBCNTI
 S (IBCNT,IBCNTP,IBCNTPP,IBCNTI,DFN)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S IBCNT=IBCNT+1,IBI=0 S:$O(^DPT(DFN,.312,IBI)) IBCNTI=IBCNTI+1 F  S IBI=$O(^DPT(DFN,.312,IBI)) Q:'IBI  D
 .I '$D(ZTQUEUED) W:'(IBCNTPP#100) "."
 .S IBCDFND=$G(^DPT(DFN,.312,IBI,0))
 .S ^DPT("AB",+IBCDFND,DFN,IBI)=""
 .S ^DPT(DFN,.312,"B",+IBCDFND,IBI)=""
 .Q:$P(IBCDFND,U,18)
 .S IBCPOL=$$CHIP^IBCNSU(IBCDFND)
 .Q:'IBCPOL
 .Q:+IBCDFND'=+$G(^IBA(355.3,+IBCPOL,0))  ; patient ins. and policy must have same ins. company file.
 .S IBCNTPP=IBCNTPP+1
 .S DA=IBI,DA(1)=DFN,DIE="^DPT("_DFN_",.312,"
 .S DR="1.09////1;.18////"_IBCPOL
 .D ^DIE K DA,DR,DIE,DIC
 .Q
 S $P(^IBE(350.9,1,3),"^",18)=DT
 D NOW^%DTC S IBEPDT=%
 D BULL1^IB20PT61
 I '$D(ZTQUEUED) D
 .W !!,"<<< Health Insurance Policy information updated"
 .W !,"    there were ",IBCNTPP," Policies for ",IBCNT," Patients were updated"
 .W !,"    causing ",IBCNTP," Health Insurance Policies to be added"
 .W !,"    Finish Time: " S Y=IBEPDT D DT^DIQ
 Q
 ;
 ;
INPT ; -- load current inpatients into claims tracking
 W !!!,"<<< Load current inpatients into Claims Tracking"
 S ZTRTN="INPTDQ^IB20PT6",ZTDESC="IB - v2 CLAIMS TRACKING POST INIT UPDATE",ZTIO="" S:$G(IBFORCE) ZTDTH=$$15
 W ! D ^%ZTLOAD I '$D(ZTSK) D  Q:'IBOK
 .D MANUAL^IB20PT61
 .I 'IBOK,$P($G(^IBE(350.9,1,3)),"^",20)="" W !!,"You must run the v2.0 post init routine IB20PT6 to automatically add",!,"Current inpatient into Claims Tracking."
 I $D(ZTSK) W !,"    Claims Tracking update queued as task ",ZTSK K ZTSK Q
 ;
INPTDQ D NOW^%DTC S IBSTDT=%
 N WARD,DGPMDA,IBCNT,IB20
 S WARD="",DGPDMA=0,IBCNT=0,IB20=1
 F  S WARD=$O(^DGPM("CN",WARD)) Q:WARD=""  S DGPMDA=0 F  S DGPMDA=$O(^DGPM("CN",WARD,DGPMDA)) Q:'DGPMDA  D
 .S DGPMP=""
 .S DGPMA=$G(^DGPM(DGPMDA,0)) Q:DGPMA=""
 .S DFN=$P(DGPMA,"^",3) Q:'DFN
 .D INP^VADPT
 .K IBNEW D INP^IBTRKR
 .I $G(IBNEW) S IBCNT=IBCNT+1 I '$D(ZTQUEUED) W !,"    Patient ",$P(^DPT(DFN,0),U)," added to the Claims tracking module"
 ;
 I '$D(ZTQUEUED) W !!,"<<< ",IBCNT," Patients added to the Claims Tracking Module"
 D NOW^%DTC S IBETDT=%
 D BULL3^IB20PT61
 S $P(^IBE(350.9,1,3),"^",20)=DT
 Q
 ;
15() ; -- Add 15 minutes to now and return in $h format
 Q $P($H,",")_","_($P($H,",",2)+(15*60))
