ICD1830G ;;BAY/JAT - FY 2007 UPDATE;
 ;;18.0;DRG Grouper;**30**;Oct 13,2000;Build 5
 ;
 D CC
 Q
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
 ;;799.02^
 ;;EXIT
