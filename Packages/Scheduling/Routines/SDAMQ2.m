SDAMQ2 ;ALB/MJK - AM Background Utilities (cont.) ; 12/1/91
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
CHK(SDBEG,SDEND,SDPCE) ; -- check if all dates are processed
 N SDDT,X1,X2,X K ^TMP("SDAM NOT UPDATED",$J)
 S SDDT=$S(SDBEG<$$SWITCH^SDAMU:$$SWITCH^SDAMU,1:SDBEG)
 F  Q:SDDT>SDEND  D
 .S:'$P($G(^SDD(409.65,+$O(^SDD(409.65,"B",SDDT,0)),0)),U,SDPCE) ^TMP("SDAM NOT UPDATED",$J,SDDT)=""
 .S X1=SDDT,X2=1 D C^%DTC S SDDT=X
 Q
 ;
WKL(SDBEG,SDEND) ; -- check if all dates have been updated
 W !!,"Will now check if outpatient encounter dates have been updated..."
 D CHK(SDBEG,SDEND,5)
 I '$D(^TMP("SDAM NOT UPDATED",$J))>0 W "everything looks ok.",! G WKLQ
 W !!,*7,"The outpatient encounter status update process has not completed"
 W !,"for the following dates:",!
 D LIST
 W !!,"Note: To obtain accurate statistics, this workload report should"
 W !,"      be run again after the outpatient encounter status update"
 W !,"      process has been completed for these dates.",!
WKLQ K ^TMP("SDAM NOT UPDATED",$J)
 Q
 ;
LIST ; -- list error dates for display
 N COUNT,SDDT
 S COUNT=0,SDDT=0
 F  S SDDT=$O(^TMP("SDAM NOT UPDATED",$J,SDDT)) Q:'SDDT  D
 .S COUNT=COUNT+1 W ?$P("10^30^50",U,COUNT),$$FDATE^VALM1(SDDT)
 .I COUNT=3 W ! S COUNT=0
 Q
