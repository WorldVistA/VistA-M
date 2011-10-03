MHV1P0 ;WAS/GPM - My HealtheVet Install Utility Routine ; [8/23/05 2:31pm]
 ;;1.0;My HealtheVet;;Aug 23, 2005
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;         3779 : Direct read of "B" x-ref of file 4.2 (DOMAIN)
 ;        10141 : BMES^XPDUTL, XPDQUIT
 ;
ENV ;
 N EVAULT
 ; Check for the proper domain entry before proceeding
 S EVAULT=$$FIND1^DIC(4.2,,"QX","VAMHVWEB1.AAC.VA.GOV","B")
 I EVAULT<1 D BMES^XPDUTL("       *** Patch: XM*DBA*159 is required for this package ***") S XPDQUIT=1 Q
 Q
 ;
POST ;
 N ADM
 D SETADM^MHVU1(.ADM)
 I ADM("SYSTEM TYPE")'="P" Q
 D NOTIFY^MHVU1(.ADM)
 D BMES^XPDUTL("       *** Installation message sent to My HealtheVet Server")
 Q
 ;
