IB20PT1 ;ALB/AAS/NLR - Insurance post init stuff ; 2/22/93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% I '$O(^IBA(355.3,0)) D  ; -- one time updates (ins policy alerady exists
 .D MAIL ;      add new mail group
 .D SITE ;      update site paramters
 .D DEL ;       delete obsolete field in patient file ins. multiple
 .;D PAT ;      x-ref patient file by ins. co., add hip pointer
 .D INS ;       delete data, them dd for ins. address multiple in 36
 .;D 399 ;      add ae x-ref to file 399
 .;D INPT ;     load current inpatients into claims tracking
 .D ^IB20PT6 ;  que off patient file, bill/claims file, CT updates
 ;
 Q
 ;
DEL ; -- delete insurance address field from insurance type multiple
 N DA,DIK,DIU,DIC
 Q:'$D(^DD(2.312,5,0))
 S DA=5,DA(1)=2.312,DIK="^DD("_DA(1)_"," D ^DIK
 W !!,"<<< Deleting Obsolete field *INSURANCE ADDRESS from Patient File Data Dictionary"
DELQ K DA,DIK,DIU
 Q
 ;
INS ; -- delete address subfile
 ;    first delete the data
 N DIC,DIE,DA,DR,DIK,DIU
 Q:'$D(^DD(36.02,0))
 W !!,"<<< Deleting Obsolete *ADDRESS data from Insurance Company Entries"
 W !!,"    I'll write a dot for each 100 entries"
 S IBD0=0
 F  S IBD0=$O(^DIC(36,IBD0)) Q:'IBD0  S IBD1=0 F  S IBD1=$O(^DIC(36,IBD0,2,IBD1)) Q:'IBD1  D  K ^DIC(36,IBD0,2)
 .S DIK="^DIC(36,"_IBD0_",2,",DA=IBD1,DA(1)=IBD0
 .D ^DIK
 .K DA,DIC,DIK
 .S IBCNT=$G(IBCNT)+1
 .W:'(IBCNT#100) "."
 .Q
 ;
 ; -- Now delete the dd
 S DIU=36.02,DIU(0)="S" D EN^DIU2
 W !!,"<<< Deleting Obsolete subfile *ADDRESS from Insurance Company File Data Dictionary"
INSQ K DIU
 Q
 ;
PAT ; -- create AB x-ref on patient file for all insurance co. pointers
 W !!,"<<< Cross-referencing patient file by Insurance company and",!,"    Updating Health Insurance Policy Pointers"
 W !!,"    I'll write a dot for each 100 entries"
 D NOW^%DTC W !,"    Start time: " S Y=% D DT^DIQ
 N DFN,IBI,IBCPOL,IBCDFND,DA,DR,DIE,DIC,IBCNT,IBCNTP,IBCNTPP
 S (IBCNT,IBCNTP,IBCNTPP,DFN)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S IBCNT=IBCNT+1,IBI=0 F  S IBI=$O(^DPT(DFN,.312,IBI)) Q:'IBI  D
 .W:'(IBCNTPP#100) "."
 .S IBCDFND=$G(^DPT(DFN,.312,IBI,0))
 .S ^DPT("AB",+IBCDFND,DFN,IBI)=""
 .S ^DPT(DFN,.312,"B",+IBCDFND,IBI)=""
 .Q:$P(IBCDFND,U,18)
 .S IBCPOL=$$CHIP^IBCNSU(IBCDFND)
 .Q:'IBCPOL
 .S IBCNTPP=IBCNTPP+1
 .S DA=IBI,DA(1)=DFN,DIE="^DPT("_DFN_",.312,"
 .S DR="1.09////1;.18////"_IBCPOL
 .D ^DIE K DA,DR,DIE,DIC
 .Q
 W !!,"<<< Health Insurance Policy information updated"
 W !,"    there were ",IBCNTPP," Policies for ",IBCNT," Patients were updated"
 W !,"    causing ",IBCNTP," Health Insurance Policies to be added"
 D NOW^%DTC W !,"    Finish Time: " S Y=% D DT^DIQ
 Q
 ;
399 ; -- create new AE x-ref of file 399
 N IBCIFN,IBCNT
 W !!,"<<< Cross-referencing Bill/Claims file by Primary Insurer"
 W !!,"    I'll write a dot for each 100 entries"
 S IBCIFN=0,IBCNT=0
 F  S IBCIFN=$O(^DGCR(399,IBCIFN)) Q:'IBCIFN  D
 .I +$G(^DGCR(399,IBCIFN,"M")),$P($G(^(0)),"^",2) S ^DGCR(399,"AE",$P(^(0),"^",2),+^("M"),IBCIFN)=""
 .S IBCNT=$G(IBCNT)+1 W:'(IBCNT#100) "."
 Q
 ;
INPT ; -- load current inpatients into claims tracking
 W !!,"<<< Loading current inpatients into Claims Tracking"
 N WARD,DGPMDA,IBCNT,IB20
 S WARD="",DGPDMA=0,IBCNT=0,IB20=1
 F  S WARD=$O(^DGPM("CN",WARD)) Q:WARD=""  S DGPMDA=0 F  S DGPMDA=$O(^DGPM("CN",WARD,DGPMDA)) Q:'DGPMDA  D
 .S DGPMP=""
 .S DGPMA=$G(^DGPM(DGPMDA,0))
 .S DFN=$P(DGPMA,"^",3)
 .D INP^VADPT
 .K IBNEW D INP^IBTRKR
 .I $G(IBNEW) S IBCNT=IBCNT+1 W !,"    Patient ",$P(^DPT(DFN,0),U)," added to the Claims tracking module"
 ;
 W !!,"<<< ",IBCNT," Patients added to the Claims Tracking Module"
 Q
 ;
MAIL ; -- add new mail group
 ;Q:$D(^XMB(3.8,"B","IB NEW INSURANCE"))
 S DLAYGO=3.8,DIC="^XMB(3.8,",DIC(0)="LX",DIC("DR")="4////PU;5////"_DUZ,X="IB NEW INSURANCE" D ^DIC K DIC I +Y>0 S IBCNMAIL=+Y
 S ^XMB(3.8,+Y,2,0)="^^1^1^2900625^"
 S ^XMB(3.8,+Y,2,1,0)="This mail group will receive notification whenever a new insurance policy is added."
 W !!,"<<< Mail Group 'IB NEW INSURANCE' ",$S($P(Y,"^",3):"added...",1:"updated...")
 W !!,"    Remember to add Members to this group"
 Q
 ;
SITE ; -- setup ib site parameters
 N DIE,DA,DR,DIC,DD,DO S DR=""
 W !!,"<<< Updating new site parameters automatically!"
 ;
 ; -- if no entry add one
 I '$D(^IBE(350.9,1,0)) S (X,DINUM)=1,DIC="^IBE(350.9,",DIC(0)="L" K DD,DO D FILE^DICN K DIC S DR=".03///1;.02////^S X=+$$SITE^VASITE;.08///2;.09///IB ERROR;",DA=1,DIE="^IBE(350.9," D ^DIE K DR,DA,DIE,DIC
 ;
 S DA=1,DIE="^IBE(350.9,"
 S DR="4.01////1;4.04////"_$G(IBCNMAIL)_";6.01///^S X=DT;6.02////1;6.02////1;6.03////1;6.04////1;6.05////1;6.06////1;6.07///^S X=DT;6.08////1;6.09////5;6.13////1;6.14////5;6.18////1;6.19////1"
 D ^DIE K DIE,DA,DR,DIC,DD,DO W !
 Q
