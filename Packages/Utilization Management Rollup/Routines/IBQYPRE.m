IBQYPRE ;ALB/CPM - ENVIRONMENT CHECK FOR PATCH IBQ*1*1 ; 04-DEC-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**1**;Oct 01, 1995
 ;
 D NOW^%DTC S IBQBDT=$H,Y=%
 W !!,"Initialization Started: " D DT^DIQ W !!
 ;
 D DUZ,ENV:$D(DIFQ)
 ;
 I '$D(DIFQ) W !!,"PATCH IBQ*1*1 INITIALIZATION ABORTED..." K IBQBDT
 Q
 ;
 ;
DUZ ; Check to see if a valid user is defined and that DUZ(0)="@"
 N X S X=$O(^VA(200,+$G(DUZ),0))
 I X']""!($G(DUZ(0))'="@") W !!?3,"The variable DUZ must be set to a valid entry in the NEW PERSON file",!?3,"and the variable DUZ(0) must equal ""@"" before you continue!" K DIFQ
 Q
 ;
ENV ; Make sure UM Rollup v1.0 is installed.
 N X
 S X="IBQLLD" X ^%ZOSF("TEST") E  K DIFQ W !?3,"You must install the QM Rollup package before installing this patch!"
 Q
