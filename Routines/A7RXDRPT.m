A7RXDRPT ;DCIOFO/J0 - NDBI PATIENT RECORD MERGE ;10/31/97
 ;;1.0;NDBI;;May 01, 1998
 ;
 ; This routine was originally named XDRPTA7R.  Renamed to A7RXDRPT
 ; for NDBI V1.0 distribution on May 1, 1998. LJA.
 ;
 ; This routine is referenced by the DUPLICATE MERGE patch XT*7.3*23
 ; at integrated sites only. 
EN(A7RARY) ;
 N X
 Q:'$L($G(A7RARY))
 Q:'$D(@A7RARY)
 Q:'$D(^%ZOSF("TEST"))
 ;
 S X="A7RDUP"
 X ^%ZOSF("TEST")
 Q:'$T
 ;
 D EN^A7RDUP(A7RARY,2)
 ;
 Q
