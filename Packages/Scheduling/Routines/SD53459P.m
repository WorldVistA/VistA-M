SD53459P ;ALB/MRY - Pre/Post-Install; 9/29/05
 ;;5.3;Scheduling;**459**;Aug 13, 1993
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 ;
 ;Do AmbCare pre-install (copied from SD53142)
 ;Remove ERROR CODE DESCRIPTION (field #11) as an identifier of the
 ; TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file (#409.76)
 ; (this causes problems when installing error codes)
 I ($D(^DD(409.76,0,"ID",11))) D
 .N TMP,X
 .S X(1)=" "
 .S X(2)="Removing ERROR CODE DESCRIPTION (field #11) as an identifier"
 .S X(3)="of the TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file"
 .S X(4)="(#409.76) as it causes problems when installing error codes."
 .S X(5)=" "
 .D MES^XPDUTL(.X) K X
 .K ^DD(409.76,0,"ID",11)
 .Q:($D(^DD(409.76,0,"ID")))
 .S TMP=$P(^SD(409.76,0),U,2)
 .S TMP=$TR(TMP,"I","")
 .S $P(^SD(409.76,0),U,2)=TMP
 .Q
 Q
 ;
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 ;Make ERROR CODE DESCRIPTION (field #11) an identifier of the
 ; TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file (#409.76)
 ; (this was removed by the pre init routine)
 I ('$D(^DD(409.76,0,"ID",11))) D
 .N TMP
 .S ^DD(409.76,0,"ID",11)="D EN^DDIOL($P(^(1),U,1))"
 .S TMP=$P(^SD(409.76,0),U,2)
 .S TMP=$TR(TMP,"I","")
 .S $P(^SD(409.76,0),U,2)=TMP_"I"
 ;
 ;Re-queue Ambcare records
 D POST^SD53459A
 Q
