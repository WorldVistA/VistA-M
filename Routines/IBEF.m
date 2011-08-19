IBEF ;ALB/AAS - BACKGROUND FILER FOR INTEGRATED BILLING ;12-FEB-91
 ;;2.0;INTEGRATED BILLING;**158**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;  -main background filer routine
 ;  -    for pharmacy copay call ^ibefcop to process
 ;
DQ ;  - entry point for ib background filer
 ;***
 ;I $D(ZTQUEUED) S XRTL=$ZU(0),XRTN="IBEF-2" D T0^%ZOSV ;start rt clock
 ;
 ; -- lock symbolic reference (not real), if already locked, quit.
 L +^IB("IBEF"):5 I '$T G END
 I $S('$D(^IBE(350.9,1,0)):1,'$P(^(0),"^",3):1,$P(^(0),"^",4):1,1:0) G END
 ;I $D(^%ZOSF("PRIORITY")) S X=10 X ^%ZOSF("PRIORITY")
 ;I $D(^%ZOSF("TRAP")) S X="^%ET",@^("TRAP")
 ;
% ;  -set start time, delete stop time, queued = no
 S DIE="^IBE(350.9,",DA=1,DR=".04///NOW;.05///@;.1////0" D ^DIE K DIC,DIE,DR,DA
 ;
 ;  - retention time = 2000 x hang time
 ;  - if data is found ibht is reset to 1
 S IBHANG=$S($P(^IBE(350.9,1,0),"^",8):$P(^(0),"^",8),1:2)
 F IBHT=1:1:2000 D:$D(^IB("APOST")) ^IBEFCOP H IBHANG I $D(^IBE(350.9,1,0)),'$P(^(0),"^",3) Q
 G END
 Q
 ;
END ;
 ;  - delete start time, set stop time
 S DIE="^IBE(350.9,",DA=1,DR=".04///@;.05///NOW" D ^DIE K DIC,DIE,DR,DA
 L -^IB("IBEF")
 ;***
 ;I $D(ZTQUEUED),$D(XRT0) S:'$D(XRTN) XRTN="IBEF" D T1^%ZOSV ;stop rt clock
 Q
 ;
ZTSK ;  - que background filer if not running
 N ZTSK,Y
 ;  -set queued flag to prevent multiple queued filers
 L +^IBE(350.9,0):2 Q:'$T  ;somebody else is queueing off a filer at the  same time
 S DIE="^IBE(350.9,",DA=1,DR=".1////1" D ^DIE K DIE,DA,DR S Y=1
 ;
 S ZTRTN="^IBEF",ZTDTH=$H,ZTIO="",ZTDESC="IB Background"
 K ZTCPU I $D(^IBE(350.9,1,0)) S X=$P(^(0),"^",7) I X'="" S ZTCPU=$P(X,",",2)
 D ^%ZTLOAD
 S Y=$S($D(ZTSK):1,1:"-1^IB019")
 L -^IBE(350.9,0)
 ;
 Q
