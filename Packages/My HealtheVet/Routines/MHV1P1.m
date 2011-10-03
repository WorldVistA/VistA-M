MHV1P1 ;WAS/GPM - My HealtheVet Install Utility Routine ; [3/28/06 4:55pm]
 ;;1.0;My HealtheVet;**1**;Aug 23, 2005
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;
ENV ;
 Q
 ;
POST ;
 D CLEANLOG
 D NOTIFY
 Q
 ;
CLEANLOG ; Cleanup log entries
 D BMES^XPDUTL("  *** Cleaning up MHV application log. ***")
 K ^TMP("MHV7LOG")
 Q
 ;
NOTIFY ; Send notification message
 N ADM
 D SETADM^MHVU1(.ADM)
 I ADM("SYSTEM TYPE")'="P" Q
 D NOTIFY^MHVU1(.ADM)
 D BMES^XPDUTL("  *** Installation message sent to My HealtheVet Server ***")
 Q
 ;
