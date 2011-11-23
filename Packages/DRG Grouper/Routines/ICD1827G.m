ICD1827G ;;BAY/JAT - FY 2007 UPDATE;
 ;;18.0;DRG Grouper;**27**;Oct 13,2000;Build 2
 ;
 D PRO
 D CC
 D DEL
 D KIL
 D DRG
 D ACCEPT
 Q
PRO ; update procedures with new identifier
 N LINE,X,ICDPROC,ENTRY,IDENT,DA,DIE,DR,DUPE
 F LINE=1:1 S X=$T(PROID+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0)) I ENTRY D
 ..; check for any dupe (there are some in MNTVBB)
 ..S DUPE=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",ENTRY)) I DUPE Q
 ..S IDENT=$P($G(^ICD0(ENTRY,0)),U,2)
 ..;check if already done in case being reinstalled
 ..I IDENT[$P(ICDPROC,U,2) Q
 ..S IDENT=IDENT_$P(ICDPROC,U,2)
 ..I $P(ICDPROC,U)="51.21" S IDENT="O"
 ..I $P(ICDPROC,U)="51.24" S IDENT="O"
 ..S DA=ENTRY,DIE="^ICD0("
 ..S DR="2///^S X=IDENT"
 ..D ^DIE
 Q
PROID ;
 ;;53.61^z
 ;;78.60^z
 ;;78.61^z
 ;;78.63^z
 ;;78.64^z
 ;;78.65^z
 ;;78.68^z
 ;;39.52^7
 ;;51.21^999999
 ;;51.24^999999
 ;;EXIT
CC ; update complications/comorbidities field in diag file
 N LINE,X,ICDDIAG,ENTRY,IDENT,DA,DIE,DR,DUPE
 F LINE=1:1 S X=$T(CCID+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",0)) I ENTRY D
 ..; check for any dupe (there are some in MNTVBB)
 ..S DUPE=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",ENTRY)) I DUPE Q
 ..S IDENT=1
 ..S DA=ENTRY,DIE="^ICD9("
 ..S DR="70///^S X=IDENT"
 ..D ^DIE
 Q
CCID ;
 ;;707.00^
 ;;707.01^
 ;;707.02^
 ;;707.04^
 ;;707.05^
 ;;707.06^
 ;;707.09^
 ;;EXIT
DEL ; delete DRG 496 in procedure file
 N LINE,X,ICDPROC,ENTRY,ICIENS,FDA
 F LINE=1:1 S X=$T(REV+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0))
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD0(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",ENTRY)) I 'ENTRY Q
 ..; check if already done in case patch being re-installed
 ..Q:'$D(^ICD0(ENTRY,2,1,1,2,1,"B",496,1))
 ..S ICIENS=1,ICIENS(1)=2,ICIENS(2)=1,ICIENS(3)=ENTRY
 ..S ICIENS=$$IENS^DILF(.ICIENS)
 ..S FDA(80.17111,ICIENS,.01)="@"
 ..D FILE^DIE("","FDA") K FDA
 ; delete DRG 223 in procedure file
 S ENTRY=+$O(^ICD0("BA",78.13_" ",0))
 I ENTRY D
 .;check for possible inactive dupe
 .I $P($G(^ICD0(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD0("BA",78.13_" ",ENTRY)) I 'ENTRY Q
 .; check if already done in case patch being re-installed
 .Q:'$D(^ICD0(ENTRY,2,1,1,1,1,"B",223,1))
 .S ICIENS=1,ICIENS(1)=1,ICIENS(2)=1,ICIENS(3)=ENTRY
 .S ICIENS=$$IENS^DILF(.ICIENS)
 .S FDA(80.17111,ICIENS,.01)="@"
 .D FILE^DIE("","FDA") K FDA
 Q
REV ;
 ;;81.02^
 ;;81.03^
 ;;81.32^
 ;;81.33^
 ;;EXIT
KIL ; delete DRG 315 in diagnosis file
 N LINE,X,ICDDIAG,ENTRY,ICIENS,FDA
 F LINE=1:1 S X=$T(LIS+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",0))
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD9(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",ENTRY)) I 'ENTRY Q
 ..; check if already done in case patch being re-installed
 ..Q:'$D(^ICD9(ENTRY,3,1,1,"B",315,1))
 ..S ICIENS=1,ICIENS(1)=1,ICIENS(2)=ENTRY
 ..S ICIENS=$$IENS^DILF(.ICIENS)
 ..S FDA(80.711,ICIENS,.01)="@"
 ..D FILE^DIE("","FDA") K FDA
 Q
LIS ;
 ;;585.1^
 ;;585.2^
 ;;585.3^
 ;;585.4^
 ;;585.5^
 ;;585.6^
 ;;585.9^
 ;;EXIT
DRG ; update DRG in diag file
 N ENTRY,ICIENS,FDA
 S ENTRY=+$O(^ICD9("BA","724.8 ",0))
 I ENTRY D
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD9(ENTRY,3,1,1,"B",243,1))
 .S ICIENS=1,ICIENS(1)=1,ICIENS(2)=ENTRY
 .S ICIENS=$$IENS^DILF(.ICIENS)
 .S FDA(80.711,ICIENS,.01)=243
 .D FILE^DIE("","FDA") K FDA
 S ENTRY=+$O(^ICD9("BA","053.19 ",0))
 I ENTRY D
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD9(ENTRY,3,1,1,"B",18,1))
 .S ICIENS=1,ICIENS(1)=1,ICIENS(2)=ENTRY
 .S ICIENS=$$IENS^DILF(.ICIENS)
 .S FDA(80.711,ICIENS,.01)=18
 .D FILE^DIE("","FDA") K FDA
 Q
ACCEPT ; remove unacceptable as prime dx flag
 N LINE,X,ICDDIAG,ENTRY,IDENT,DUPE,FDA
 F LINE=1:1 S X=$T(ACPT+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",0)) I ENTRY D
 ..; check for any dupe (there are some in MNTVBB)
 ..S DUPE=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",ENTRY)) I DUPE Q
 ..S IDENT=$P($G(^ICD9(ENTRY,0)),U,4)
 ..S FDA(80,ENTRY_",",101)="@"
 ..D FILE^DIE("","FDA") K FDA
 Q
ACPT ;
 ;;590.81^
 ;;595.4^
 ;;EXIT
