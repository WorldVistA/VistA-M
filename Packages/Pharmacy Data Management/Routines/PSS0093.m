PSS0093 ;BIR/JLC-CHECK FOR SCHEDULES WITH PRN IN NAMES ;02/10/2006
 ;;1.0;PHARMACY DATA MANAGEMENT;**93**;9/30/97
 ;
 ;
 Q
EN K ZTSAVE,ZTSK S ZTRTN="ENQN^PSS0093",ZTDESC="PDM - Check for schedules with PRN in name",ZTIO="" D ^%ZTLOAD
 W !!,"The check for PRN schedules is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
ENQN N IEN,PSSC,PSS,SCHED
 S PSS=6,PSS(6,0)="",IEN=0 F  S IEN=$O(^PS(51.1,IEN)) Q:'IEN  D
 . S SCHED=$P($G(^PS(51.1,IEN,0)),"^") I $L(PSS(PSS,0))>55 S PSS=PSS+1,PSS(PSS,0)=""
 . I SCHED["PRN" S PSS(PSS,0)=PSS(PSS,0)_SCHED_", "
SENDMSG ;Send mail message when check is complete.
 N XMDUZ,XMSUB,XMTEXT,XMY
 S XMDUZ="MANAGEMENT,PHARMACY DATA",XMSUB="CHECK FOR PRN SCHEDULES COMPLETE",XMTEXT="PSS(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSS(1,0)="  The check for PRN schedules completed as of "_Y_"."
 S PSS(2,0)=" ",PSS(3,0)="The following schedules contain PRN. Please change the schedule type"
 S PSS(4,0)="to PRN if appropriate.",PSS(5,0)=" "
 D ^XMD Q
