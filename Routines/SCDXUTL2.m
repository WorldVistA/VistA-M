SCDXUTL2 ;ALB/MTC/JLU - PRINT UTILITY ROUTINES;23-MAY-1996 ; 20 Nov 98 12:25 AM
 ;;5.3;Scheduling;**44,66,154**;AUG 13, 1993
 ;
PAT(D0) ;-- This function is used for the computed field 20.01 in file
 ;   Transmission OutPatient Encounter file 409.73. For the given
 ;   entry in 409.73 a determination of the PATIENT involved with
 ;   the transaction will be determined.
 ;
 N SDTOE
 S SDTOE=$G(^SD(409.73,D0,0))
 I $P(SDTOE,U,2)="",$P(SDTOE,U,3) D
 . S X=$P($G(^SD(409.74,$P(SDTOE,U,3),0)),U,2)
 E  I $P(SDTOE,U,2),$P(SDTOE,U,3)="" D
 . S X=$P($G(^SCE($P(SDTOE,U,2),0)),U,2)
 E  S X=""
 I X S X=$P($G(^DPT(X,0)),U)
 Q
 ;
SSN(D0) ;-- This function is used for the computed field 20.04 in file
 ;   Transmission OutPatient Encounter file 409.73. For the given
 ;   entry in 409.73 a determination of the PATIENT SSN involved with
 ;   the transaction will be determined.
 ;
 N SDTOE
 S SDTOE=$G(^SD(409.73,D0,0))
 I $P(SDTOE,U,2)="",$P(SDTOE,U,3) D
 . S X=$P($G(^SD(409.74,$P(SDTOE,U,3),0)),U,2)
 E  I $P(SDTOE,U,2),$P(SDTOE,U,3)="" D
 . S X=$P($G(^SCE($P(SDTOE,U,2),0)),U,2)
 E  S X=""
 I X S X=$P($G(^DPT(X,0)),U,9)
 Q
 ;
PATDFN(D0) ; This call will return the patient's DFN.  It is identical to
 ;the PAT call above.  The only difference is that it leaves DFN defined
 ;to the patient's DFN.
 ;
 N SDTOE
 S SDTOE=$G(^SD(409.73,D0,0))
 I $P(SDTOE,U,2)="",$P(SDTOE,U,3) D
 . S DFN=$P($G(^SD(409.74,$P(SDTOE,U,3),0)),U,2)
 E  I $P(SDTOE,U,2),$P(SDTOE,U,3)="" D
 . S DFN=$P($G(^SCE($P(SDTOE,U,2),0)),U,2)
 E  S DFN=""
 Q
 ;
ECDT(D0) ;-- This function is used for the computed field 20.02 in file
 ;   Transmission OutPatient Encounter file 409.73. For the given
 ;   entry in 409.73 a determination of the ENCOUNTER D/T involved with
 ;   the transaction will be determined.
 ;
 N SDTOE
 S SDTOE=$G(^SD(409.73,D0,0))
 I $P(SDTOE,U,2)="",$P(SDTOE,U,3) D
 . S X=$P($G(^SD(409.74,$P(SDTOE,U,3),0)),U)
 E  I $P(SDTOE,U,2),$P(SDTOE,U,3)="" D
 . S X=$P($G(^SCE($P(SDTOE,U,2),0)),U)
 E  S X=""
 I X S Y=X D DD^%DT S X=$TR(Y,"@"," ")
 Q
 ;
EDIV(D0,INT) ;-- This function is used for the computed fields 20.05 and 20.06
 ;   in the Transmission OutPatient Encounter file 409.73. For the
 ;   given entry in 409.73 a determination of the ENCOUNTER DIVISION
 ;   involved with the transaction will be determined.
 ;
 ; Optional input: INT='1' to return internal (ifn) value
 ;
 N SDTOE
 S SDTOE=$G(^SD(409.73,D0,0))
 I $P(SDTOE,U,2)="",$P(SDTOE,U,3) D
 . S X=$P($G(^SD(409.74,$P(SDTOE,U,3),1)),U,11)
 E  I $P(SDTOE,U,2),$P(SDTOE,U,3)="" D
 . S X=$P($G(^SCE($P(SDTOE,U,2),0)),U,11)
 E  S X=""
 I '$G(INT),X S X=$P($G(^DG(40.8,+X,0)),U)
 Q
 ;
ECLOC(D0) ;-- This function is used for the computed field 20.03 in file
 ;   Transmission OutPatient Encounter file 409.73. For the given
 ;   entry in 409.73 a determination of the LOCATION involved with
 ;   the transaction will be determined.
 ;
 N SDTOE
 S SDTOE=$G(^SD(409.73,D0,0))
 I $P(SDTOE,U,2)="",$P(SDTOE,U,3) D
 . S X=$P($G(^SD(409.74,$P(SDTOE,U,3),1)),U,4)
 E  I $P(SDTOE,U,2),$P(SDTOE,U,3)="" D
 . S X=$P($G(^SCE($P(SDTOE,U,2),0)),U,4)
 E  S X=""
 I X S X=$P($G(^SC(X,0)),U)
 Q
 ;
XDATE(D0) ;-- This function is used for the computed field 10.01 in file
 ;  Transmitted OutPatinet Encounter Error file 409.75. For the given
 ;  entry the x-mit date to NPCDB will be determined.
 N SDXDT
 S X=""
 S SDXDT=$P($G(^SD(409.73,+$P($G(^SD(409.75,D0,0)),U),1)),U)
 I SDXDT S Y=SDXDT X ^DD("DD") S X=$TR(Y,"@"," ")
 Q
