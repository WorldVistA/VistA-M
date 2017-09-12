SR182UTL ;BIR/SJA - SR*3*182 UTILITY ROUTINE ;11/21/2013
 ;;3.0;Surgery;**182**;24 Jun 93;Build 49
 Q
PRE ; pre-install process for SR*3*182
 ; delete data from file #136.5 and re-initialize file
 K ^SRO(136.5) S ^SRO(136.5,0)="PERIOPERATIVE OCCURRENCE CATEGORY^136.5I^^"
 ; delete DD for modified field #.69
 F DA=.69,74 S DIK="^DD(130,",DA(1)=130 D ^DIK K DA,DIK
 Q
POST ; post-install process for SR*3*182
 N SRI,SRTXT,SRIEN,SRZ,SREF,SRX,SRY,X
 D MES^XPDUTL("  Starting post-install of SR*3.0*182")
 ;
 ; inactivate existing cancellation reasons and add new ones
 S SRZ=0 F  S SRZ=$O(^SRO(135,SRZ)) Q:'SRZ!(SRZ>1009)  S DIE=135,DA=SRZ,DR="10////1" D ^DIE K DA,DIE,DR
 ; kill then rebuild "B","C" x-ref:
 K ^SRO(135,"B"),^SRO(135,"C")
 F SRI=1:1 S SRX=$P($T(TXTCAN+SRI),";;",2) Q:SRX="EOM"  S SRTXT=$P(SRX,"^",2) D
 .S SRIEN=1009+SRI I '$D(^SRO(135,SRIEN,0)) S ^SRO(135,SRIEN,0)=SRTXT_"^"_SRI
 F SREF=".01^B","1^C" S DIK="^SRO(135,",DIK(1)=SREF D ENALL^DIK
 D MES^XPDUTL("The Surgery Cancellation Reason file (#135) has been updated")
 ;
 I '$$PATCH^XPDUTL("SR*3.0*182") D ADDIS
 ;
 ; CPT EXCLUSIONS file #137
 D MES^XPDUTL("  Populating CPT EXCLUSIONS file...")
 K ^SRO(137)
 S ^SRO(137,0)="CPT EXCLUSIONS^137P^^"
 D PEX^SR182UT0,PEX^SR182UT1,PEX^SR182UT2,PEX^SR182UT3
 ;
DEL ; delete routines SR182UT0, SR182UT1, SR182UT2, and SR182UT3
 F X="SR182UT0","SR182UT1","SR182UT2","SR182UT3" X ^%ZOSF("TEST") I $T D
 .D MES^XPDUTL(" Deleting routine "_X_"...")
 .X ^%ZOSF("DEL")
 K DA,DIC,DD,DO,DINUM,X
 Q
INT S SRY=0,SRY=$O(^ICPT("B",SRX,SRY)) Q:SRY=""
 K DA,DIC,DD,DO,DINUM S (DINUM,X)=SRY,DIC="^SRO(137,",DIC(0)="L" D FILE^DICN
 Q
ADDIS ; inactivate existing SURGERY DISPOSITION file (#131.6) entries and add new ones
 S SRZ=0 F  S SRZ=$O(^SRO(131.6,SRZ)) Q:'SRZ  S DIE=131.6,DA=SRZ,DR="2////1" D ^DIE K DA,DIE,DR
 ; kill and then rebuild "B","C","D" x-ref:
 K ^SRO(131.6,"B"),^SRO(131.6,"C"),^SRO(131.6,"D")
 S SRMAX=$O(^SRO(131.6," "),-1) F SRI=1:1 S SRX=$P($T(TXTDIS+SRI),";;",2) Q:SRX="EOM"  D
 .S SRIEN=SRMAX+SRI I '$D(^SRO(131.6,SRIEN,0)) S ^SRO(131.6,SRIEN,0)=$P(SRX,"^",2)_"^"_$P(SRX,"^")
 F SREF=".01^B","1^C" S DIK="^SRO(131.6,",DIK(1)=SREF D ENALL^DIK
 K DIK S ^DD(131.6,.01,7.5)="I $G(DIC(0))[""L"",'$D(XUMF) K X D EN^DDIOL(""File is locked. No new entries or edits are allowed."","""",""!?5,$C(7)"")"
 D MES^XPDUTL("The Surgery Disposition file (#131.6) has been updated")
 Q
TXTCAN ; new surgery cancellation reasons
 ;;1^PATIENT RELATED ISSUE
 ;;2^ENVIRONMENTAL ISSUE
 ;;3^STAFF ISSUE
 ;;4^PATIENT HEALTH STATUS
 ;;5^CLIN URGENT/EMERGENT CASE
 ;;6^SCHED ISSUES NON EMERGENT CASE
 ;;7^UNAVAILABLE BED
 ;;8^UNAVAILABLE EQUIP EXCLUDE RME
 ;;9^UNAVAILABLE REUSABLE EQUP-RME
 ;;10^CASE MOVED TO EARLIER DATE
 ;;EOM
TXTDIS ; new surgery disposition entries
 ;;O^OUTPATIENT/DISCHARGE
 ;;I^ICU
 ;;S^STEPDOWN
 ;;W^WARD
 ;;OBS^OBSERVATION UNIT
 ;;M^MORGUE
 ;;EOM
