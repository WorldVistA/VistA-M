IBYHPRE ;ALB/TMP - PATCH IB*2*43 ENVIRONMENT CHECK ; 21-AUG-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**43**; 21-MAR-94
 ;
 D DUZ
 D P6:$D(DIFQ),P8:$D(DIFQ),P13:$D(DIFQ),P23:$D(DIFQ),P40:$D(DIFQ),P45:$D(DIFQ)
 ; (Assume patch 28 is there if patch 40 is)
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
P6 ; Make sure IB 2.0 patch 6 is installed.
 N X
 S X=$T(+2^IBCOIVM)
 I X'["**6" D
 .W !!?3,"Patch IB*2*6 does not appear to be installed!  Please"
 .W !?3,"install this patch and then re-run this initialization."
 .K DIFQ
 Q
P8 ; Make sure IB 2.0 patch 8 is installed.
 N X
 S X=$T(+2^IBCU5)
 I X'["**8" D
 .W !!?3,"Patch IB*2*8 does not appear to be installed!  Please"
 .W !?3,"install this patch and then re-run this initialization."
 .K DIFQ
 Q
P13 ; Make sure IB 2.0 patch 13 is installed.
 N X
 S X=$T(+2^IBTRKR3)
 I X'["**13" D
 .W !!?3,"Patch IB*2*13 does not appear to be installed!  Please"
 .W !?3,"install this patch and then re-run this initialization."
 .K DIFQ
 Q
P23 ; Make sure IB 2.0 patch 23 is installed.
 N X
 S X=$T(+2^IBTRKR)
 I X'["**23" D
 .W !!?3,"Patch IB*2*23 does not appear to be installed!  Please"
 .W !?3,"install this patch and then re-run this initialization."
 .K DIFQ
 Q
P40 ; Make sure IB 2.0 patch 40 is installed.
 N X
 S X=$T(+2^IBAFIL)
 I X'["**40" D
 .W !!?3,"Patch IB*2*40 does not appear to be installed!  Please"
 .W !?3,"install this patch and then re-run this initialization."
 .K DIFQ
 Q
P45 ; Make sure IB 2.0 patch 45 is installed.
 N X
 S X=$T(+2^IBTRKR)
 I X'["45**" D
 .W !!?3,"Patch IB*2*45 does not appear to be installed!  Please"
 .W !?3,"install this patch and then re-run this initialization."
 .K DIFQ
 Q
