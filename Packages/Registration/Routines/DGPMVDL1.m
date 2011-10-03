DGPMVDL1 ;ALB/MIR - DELETE PATIENT MOVEMENTS, CONTINUED ; 11 JAN 88 @9
 ;;5.3;Registration;;Aug 13, 1993
D3 ;can this discharge be deleted?
 I $P(DGPMP,"^",18)=42 S DGPMER=1 W !,"You can not delete a WHILE ASIH type discharge" Q
 I $P(DGPMAN,"^",21),("^41^46^"[("^"_+$P(DGPMP,"^",18)_"^")) S DGPMER=1 W !,"Delete through corresponding NHCU/DOM movements" Q
 I $O(^DGPM("APTT1",DFN,+DGPMP)) S DGPMER=1 W !,"Can only delete discharge for last admission" Q
 S X=$O(^DGPM("APTT1",DFN,+DGPMP)),Y=$O(^DGPM("APTT4",DFN,+DGPMP))
 I X!Y S DGPMER=1 W !,"There is a",$S(X:"n admission",1:" check-in")," movement following this discharge.",!,"You can only remove a discharge when it is the last movement for the patient." Q
 I $P(DGPMP,"^",18)=47,("^13^44^"[("^"_$P(DGPM0,"^",18)_"^")),$D(^DGPM(+$P(DGPM0,"^",15),0)),$P(^(0),"^",17) S DGPMER=1 W !,"You must delete the hospital discharge first" Q
 Q
3 I $P(DGPMP,"^",18)=47 G 47
 S DGPMADM=DGPMCA D DD,DS^DGPTMSG1
 K DA Q:$P(DGPMAN,"^",18)'=40  I $D(^DGPM(+$P(DGPMAN,"^",21),0)) S DGPMTN=^(0),DGPMNI=$P(DGPMTN,"^",14) I $D(^DGPM(+DGPMNI,0)) S DA=$P(^(0),"^",17),DGPMPTF=$P(^(0),"^",16) I $D(^DGPM(+DA,0)),($P(^(0),"^",18)=47) Q
 Q:'$D(DA)  D FINDLAST^DGPMV32 Q:'DGPMAB  S X1=+DGPMAB,X2=30 D C^%DTC S DGPMPD=X,DIE="^DGPM(",DR=".01///"_X_";.22////0"
 K DQ,DG Q:'$D(^DGPM(+DA,0))  S ^UTILITY("DGPM",$J,3,DA,"P")=^(0) D ^DIE S ^UTILITY("DGPM",$J,3,DA,"A")=^DGPM(DA,0) ;delete ASIH sequence and restore 30 days if deleting hospital discharge
 S DA=DGPMPTF,DIE="^DGPT(",DR="70////"_DGPMPD D ^DIE ;update PTF d/c d/t
 Q
47 ;if DISCHARGE FROM NHCU/DOM WHILE ASIH
 S DGPMNI=+$P(DGPMP,"^",14),DGPMTN=DGPM0 D FINDLAST^DGPMV32
 Q:'+DGPMAB  S X1=DGPMAB,X2=30 D C^%DTC S DGMAS=42 D FAMT^DGPMV30 S DIE="^DGPM(",DA=DGPMDA,DR=".01///"_X_";.04////"_DGFAC D ^DIE K DGFAC
 Q
D4 Q
4 ;check-in...delete all related lodger movements
 F DGI=DGPMDA:0 S DGI=$O(^DGPM("CA",DGPMDA,DGI)) Q:'DGI  I $D(^DGPM(DGI,0)) S DA=DGI,DIK="^DGPM(" D ^DIK
 Q
D5 ;can't be followed by another movement
 S X=$O(^DGPM("APTT1",DFN,+DGPMP)),Y=$O(^DGPM("APTT4",DFN,+DGPMP))
 I X!Y S DGPMER=1 W !,"There is a",$S(X:"n admission",1:" check-in")," movement following this check-out.",!,"You can only remove a check-out when it is the last movement for the patient."
 Q
5 ;check-out...delete pointer in check-out movement
 S ^UTILITY("DGPM",$J,4,DGPMCA,"P")=$S($D(^UTILITY("DGPM",$J,4,DGPMCA,"P")):^("P"),1:DGPMAN)
 S DA=DGPMDA,DIK="^DGPM(" D ^DIK
 S ^UTILITY("DGPM",$J,4,DGPMCA,"A")=$G(^DGPM(DGPMCA,0))
 Q
D6 ;can't delete ts mvt associated w/CA
 I $P(DGPMP,"^",14),$P(DGPMP,"^",14)=$P(DGPMP,"^",24) S DGPMER=1 W !,"You are not allowed to delete a specialty transfer that is",!,"assoicated with the initial admission movement."
 Q
6 ; -- treating specialty xfrs
 Q
DD ;Delete discharge, update admission mvt, and PTF record
 ;pass in DGPMADM - admission mvt for which d/c is being deleted
 Q:'$D(^DGPM(+DGPMADM,0))  S DA=$P(^(0),"^",17) I '$D(^DGPM(+DA,0)) Q
 S ^UTILITY("DGPM",$J,1,DGPMADM,"P")=$S($D(^UTILITY("DGPM",$J,1,DGPMADM,"P")):^("P"),1:^DGPM(+DGPMADM,0)) ;adm mvt before deletion
 S ^UTILITY("DGPM",$J,3,DA,"P")=^DGPM(DA,0),^("A")="",DIK="^DGPM(" D ^DIK
 S ^UTILITY("DGPM",$J,1,DGPMADM,"A")=^DGPM(+DGPMADM,0) ;set after of admission
 S DA=$P(^DGPM(DGPMADM,0),"^",16),DIE="^DGPT(",DR="70///@;71///@;72///@" D ^DIE
 K DGPMADM Q
