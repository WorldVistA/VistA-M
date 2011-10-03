ICD1817P ;;ALB/EG/JAT - CORRECT PROC CODES ; 6/27/05 1:03pm
 ;;18.0;DRG Grouper;**17**;Oct 13,2000
 ;
 D CHGPROC
 D CHGDIAG
 Q
 ;
CHGPROC ;
 D BMES^XPDUTL(">>>Modifying records in file 80.1")
 ; modify Identifier field (#2) in file 80.1
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,IDENT,DIC
 S LINE=1
 F  S X=$T(REVP+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0)) I ENTRY D
 ..S DA=ENTRY,DIE="^ICD0("
 ..S IDENT=$P(ICDPROC,U,2)
 ..S DR="2///^S X=IDENT"
 ..D ^DIE
 ..S LINE=LINE+1
 ; kill 80.171 sub-file record and descendants for proc 80.51
 N DA,DIK
 S DA(1)=3867
 S DA=2
 S DIK="^ICD0("_DA(1)_",""2"","
 D ^DIK
 ; add Oct 1,2004 record to 80.171, MDC 1 to 80.1711, and 543
 ; to 80.17111 for proc 01.14 ONLY 
 S ENTRY=2963
 ; check if already created in case patch being re-installed
 I $D(^ICD0(ENTRY,2,2)) G SKIP
 S DA(1)=ENTRY
 S DIC="^ICD0("_DA(1)_",2,"
 S DIC(0)="L"
 S X=3041001 K DO D FILE^DICN K DIC,DA
 S DA(2)=ENTRY
 S DA(1)=2
 S DIC="^ICD0("_DA(2)_",2,"_DA(1)_",1,"
 S DIC(0)="L"
 S X=1 K DO D FILE^DICN K DIC,DA
 S DA(3)=ENTRY
 S DA(2)=2
 S DA(1)=1
 S DIC="^ICD0("_DA(3)_",2,"_DA(2)_",1,"_DA(1)_",1,"
 S DIC(0)="L"
 S X=543 K DO D FILE^DICN K DIC,DA
 ; add 80.17111 sub-file records to 80.1711 and 80.171 
SKIP ;
 S LINE=1
 N Z
 F  S Z=$T(REVPRO+LINE) S ICDPROC=$P(Z,";;",2) Q:ICDPROC="EXIT"  D
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0)) I ENTRY D
 ..S DA(3)=ENTRY,DA(2)=2,DA(1)=1
 ..S DIC="^ICD0("_DA(3)_",2,"_DA(2)_",1,"_DA(1)_",1,"
 ..S DIC(0)="L"
 ..; check if already created in case patch being re-installed
 ..I $D(^ICD0(ENTRY,2,2,1,1,1,2,0)) S LINE=LINE+1 Q
 ..; add DRG 1,2 and 3 
 ..S X=1
 ..K DO
 ..D FILE^DICN
 ..S X=2
 ..D FILE^DICN
 ..S X=3
 ..D FILE^DICN
 ..S LINE=LINE+1
 Q
 ;
REVP ;
 ;;36.12^Ob6
 ;;36.13^Ob6
 ;;36.14^Ob6
 ;;51.23^TT
 ;;81.61^O
 ;;01.14^OQ
 ;;02.13^OQK
 ;;38.01^OQK
 ;;38.11^OQK
 ;;38.31^OQK
 ;;38.41^OQK
 ;;38.51^OQK
 ;;38.61^OQK
 ;;38.81^OQK
 ;;39.28^OQK
 ;;39.51^OQK
 ;;39.52^OQK
 ;;39.53^OQK
 ;;39.72^OQK
 ;;39.79^OQK
 ;;EXIT
 Q
