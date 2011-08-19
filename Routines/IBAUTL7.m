IBAUTL7 ;AAS/ALB - RX EXEMPTION UTILITY ROUTINE (CONT.) ; 2-NOV-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CURREX(IBSTAT,IBDT) ;update current status if current year
 ;  input :    dfn  =  patient file pointer
 ;            ibdt  =  internal form of effective date
 ;          ibstat  =  status = 1 if exempt, 0 if not exempt
 ;
 N X,Y,DIC,DIE,DR,DA
 I $S('$D(DFN):1,'$D(IBSTAT):1,IBSTAT=0:0,IBSTAT=1:0,1:1) G CURREXQ
 ;
 ; -- make sure ibdt > old current date
 S X=+$P($G(^IBA(354,DFN,0)),"^",3)
 I '$G(IBFORCE),$G(IBOLDAUT)'?7N,X>IBDT G CURREXQ ;only if most recent (I took this out for awhile but don't know why, its needed to keep from updating old over new)
 ;
 ; -- not greater than today
 ;I IBDT>DT G CURREXQ
 ;
 S DIE="^IBA(354,",DA=DFN,DR="[IB CURRENT STATUS]" D ^DIE ; set status in billing patient file
 I $D(Y) S IBEXERR=6,IBWHER=14
 ;DR=".04////"_IBSTAT_";.03////"_IBDT_";.05////"_IBEXREA
 ;
CURREXQ Q
 ;
INACT(IBDT) ; -- must inactivate active exemptions before creating new exemption
 ;    should only be called from addex so event driver logic works
 ;
 N IBX,X,Y,DA,DR,DIE,DIC
 S IBX=0 F  S IBX=$O(^IBA(354.1,"AIVDT",1,DFN,-IBDT,IBX)) Q:'IBX  D
 .S DA=IBX
 .I $P($G(^IBA(354.1,DA,0)),"^",10)'=1 Q
 .I '$D(ZTQUEUED),$D(IBTALK) W:IBTALK<2 !,"Deleting Active flag from current entry" S IBTALK=IBTALK+1
 .S DA=IBX,DIE="^IBA(354.1,",DR="[IB INACTIVATE EXEMPTION]" D ^DIE K DIC,DIE,DA,DR
 .I $D(Y) S IBEXERR=7,IBWHER=15
 .;S IBACTION="CHG"
 .Q
INACTQ Q
 ;
DUPL() ; -- see if entry is a duplicate
 N X,Y
 S X=0
 S Y=$$LST^IBARXEU0(DFN,IBDT)
 I IBDT=+Y,+IBEXREA=+$P(Y,"^",5),IBTYPE=$P(Y,"^",3) S X=1
 Q X
 ;
 ;
ALERT() ; -- use alerts or bulletins
 ;    returns 1 = use alerts
 ;            0 = use bulletins
 ;
 Q $P($G(^IBE(350.9,1,0)),"^",14)
