SDC4 ;ALB/MJK - Check Range for CO'ed Appts; 28 JUN 1993
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
COED(SDCL,SDBEG,SDEND,SDMSG) ; -- scan appts for those co'ed
 N SDDA,SDATE,SD0,SDC,SDESC
 S SDESC=0,SDATE=SDBEG-.0000001
 F  S SDATE=$O(^SC(SDCL,"S",SDATE)) Q:'SDATE!(SDATE>SDEND)  D
 .S SDDA=0 F  S SDDA=$O(^SC(SDCL,"S",SDATE,1,SDDA)) Q:'SDDA  S SD0=^(SDDA,0),SDC=$G(^("C")) D
 ..I $P(SD0,U,9)="C" Q
 ..I $P(SDC,U,3) S SDESC=1
 I SDESC,SDMSG D MES
 Q SDESC
 ;
MES ; -- write warning to user
 W *7
 W !?5,"At least one appointment has been checked out in the time"
 W !?5,"period selected."
 W !!?5,"As a result, to avoid the loss of workload credit, you are"
 W !?5,"not allowed to cancel availability for this time period."
 W !
 Q
