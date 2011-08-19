SRHLPRE ;B'HAM ISC/DLR - PRE-INIT FOR HL7 SURGERY INTERFACE ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 D MAILGRP
SETUP ;sets up needed HL7 files for the Surgery Interface install
 N SRN,SRV
 S X="ZIU",SRN="Schedule Information Unsolicited",SRV="2.1" D 7712
 S X="ZSQ",SRN="Schedule Query Response",SRV="2.1" D 7712
 S X="MFN",SRN="Master File Notification",SRV="2.1" D 7712
 S X="S12",SRN="Notification of New Appointment Booking",SRV="2.1" D 779001
 S X="S13",SRN="Notification of Appointment Rescheduling",SRV="2.1" D 779001
 S X="S14",SRN="Notification of Appointment Modification",SRV="2.1" D 779001
 S X="S15",SRN="Notification of Appointment Cancellation",SRV="2.1" D 779001
 S X="S17",SRN="Notification of Appointment Deletion",SRV="2.1" D 779001
 S X="S25",SRN="Query - Schedule Information",SRV="2.1"  D 779001
 S X="M01",SRN="Master File Not Otherwise Specified",SRV="2.1" D 779001
 S X="M02",SRN="Staff/Practitioneer Master File",SRV="2.1" D 779001
CLEAN K DA,DD,DIC,DIE,DO,DR
 Q
MAILGRP ; mail group creation
 N SRDESC,SRXMY,A,X S X="SRHL DISCREPANCY",DIC=3.8,DIC(0)="" D ^DIC K DIC I Y'=-1 Q
 S SRDESC(1)="This mail group is used by the Surgery Interface ORU receiver routine to"
 S SRDESC(2)="report message discrepancies.  The discrepancies will include invalid file"
 S SRDESC(3)="values for certain files, as well as invalid text identifiers from the"
 S SRDESC(4)="SURGERY INTERFACE PARAMETER file (#133.2).",SRXMY(DUZ)=""
 S X=$$MG^XMBGRP("SRHL DISCREPANCY",0,+DUZ,0,.SRXMY,.SRDESC,1) I X D BMES^XPDUTL("Mail Group SRHL DISCREPANCY installed")
 Q
7712 ;check for existence and add/update HL7 Message file
 D CLEAN S DIC(0)="L",DLAYGO=771.2,DIC="^HL(771.2," D ^DIC I Y=-1 D FILE^DICN S DA=+Y,DIE=DIC,DR="2///"_SRN_";3///"_SRV,DR(2,771.23)=".01///"_SRV D ^DIE
 Q
779001 ;update HL7 EVENT TYPE file (#779.001)
 D CLEAN S DIC(0)="L",DLAYGO=779.001,DIC="^HL(779.001," D ^DIC I Y=-1 D FILE^DICN S DA=+Y,DIE=DIC,DR="2///"_SRN_";100///"_SRV,DR(2,779.0101)=".01///"_SRV D ^DIE
 Q
