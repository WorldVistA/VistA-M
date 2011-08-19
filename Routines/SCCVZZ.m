SCCVZZ ; ACRP DATABASE CONVERSION - Testing utility - ALPHA SITE ONLY;ALB/TMP - 2/1998
 ;;5.3T1;Scheduling;**211**;Aug 13, 1993
 ;
 ;  EN^SCCVZZ is called by the estimator as it determines what would
 ;     probably be converted
 ;
 ;  MOVE^SCCVZZ is called after the estimate has completed to resequence 
 ;     the array by encounter #
 ;
 ;  RECON^SCCVZZ is called after a completed convert/reconvert to delete
 ;     all the 'matching entries' from the estimate and the conversion
 ;     See routine SCCVZZ1 for additional documentation
 ;
 ;  CLEAN1^SCCVZZ is called when one template's temporary reconciliation
 ;     files need to be deleted. (^XTMP)
 ;
 ;  CLEANUP^SCCVZZ is called when the temporary reconciliation files for
 ;     all templates in file 404.98 need to be deleted. (^XTMP)
 ;
 ;
EN(P1,P2,P3,P4,P5,P6) ; Save estimate entities
 Q
 ;
SETERR(FILE,ENCTR,NUM,SCLOG) ; Sets up error arrray for CPTs, PRVs, and POVs
 Q
 ;
