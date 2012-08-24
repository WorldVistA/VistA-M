SRHLENV ;B'HAM ISC/DLR - KIDS ENVIRONMENT CHECKER FOR HL7 SURGERY INTERFACE ; [ 06/10/98  2:55 PM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 N SITE,MSG
 W @IOF
 W !!,"Checking the SURGERY HL7 Environment",!
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0)  W !!,$C(7),">> DUZ and DUZ(0) must be defined as an active user to initialize." S XPDQUIT=2 Q
 S SITE=$$SITE^SROVAR I $G(SITE)="" S MSG="Warning:   *** There is no default Institution. ***" D MES^XPDUTL(.MSG) G ABRT
 ;check for the existence of HL7 V. 1.6
 I $$VERSION^XPDUTL("HL")'=1.6 S MSG="HL7 V. 1.6 must be installed prior to installing this package." D MES^XPDUTL(.MSG) G ABRT
 W !!,"Environment check was successful!!"
 Q
ABRT ;
 W !!,"Environment checker was aborted!!"
 S XPDQUIT=1
 Q
