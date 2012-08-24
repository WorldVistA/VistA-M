ICD1824O ;;ALB/EG/JAT - FY 2007 UPDATE; 6/19/05 4:08pm ; 6/24/05 3:29pm
 ;;18.0;DRG Grouper;**24**;Oct 13,2000;Build 5
 ;
 Q
 ;
PRO ;
 D BMES^XPDUTL(">>>Modifying procedure codes - file 80.1")
 D MES^XPDUTL(">>>for new DRGs")
 N LINE,X,ICDPROC,ENTRY,SUBLINE,DATA,FDA
 F LINE=1:1 S X=$T(REV+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .Q:ICDPROC["+"
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0))
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD0(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",ENTRY)) I 'ENTRY Q
 ..; check if already created in case patch being re-installed
 ..Q:$D(^ICD0(ENTRY,2,"B",3061001))
 ..;add 80.171, 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S X=$T(REV+LINE+SUBLINE) S DATA=$P(X,";;",2) Q:DATA'["+"  D
 ...I SUBLINE=1 D
 ....S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ....S FDA(1820,80.171,"+2,?1,",.01)=3061001
 ....D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S DATA=$E(DATA,2,99)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3061001
 ...S FDA(1820,80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3061001
 ...S FDA(1820,80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S FDA(1820,80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...I $P(DATA,U,3) S FDA(1820,80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...I $P(DATA,U,4) S FDA(1820,80.17111,"+6,?3,?2,?1,",.01)=$P(DATA,U,4)
 ...I $P(DATA,U,5) S FDA(1820,80.17111,"+7,?3,?2,?1,",.01)=$P(DATA,U,5)
 ...I $P(DATA,U,6) S FDA(1820,80.17111,"+8,?3,?2,?1,",.01)=$P(DATA,U,6)
 ...I $P(DATA,U,7) S FDA(1820,80.17111,"+9,?3,?2,?1,",.01)=$P(DATA,U,7)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 Q
ID ;
 ; modify Identifier field (#2) in file 80.1 - add an "M" - this should have been 
 ; done when these new codes were added in FY2006 so they can go to DRG 471 
 ; although beginning with FY2007, only 00.70 and 00.80 can still go to DRG 471.
 ; Note also that DRG 471 doesn't work for bilateral (e.g. both hips) - HIM Staff know this
 ; as this is a limitation of the VistA Grouper who can't handle duplicate codes
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,IDENT,DIC
 F LINE=1:1 S X=$T(REVID+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0)) I ENTRY D
 ..S DA=ENTRY,DIE="^ICD0("
 ..S IDENT=$P(ICDPROC,U,2)
 ..S DR="2///^S X=IDENT"
 ..D ^DIE
 Q
 ; 
REV ;
 ;;96.70^
 ;;+4^566
 ;;96.71^
 ;;+4^566
 ;;96.72^
 ;;+4^565
 ;;57.6^
 ;;+11^573
 ;;57.71^
 ;;+11^573
 ;;57.79^
 ;;+11^573
 ;;57.83^
 ;;+11^573
 ;;57.84^
 ;;+11^573
 ;;57.85^
 ;;+11^573
 ;;57.86^
 ;;+11^573
 ;;57.87^
 ;;+11^573
 ;;57.88^
 ;;+11^573
 ;;57.89^
 ;;+11^573
 ;;00.71^
 ;;+8^545
 ;;00.72^
 ;;+8^545
 ;;00.73^
 ;;+8^545
 ;;00.81^
 ;;+8^545
 ;;00.82^
 ;;+8^545
 ;;00.83^
 ;;+8^545
 ;;00.84^
 ;;+8^545
 ;;81.53^
 ;;+8^545
 ;;81.55^
 ;;+8^545
 ;;EXIT
 ;;
REVID ; these codes were new in FY2006 and should have had an "M" added then 
 ;;00.70^OM
 ;;00.71^OM
 ;;00.72^OM
 ;;00.73^OM
 ;;00.80^OM
 ;;00.81^OM
 ;;00.82^OM
 ;;00.83^OM
 ;;00.84^OM
 ;;EXIT
