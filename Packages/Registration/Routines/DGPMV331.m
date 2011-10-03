DGPMV331 ;ALB/MIR - ASIH DISCHARGE PROCESSING ; 11 JAN 89 @9
 ;;5.3;Registration;;Aug 13, 1993
ASIH ;if admission type was TO ASIH...
 Q:'$D(^DGPM(+$P(DGPMAN,"^",21),0))  S DGPMAI=$P(^(0),"^",14),DGPMAA=$S($D(^DGPM(+DGPMAI,0)):^(0),1:"")
 D DEL:($P(DGPMA,"^",18)=41),CRXFR:($P(DGPMA,"^",18)=46) G Q:("^41^46^"[("^"_$P(DGPMA,"^",18)_"^"))
 Q:+DGPMP=+DGPMA
 S DA=$S($D(^DGPM(+$P(DGPMAA,"^",17),0)):$P(DGPMAA,"^",17),1:"") I $D(^DGPM(+DA,0)),($P(^(0),"^",18)=47) G Q
 I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,3,DA,"P")=$S($D(^UTILITY("DGPM",$J,3,DA,"P")):^("P"),1:^DGPM(DA,0)),DR=".01///"_+DGPMA_";.22////"_2,DIE="^DGPM(" K DQ,DG D ^DIE S ^UTILITY("DGPM",$J,3,DA,"A")=^DGPM(DA,0) ;update NHCU/DOM discharge
 S DIE="^DGPM(",DA=DGPMDA,DR=".22////"_1 K DQ,DG D ^DIE
 S DA=$P(DGPMAA,"^",16) I $D(^DGPT(+DA,0)) S DIE="^DGPT(",DR="70////"_+DGPMA K DQ,DG D ^DIE ;update NHCU/DOM PTF discharge date
Q K DGPMAA,DGPMAI,DGPMXMT Q
DEL ;delete the NHCU discharge if FROM ASIH - called from transfer, too
 S DA=$S($D(^DGPM(+$P(DGPMAA,"^",17),0)):$P(DGPMAA,"^",17),1:"")
 I $D(^DGPM(+DA,0)) D
 . S ^UTILITY("DGPM",$J,1,DGPMAI,"P")=DGPMAA
 . S ^UTILITY("DGPM",$J,3,DA,"P")=$S($D(^UTILITY("DGPM",$J,3,DA,"P")):^("P"),1:^DGPM(DA,0)),^("A")="",DIK="^DGPM(" D ^DIK ;Delete ASIH discharge
 . S ^UTILITY("DGPM",$J,1,DGPMAI,"A")=$G(^DGPM(DGPMAI,0))
 S DA=$S($D(^DGPT(+$P(DGPMAA,"^",16),0)):$P(DGPMAA,"^",16),1:"") I DA S DR="70///@;71///@;72///@",DIE="^DGPT(" K DQ,DG D ^DIE:DR]""
 Q:DGPMT=2  ;quit if coming from xfr routine (returning from ASIH (O.F.)
CRXFR ;for FROM ASIH and CONTINUED ASIH (O.F.), create corresponding transfer
 S DGMAS=$S($P(DGPMA,"^",18)=41:14,1:45) D FAMT^DGPMV30 S (DGX,DGHX)=DGFAC K DGFAC ;get active mvt type for from asih or continued asih (of) transfer
 S DIE="^DGPM(",DR=".22////"_1,DA=DGPMDA K DQ,DG D ^DIE ;set sequence number for hospital discharge
 S DIE("NO^")="",X=+DGPMA,DGPM0ND=+DGPMA_"^"_2_"^"_DFN_"^"_DGX_"^^^^^^^^^^"_DGPMAI_"^^^^^^^^"_2 D NEW^DGPMV3
 S ^UTILITY("DGPM",$J,2,+Y,"P")="",^UTILITY("DGPM",$J,2,+Y,"A")=$G(^DGPM(+Y,0))
 S DGX=$S($P(DGPMA,"^",18)=41:14,1:45)
 S DIE="^DGPM(",(DA,DGPMXMT)=+Y,DR=$S(DGX=45:".05",1:".06;.07"),DIE("NO^")="" I DGX=14 K DQ,DG D ^DIE G:'$P(^DGPM(DA,0),"^",6) UNDO S ^UTILITY("DGPM",$J,2,DA,"A")=^DGPM(DA,0) D SPEC Q
 S X=0 F I=+DGPMAN:0 S I=$O(^DGPM("APMV",DFN,DGPMAI,I)) Q:'I  S J=$O(^(I,0)) I $D(^DGPM(+J,0)),("^13^43^"[("^"_$P(^(0),"^",18)_"^")) S X=^(0) Q
 I X S I=$O(^DGPM("APMV",DFN,DGPMAI,I)),J=$O(^(+I,0)) I $D(^DGPM(+J,0)) S X=^(0),DR=DR_$S($P(X,"^",6):";.06////"_$P(X,"^",6),1:"")_$S($P(X,"^",7):";.07////"_$P(X,"^",7),1:"")
 K DQ,DG D ^DIE I $P(^DGPM(DA,0),"^",5) S ^UTILITY("DGPM",$J,2,DA,"A")=^DGPM(DA,0) D SPEC Q
UNDO ;delete discharge/transfer is time-out during transfer
 S DGPMER=1 W !!,*7,*7,"Time-out during ASIH movement...now deleting discharge and transfer"
 S DIK="^DGPM(" F DA=DGPMDA,DGPMXMT D ^DIK S ^UTILITY("DGPM",$J,$S(DA=DGPMDA:3,1:2),"A")=""
 I $P(DGPMA,"^",18)=41 D SET^DGPMV32 Q:'$D(^DGPM(+$P(DGPMAN,"^",21),0))  N DGPMCA,DGPMAN S DGPMCA=$P(^(0),"^",14),DGPMAN=$S($D(^DGPM(DGPMCA,0)):^(0),1:"") D ASIHOF^DGPMV321
 Q
SPEC ;ask specialty on return?
 S Y=DGPMXMT I $D(^DG(405.1,+DGHX,0)),$P(^(0),"^",5) D SPEC^DGPMV36
 K DGHX
 Q
