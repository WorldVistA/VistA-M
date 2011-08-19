ICD1832T   ; ALB/JAT - FY 2008 UPDATE; 7/27/05 14:50;
 ;;18.0;DRG Grouper;**32**;Oct 13,2000;Build 9
 Q
 ;
DIAG ;
 D BMES^XPDUTL(">>>DRG Reclassification changes")
 D MES^XPDUTL(">>>Modifying diagnosis codes - file 80")
 D MES^XPDUTL(">>>for new DRGs")
 N LINE,X,ICDDIAG,ENTRY,FDA
 F LINE=1:1 S X=$T(REVD+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",0))
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD9(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",ENTRY)) I 'ENTRY Q 
 ..;check if already created in case patch being re-installed
 ..I $D(^ICD9(ENTRY,3,"B",3071001)) D
 ...S DA(1)=ENTRY,DA=$O(^ICD9(ENTRY,3,"B",3071001,0))
 ...S DIK="^ICD9("_DA(1)_",3," D ^DIK
 ..; add 80.071 and 80.711 records
 ..S FDA(1820,80,"?1,",.01)="`"_ENTRY
 ..S FDA(1820,80.071,"+2,?1,",.01)=3071001
 ..D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ..S FDA(1820,80,"?1,",.01)="`"_ENTRY
 ..S FDA(1820,80.071,"?2,?1,",.01)=3071001
 ..S FDA(1820,80.711,"+3,?2,?1,",.01)=$P(ICDDIAG,U,2)
 ..I $P(ICDDIAG,U,3) S FDA(1820,80.711,"+4,?2,?1,",.01)=$P(ICDDIAG,U,3)
 ..I $P(ICDDIAG,U,4) S FDA(1820,80.711,"+5,?2,?1,",.01)=$P(ICDDIAG,U,4)
 ..I $P(ICDDIAG,U,5) S FDA(1820,80.711,"+6,?2,?1,",.01)=$P(ICDDIAG,U,5)
 ..I $P(ICDDIAG,U,6) S FDA(1820,80.711,"+7,?2,?1,",.01)=$P(ICDDIAG,U,6)
 ..I $P(ICDDIAG,U,7) S FDA(1820,80.711,"+8,?2,?1,",.01)=$P(ICDDIAG,U,7)
 ..D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 Q
REVD ; DIAG^DRG...
 ;;338.21^91^92^93
 ;;338.22^91^92^93
 ;;338.28^91^92^93
 ;;338.29^91^92^93
 ;;338.4^91^92^93
 ;;403.00^682^683^684
 ;;403.10^682^683^684
 ;;403.90^682^683^684
 ;;EXIT
