DGRPDD ;ALB/MLI - MISC DD CALLS FOR REGISTRATION ; 29 JUN 92
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;This routine is used to store misc. DD calls from registration
 ;
 ;
FAMINF ; called from SHOW FAMILY INFO SCREEN field in the TYPE OF
 ; PATIENT file.
 ;
 I $P($G(^DG(391,DA,0)),"^",1)["NSC" S X=1 W *7,"  (YES)"
 Q
 ;
 ;
INCSCR ; called from SHOW INCOME SCREENING SCREEN field in the TYPE OF
 ; PATIENT file.
 ;
 I $P($G(^DG(391,DA,0)),"^",1)["NSC" S X=1 W *7,"  (YES)"
 Q
