VAQAUT ;ALB/JRP - USER AUTHENTIFICATION ROUTINES;23-FEB-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
VRFYUSER(DUZ) ;USER VERIFICATION USING ELECTRONIC SIGNATURE
 ;INPUT  : DUZ - User's IFN in the NEW PERSON file
 ;OUTPUT : 0 - Successful verification
 ;        -1 - User not verified
 ;        -2 - Bad input
 ;        -3 - User does not have an electronic signature on file
 ;
 ;CHECK INPUT
 S DUZ=$G(DUZ)
 Q:(DUZ="") -2
 Q:('$D(^VA(200,DUZ))) -2
 ;DECLARE VARIABLES
 N X,X1
 ;VERIFY USER (KERNEL API)
 D SIG^XUSESIG
 ;NO SIGNATURE ON FILE
 Q:('$D(X)) -3
 ;NOT VERIFIED
 Q:(X1="") -1
 ;VERIFIED
 Q 0
