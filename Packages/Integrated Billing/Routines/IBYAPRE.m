IBYAPRE ;ALB/CPM - PATCH IB*2*28 ENVIRONMENT CHECK ; 25-JAN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;
 D DUZ,AR:$D(DIFQ)
 Q
 ;
 ;
DUZ ; Check to see if a valid user is defined and that DUZ(0)="@"
 N X S X=$O(^VA(200,+$G(DUZ),0)) W !
 I X']""!($G(DUZ(0))'="@") D
 .W !!?3,"The variable DUZ must be set to a valid entry in the NEW PERSON file"
 .W !?3,"and the variable DUZ(0) must equal ""@"" before you continue!"
 .K DIFQ
 Q
 ;
AR ; Make sure an appropriate AR patch is installed.
 N X
 S X="RCAMINS" X ^%ZOSF("TEST")
 I '$T D
 .W !!?3,"Patch PRCA*4*24 or PRCA*4.5*6 does not appear to be installed!  Please"
 .W !?3,"install the appropriate patch and then re-run this initialization."
 .K DIFQ
 Q
