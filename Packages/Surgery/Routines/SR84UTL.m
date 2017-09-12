SR84UTL ;BIR/ADM-Utility Routine for SR*3*84 ; [ 12/02/98  10:58 AM ]
 ;;3.0; Surgery ;**84**;24 Jun 93
 ;
 ; References to fields 20 and 22 of file 19 are supported by DBIA #2509
 ;
 ; environmental check to confirm that XU*8*87 is installed
 I '$$PATCH^XPDUTL("XU*8.0*87") D BMES^XPDUTL("Patch XU*8*87 must be installed before installing this patch!") S XPDQUIT=2 Q
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) D BMES^XPDUTL(">> DUZ and DUZ(0) must be defined as an active user to install.") S XPDQUIT=2 Q
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) D BMES^XPDUTL("Patch installation requires PROGRAMMER ACCESS.") S XPDQUIT=2
 Q
POST ; update XQUIT EXECUTABLE field in OPTION file for Surgery options
 N DA,DIE,DR,SR19,SRACT,SROPT,SRXQ
 S SR19="SR" F  S SR19=$O(^DIC(19,"B",SR19)) Q:$E(SR19,1,2)'="SR"  S SROPT=0 F  S SROPT=$O(^DIC(19,"B",SR19,SROPT)) Q:'SROPT  D
 .S SRACT=$$GET1^DIQ(19,SROPT,20) I SRACT'["SROVAR" Q
 .D MES^XPDUTL("Updating option "_SR19)
 .K DA,DIE,DR S DA=SROPT,DIE=19,DR="22////Q" D ^DIE
 .S SRXQ=$$GET1^DIQ(19,SROPT,22) I SRXQ'="Q" D MES^XPDUTL("  >>> "_SR19_" update FAILED.")
 Q
