GMPLY40 ;ISP/TC - Pre/Post Install Routine for GMPL*2.0*40 ;01/14/16  13:47
 ;;2.0;Problem List;**40**;Aug 25, 1994;Build 9
 ;
POST ; Post-install subroutine
 ;
 ; Scan Problem file for SCT in Diagnosis field errors
 D EN^GMPLCLNP
 ; Scan Problem file for incorrect mapping (SCT 428283002, ICD-9 V15.89)
 D EN1^GMPLCLNP
 Q
