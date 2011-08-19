IBETIME ;ALB/CJM/AAS - Provides entry points to TO^%ZOSV and T1^%ZOSV for ease of turning off data collection ;Sep 16,1992
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;VAXDSM ONLY
 ;
T0 ;start clock
 K IBXRTN Q
 ;Q:'$D(IBXRTN)
 ;S XRTN=IBXRTN_"-"_$S($D(ZTQUEUED):2,1:1)
 ;D T0ZOSV ;T0^%ZOSV
 Q
 ;
T1 ;stop clock
 Q
 ;N XRTL
 ;I $D(XRT0),$D(XRTN) S XRTL=$ZU(0) D T1ZOSV ;T1^%ZOSV
 ;K XRT0,XRTN
 Q
 ;
 ;
T0ZOSV ; start RT clock ; KERNEL 7 LOGIC for VAXDSM
 ;D T0^%ZOSV
 Q
 ;
T1ZOSV ; store RT datum w/ZHDIF ; KERNEL 7 LOGIC for VAXDSM
 ;D T1^%ZOSV
 Q
