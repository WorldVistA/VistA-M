IBYAPT1 ;ALB/CPM - PATCH IB*2*28 INSURANCE CLEAN-UP ; 30-JAN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;
BKG ; Queue off a background job to clean up various insurance files.
 W !!,">>> Queuing off a job to clean up various insurance files..."
 W !,"    (You'll get a message when the job is completed)",!
 S ZTRTN="FIX^IBYAPT1",ZTDTH=$H,ZTIO=""
 S ZTDESC="IB - PATCH IB*2*28 POST INIT - INSURANCE CLEAN-UP"
 D ^%ZTLOAD
 W !?4,$S($D(ZTSK):"The job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.  Please run FIX^IBYAPT1 at any time.")
 K ZTSK
 Q
 ;
 ;
FIX ; Perform clean-up of Insurance Company files.
 ;
 D NOW^%DTC S IBBDT=%
 ;
 D PLAN ;   Clean up x-refs in file #355.3
 D AB ;     Delete errant Annual Benefits from file #355.4
 D BU ;     Delete errant Benefits Used from file #355.5
 D RIDER ;  Delete errant Riders from file #355.7
 D IR ;     Repoint 'Insurance Company Contacted' for
 ;           Insurance Reviews in file 356.2
 ;
 D NOW^%DTC S IBEDT=%
 ;
 D MAIL ; send out results
 K IBBDT,IBEDT,IBR,IBC,IBV,IBP,IBPD,IBV1,IBCT,IBT,IBX,XMSUB,XMTEXT,XMDUZ,XMY,Y
 Q
 ;
 ;
 ;
PLAN ; Clean up the 'AGNU' and 'AGNA' x-refs in file #355.3
 F IBR="AGNA","AGNU" D
 .S IBC=0 F  S IBC=$O(^IBA(355.3,IBR,IBC)) Q:'IBC  D
 ..S IBV="" F  S IBV=$O(^IBA(355.3,IBR,IBC,IBV)) Q:IBV=""  D
 ...S IBP=0 F  S IBP=$O(^IBA(355.3,IBR,IBC,IBV,IBP)) Q:'IBP  D
 ....S IBPD=$G(^IBA(355.3,IBP,0))
 ....S IBV1=$P(IBPD,"^",$S(IBR="AGNA":3,1:4))
 ....I +IBPD'=IBC!(IBV'=IBV1) S IBCT(IBR)=$G(IBCT(IBR))+1 K ^IBA(355.3,IBR,IBC,IBV,IBP)
 Q
 ;
AB ; Delete errant Annual benefits from file #355.4
 S IBC=0 F  S IBC=$O(^IBA(355.4,IBC)) Q:'IBC  S IBX=$G(^(IBC,0)) D
 .S IBV=0 I '$P(IBX,"^",2) S IBV=1
 .I 'IBV,'$D(^IBA(355.3,+$P(IBX,"^",2),0)) S IBV=1
 .I IBV S DA=IBC,DIK="^IBA(355.4,",DIDEL=355.4 D ^DIK S IBCT("AB")=$G(IBCT("AB"))+1
 Q
 ;
BU ; Delete errant Benefits Used from file #355.5
 S IBC=0 F  S IBC=$O(^IBA(355.5,IBC)) Q:'IBC  S IBX=$G(^(IBC,0)) D
 .S IBV=0 I 'IBX S IBV=1
 .I 'IBV,'$D(^IBA(355.3,+IBX,0)) S IBV=1
 .I 'IBV,$P($G(^DPT(+$P(IBX,"^",2),.312,+$P(IBX,"^",17),0)),"^",18)'=+IBX S IBV=1
 .I IBV S DA=IBC,DIK="^IBA(355.5,",DIDEL=355.5 D ^DIK S IBCT("BU")=$G(IBCT("BU"))+1
 Q
 ;
RIDER ; Delete errant Riders from file #355.7
 S IBC=0 F  S IBC=$O(^IBA(355.7,IBC)) Q:'IBC  S IBX=$G(^(IBC,0)) D
 .S IBV=0 I '$D(^DPT(+$P(IBX,"^",2),.312,+$P(IBX,"^",3),0)) S IBV=1
 .I IBV S DA=IBC,DIK="^IBA(355.7,",DIDEL=355.7 D ^DIK S IBCT("RD")=$G(IBCT("RD"))+1
 Q
 ;
IR ; Repoint Insurance Reviews in file #356.2
 S IBC=0 F  S IBC=$O(^IBT(356.2,IBC)) Q:'IBC  S IBX=$G(^(IBC,0)),IBX1=$G(^(1)) D
 .S IBCDFN=+$P(IBX1,"^",5),IBCDFND=$G(^DPT(+$P(IBX,"^",5),.312,IBCDFN,0))
 .K IBVAL
 .I IBCDFN,IBCDFND,+$P(IBX,"^",8)'=+IBCDFND S IBVAL=+IBCDFND
 .I IBCDFN,'IBCDFND S IBVAL=0
 .I $G(IBVAL)]"" D
 ..I IBVAL S DA=IBC,DR=".08////"_+IBCDFND,DIE="^IBT(356.2," D ^DIE K DIE,DA,DR
 ..I 'IBVAL S $P(^IBT(356.2,IBC,1),"^",5)=""
 ..S IBCT("IR")=$G(IBCT("IR"))+1
 K IBX1,IBCDFN,IBCDFND,IBVAL
 Q
 ;
MAIL ; Send results out.
 S XMSUB="Patch IB*2*28 Insurance Clean-up Completion"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT(",XMY(DUZ)=""
 ;
 K IBT
 S IBT(1)="The Insurance Files clean-up job has completed."
 S IBT(2)=" "
 S Y=IBBDT D D^DIQ S IBT(3)="Job Start Time: "_Y
 S Y=IBEDT D D^DIQ S IBT(4)="  Job End Time: "_Y
 S IBT(5)=" "
 S IBT(6)=" Number of AGNA cross references in file #355.3 deleted: "_+$G(IBCT("AGNA"))
 S IBT(7)=" Number of AGNU cross references in file #355.3 deleted: "_+$G(IBCT("AGNU"))
 S IBT(8)="Number of errant Annual Benefits in file #355.4 deleted: "_+$G(IBCT("AB"))
 S IBT(9)="  Number of errant Benefits Used in file #355.5 deleted: "_+$G(IBCT("BU"))
 S IBT(10)="Number of errant Personal Riders in file #355.7 deleted: "_+$G(IBCT("RD"))
 S IBT(11)="   Number of Insurance Reviews in file #356.2 repointed: "_+$G(IBCT("IR"))
 ;
 D ^XMD
 Q