REVPRO ;
 ;;01.59^
 ;;01.12^
 ;;01.14^
 ;;01.15^
 ;;01.18^
 ;;01.19^
 ;;01.21^
 ;;01.22^
 ;;01.23^
 ;;01.24^
 ;;01.25^
 ;;01.31^
 ;;01.32^
 ;;01.39^
 ;;01.41^
 ;;01.42^
 ;;01.51^
 ;;01.52^
 ;;01.53^
 ;;01.6^
 ;;02.01^
 ;;02.02^
 ;;02.03^
 ;;02.04^
 ;;02.05^
 ;;02.06^
 ;;02.07^
 ;;02.11^
 ;;02.12^
 ;;02.13^
 ;;02.14^
 ;;02.2^
 ;;02.91^
 ;;02.92^
 ;;02.93^
 ;;02.94^
 ;;02.99^
 ;;04.01^
 ;;04.41^
 ;;07.13^
 ;;07.14^
 ;;07.15^
 ;;07.17^
 ;;07.51^
 ;;07.52^
 ;;07.53^
 ;;07.54^
 ;;07.59^
 ;;07.61^
 ;;07.62^
 ;;07.63^
 ;;07.64^
 ;;07.65^
 ;;07.68^
 ;;07.69^
 ;;07.71^
 ;;07.72^
 ;;07.79^
 ;;29.92^
 ;;38.01^
 ;;38.11^
 ;;38.31^
 ;;38.41^
 ;;38.51^
 ;;38.61^
 ;;38.81^
 ;;39.28^
 ;;39.51^
 ;;39.52^
 ;;39.53^
 ;;39.72^
 ;;39.79^
 ;;EXIT
 Q
 ;
CHGDIAG ;
 D BMES^XPDUTL(">>>Modifying records in file 80")
 ; modify Identifier field (#2) in file 80
 N LINE,X,ICDDIAG,ENTRY,DA,DIE,DR,IDENT
 S LINE=1
 F  S X=$T(REVD+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",0)) I ENTRY D
 ..S DA=ENTRY,DIE="^ICD9("
 ..S IDENT=$P(ICDDIAG,U,2)
 ..S DR="2///^S X=IDENT"
 ..D ^DIE
 ..S LINE=LINE+1
 ; change MDC
 S DA=8725,DIE="^ICD9(",IDENT=5
 S DR="5///^S X=IDENT"
 D ^DIE
 ; add 80.071, 80.711 and 80.072 records for diag 428.0
 I $D(^ICD9(9061,3)) G DELETE
 N FDA
 S FDA(428,80,"?1,",.01)="`9061"
 S FDA(428,80.071,"+2,?1,",.01)=3031001
 S FDA(428,80.072,"+3,?1,",.01)=3031001
 S FDA(428,80.072,"+3,?1,",1)=5
 D UPDATE^DIE("","FDA(428)") K FDA(428)
 S FDA(428,80,"?1,",.01)="`9061"
 S FDA(428,80.071,"?2,?1,",.01)=3031001
 S FDA(428,80.711,"+3,?2,?1,",.01)=115
 S FDA(428,80.711,"+4,?2,?1,",.01)=121
 S FDA(428,80.711,"+5,?2,?1,",.01)=124
 S FDA(428,80.711,"+6,?2,?1,",.01)=127
 D UPDATE^DIE("","FDA(428)")
 ; kill 80.071 and 80.072 subfile records for diag 309.81
DELETE ;
 N DA,DIK
 S DA(1)=1399
 S DA=2
 S DIK="^ICD9("_DA(1)_",""3"","
 D ^DIK
 S DIK="^ICD9("_DA(1)_",""4"","
 D ^DIK
 ;kill 80.071 and 80.072 subfile records for diag 250.70
 S DA(1)=8725
 S DA=2
 S DIK="^ICD9("_DA(1)_",""3"","
 D ^DIK
 S DIK="^ICD9("_DA(1)_",""4"","
 D ^DIK
 Q
 ;
REVD ;
 ;;402.91^ZX
 ;;428.32^ZX
 ;;430.^CQK
 ;;431.^CQK
 ;;432.9^CQK
 ;;EXIT
