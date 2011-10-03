SCMSP0 ;ALB/JRP - CHECK POINTS TO CREATE ENTRIES IN HL7 FILES;29-MAY-1996
 ;;5.3;Scheduling;**44**;AUG 13, 1993
 ;
HL7EVNT ;Create HL7 event Z00 - HL7 EVENT TYPE CODE file (#779.001)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N DIC,X,Y,DLAYGO,DTOUT,DUOUT,NEWENTRY,MSGTXT,PTREVNT,DIE,DA,DR
 ;Create/find entry
 D BMES^XPDUTL(">>> Creating entry for Z00 in HL7 EVENT TYPE CODE file (#779.001)")
 S DIC="^HL(779.001,"
 S DIC(0)="L"
 S DIC("DR")="2///Ambulatory Care transmission to/from NPCDB"
 S DLAYGO=779.001
 S X="Z00"
 D ^DIC
 S PTREVNT=+Y
 S NEWENTRY=+$P(Y,"^",3)
 S MSGTXT(1)="    Existing entry found - support of HL7 v2.2 will be added/verified"
 S:(NEWENTRY) MSGTXT(1)="    Entry created - support of HL7 v2.2 will be added"
 I (PTREVNT<0) D
 .S MSGTXT(1)="    ** Unable to create entry for Z00"
 .S MSGTXT(2)="    ** Entry must be created manually"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 ;Don't continue if entry wasn't created
 Q:(PTREVNT<0)
 ;Add support for HL7 version 2.2
 S DIC="^HL(779.001,"_PTREVNT_",1,"
 S DIC(0)="LX"
 S DIC("P")=$P(^DD(779.001,100,0),"^",2)
 S DA(1)=PTREVNT
 S DLAYGO=779.001
 S X="2.2"
 D ^DIC
 S MSGTXT(1)="    Support for HL7 v2.2 "_$S($P(Y,"^",3):"added",1:"verified")
 I (Y<0) D
 .S MSGTXT(1)="    ** Unable to add support for HL7 v2.2"
 .S MSGTXT(2)="    ** Support for HL7 v2.2 must be added manually"
 D MES^XPDUTL(.MSGTXT)
 ;Done
 Q
 ;
HL7APPS ;Create required entries in HL APPLICATION file (#771)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N APPNAME,FACNUM,MAILGRP,MSGTXT,PTRAPP
 D BMES^XPDUTL(">>> Creating entries in HL APPLICATION file (#771)")
 ;Create sending application
 S APPNAME="AMBCARE-DHCP"
 S FACNUM=+$P($$SITE^VASITE(),"^",3)
 S MAILGRP=$$OPCMG^SCMSPU1(0)
 I ('MAILGRP) D  Q
 .S MSGTXT(1)="    ** MAS PARAMETER file (#43) does not have a value for"
 .S MSGTXT(2)="       the OPC GENERATE MAIL GROUP field (#216)"
 .S MSGTXT(3)="    ** Entries for AMBCARE-DHCP and NPCD-AAC in the HL"
 .S MSGTXT(4)="       APPLICATION file (#771) can not be created"
 .S MSGTXT(5)="    ** Entries must be manually entered"
 .D MES^XPDUTL(.MSGTXT)
 D MES^XPDUTL("     Creating entry for sending application (AMBCARE-DHCP)")
 S PTRAPP=$$CRTAPP^SCMSPU1(APPNAME,FACNUM,MAILGRP)
 S MSGTXT(1)="       Entry for AMBCARE-DHCP successfully created"
 I ('$P(PTRAPP,"^",2)) D
 .S MSGTXT(1)="      Existing entry for AMBCARE-DHCP found - current values not overwritten"
 I (PTRAPP<0) D
 .S MSGTXT(1)="       ** Unable to create entry for AMBCARE-DHCP"
 .S MSGTXT(2)="       ** "_$P(PTRAPP,"^",2)
 .S MSGTXT(3)="       ** Sending application must be added manually"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 ;Create receiving application
 S APPNAME="NPCD-AAC"
 S FACNUM=200
 S MAILGRP=$$OPCMG^SCMSPU1(0)
 D MES^XPDUTL("     Creating entry for receiving application (NPCD-AAC)")
 S PTRAPP=$$CRTAPP^SCMSPU1(APPNAME,FACNUM,MAILGRP)
 S MSGTXT(1)="       Entry for NPCD-AAC successfully created"
 I ('$P(PTRAPP,"^",2)) D
 .S MSGTXT(1)="      Existing entry for NPCD-AAC found - current values not overwritten"
 I (PTRAPP<0) D
 .S MSGTXT(1)="       ** Unable to create entry for NPCD-AAC"
 .S MSGTXT(2)="       ** "_$P(PTRAPP,"^",2)
 .S MSGTXT(3)="       ** Receiving application must be added manually"
 D MES^XPDUTL(.MSGTXT)
 ;Done
 Q
 ;
MAILGRP ;Create entry in MAIL GROUP file (#3.8) that will be attached to
 ; the lower level protocol parameter
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 ;Declare variables
 N NAME,DESC,PTR2MG,MSGTXT,DIE,DIC,DA,DR,X,Y,DTOUT
 D BMES^XPDUTL(">>> Creating entry in MAIL GROUP file (#3.8)")
 ;Create entry in MAIL GROUP file
 S NAME="SCDX AMBCARE TO NPCDB"
 S DESC(1)="Mail Group used by the Ambulatory Care Reporting Project to"
 S DESC(2)="transmit data to the National Patient Care Database via HL7"
 S PTR2MG=$$MG^XMBGRP(NAME,0,.5,0,.XMY,.DESC,1)
 S MSGTXT(1)="    Entry for SCDX AMBCARE TO NPCDB successfully created"
 I ('PTR2MG) D
 .S MSGTXT(1)="    ** Unable to create entry for SCDX AMBCARE TO NPCDB"
 .S MSGTXT(2)="    ** Entry must be created manually"
 D MES^XPDUTL(.MSGTXT)
 K MSGTXT
 ;Don't continue if entry wasn't created
 Q:('PTR2MG)
 ;Add queue for National Patient Care Database as REMOTE MEMBER
 D MES^XPDUTL("    Adding National Patient Care Database (NPCDB) to Mail Group")
 S DIC="^XMB(3.8,"_PTR2MG_",6,"
 S DIC(0)="LX"
 S DIC("P")=$P(^DD(3.8,12,0),"^",2)
 S DA(1)=PTR2MG
 S DLAYGO=3.8
 S X="XXX@Q-ACS.MED.VA.GOV"
 D ^DIC
 S MSGTXT(1)="    XXX@Q-ACS.MED.VA.GOV successfully added as REMOTE MEMBER"
 I (Y<0) D
 .S MSGTXT(1)="    ** Unable to add XXX@Q-ACS.MED.VA.GOV as REMOTE MEMBER"
 .S MSGTXT(2)="    ** Remote member must be added manually"
 D MES^XPDUTL(.MSGTXT)
 ;Done
 Q
 ;
HL7LLPP ;Create entry in HL LOWER LEVEL PROTOCOL PARAMETER file (#869.2)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;       : If an entry for AMB-CARE already exists, values currently
 ;         defined for the entry will not be overwritten
 ;
 ;Declare variables
 N DIC,X,Y,DLAYGO,DTOUT,DUOUT,NEWENTRY,PTRLLPP,DIE,DA,DR,MSGTXT
 ;Create entry
 D BMES^XPDUTL(">>> Creating entry in HL LOWER LEVEL PROTOCOL PARAMETER file (#869.2)")
 S DIC="^HLCS(869.2,"
 S DIC(0)="LX"
 S DIC("DR")=".02///MAILMAN;100.01///SCDX AMBCARE TO NPCDB"
 S DLAYGO=869.2
 S X="AMB-CARE"
 D ^DIC
 S PTRLLPP=+Y
 S NEWENTRY=+$P(Y,"^",3)
 S MSGTXT(1)="    Entry for AMB-CARE created"
 I ((PTRLLPP)&('NEWENTRY)) D
 .S MSGTXT(1)="    Entry for AMB-CARE found"
 .S MSGTXT(2)="    Existing information will not be overwritten"
 I (PTRLLPP<0) D
 .S MSGTXT(1)="    ** Unable to create entry for AMB-CARE"
 .S MSGTXT(2)="    ** Entry must be created manually"
 D MES^XPDUTL(.MSGTXT)
 ;Done
 Q
 ;
HL7LINK ;Create entry in HL LOGICAL LINK file (#870)
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;       : If an entry for AMB-CARE already exists, values currently
 ;         defined for the entry will not be overwritten
 ;
 ;Declare variables
 N DIC,X,Y,DLAYGO,DTOUT,DUOUT,NEWENTRY,PTRLINK,DIE,DA,DR,MSGTXT
 ;Create entry
 D BMES^XPDUTL(">>> Creating entry in HL LOGICAL LINK file (#870)")
 S DIC="^HLCS(870,"
 S DIC(0)="LX"
 S DIC("DR")="2///AMB-CARE"
 S DLAYGO=870
 S X="AMB-CARE"
 D ^DIC
 S PTRLINK=+Y
 S NEWENTRY=+$P(Y,"^",3)
 S MSGTXT(1)="    Entry for AMB-CARE created"
 I ((PTRLINK)&('NEWENTRY)) D
 .S MSGTXT(1)="    Entry for AMB-CARE found"
 .S MSGTXT(2)="    Existing information will not be overwritten"
 I (PTRLINK<0) D
 .S MSGTXT(1)="    ** Unable to create entry for AMB-CARE"
 .S MSGTXT(2)="    ** Entry must be created manually"
 D MES^XPDUTL(.MSGTXT)
 ;Done
 Q
