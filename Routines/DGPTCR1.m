DGPTCR1 ;ALB/MJK - Census Worklist Re-gen(cont) ; 15 APR 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
ALL ; -- regen all for all census'
 F DGCN=0:0 S DGCN=$O(^DG(45.86,DGCN)) Q:'DGCN  I $D(^(DGCN,0)) S DGCDT=+^(0)_".9",DGFIRST=0 D REGEN^DGPTCR
 K DGCN,DGCDT Q
 ;
QUEALL ; -- queue regen of all census' workfile (used by v5 conversion cleanup)
 W !,">>>CENSUS WORKFILE Regeneration..."
 W !?2,"Please specify when to start CENSUS WORKFILE regeneration."
 W !?2,"Regeneration will take 2-4 hours and should be done during"
 W !?2,"off peak hours.",!
 S ZTSAVE("DGPTCV5")=1,ZTRTN="ALL^DGPTCR1",ZTIO="",ZTDESC="Regenerating ALL CENSUS WORKFILES" D ^%ZTLOAD
 W:$D(ZTSK) !,"Regeneration has been queued.  (Task #",ZTSK,")"
 K ZTSAVE,ZTSK,ZTIO,ZTRTN,ZTDESC Q
