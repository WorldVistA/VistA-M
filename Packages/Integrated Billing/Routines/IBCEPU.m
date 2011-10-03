IBCEPU ;ALB/TMP - Functions for PROVIDER ID MAINTENANCE ;13-DEC-99
 ;;2.0;INTEGRATED BILLING;**320,348**;21-MAR-94;Build 5
 G AWAY
AWAY Q
 ; This routine is used by various input transforms to make sure the qualifiers 
 ; comply with the spreadsheet of valid qualiers provided by CBO.
 ;
LFINS(Y) ; Lab or Facility provided by insuance
 Q $$CHECK("^1A^1B^1C^1H^G2^LU^N5^X5^",Y)
 ;
NVALFOWN(Y) ; Non-VA Lab or Facility provided by Lab or Facility 
 Q $$CHECK("^0B^TJ^EI^X4^X5^1G^",Y)
 ;
BPS(Y) ; Billing Provider Secodnary IDs
 Q $$CHECK("^0B^1A^1B^1C^1G^1H^B3^BQ^EI^FH^G2^LU^U3^X5^",Y)
 ;
RAOWN(Y) ; Rendering/Attending et al own IDs
 Q $$CHECK("^0B^1G^EI^X5^SY^",Y)
 ;
RAINS(Y) ; Rendering/Attending et al provided by insurance
 Q $$CHECK("^1A^1B^1C^1G^1H^G2^LU^N5^",Y)
 ;
EPT(Y) ; Electronic Plan Type (used to calculate ID based on plan type)
 Q $$CHECK("^1J^",Y)
CHECK(X,Y) ;
 I '$P($G(^IBE(355.97,+Y,0)),U,8) Q 0
 N X12
 S X12=$P($G(^IBE(355.97,+Y,0)),U,3)
 Q:X12="" 0
 S X12=U_X12_U
 I X[X12 Q 1
 Q 0
