ICD1832U   ; ALB/DHH - FY 2008 UPDATE; 7/27/05 14:50;
 ;;18.0;DRG Grouper;**32**;Oct 13,2000;Build 9
 Q
 ;
DIAG ; - update diagnosis codes
 ; from Table 6A in Fed Reg - assumes new codes already added by Lexicon
 D BMES^XPDUTL(">>>Modifying new diagnosis codes - file 80")
 N LINE,X,ICDDIAG,ENTRY,DA,DIE,DR,IDENT,MDC,MDC25,FDA
 F LINE=1:1 S X=$T(REVD+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",0))
 .I ENTRY D
    ..;check for possible inactive dupe
 ..I $P($G(^ICD9(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD9("BA",$P(ICDDIAG,U)_" ",ENTRY)) I 'ENTRY Q 
 ..S DA=ENTRY,DIE="^ICD9("
 ..S IDENT=$P(ICDDIAG,U,2)
 ..S MDC=$P(ICDDIAG,U,3)
 ..;this would only apply to diagnoses who have no other MDC than a pre-MDC
 ..I MDC="PRE" S MDC=98
 ..S MDC25=$P(ICDDIAG,U,4)
 ..S MDC24=$P(ICDDIAG,U,5)
 ..S DR="2///^S X=IDENT;5///^S X=MDC;5.9///^S X=MDC25;5.7///^S X=MDC24"
 ..D ^DIE
 ..Q:$D(^ICD9(ENTRY,4,"B",3071001))
 ..N FDA
 ..S FDA(1820,80,"?1,",.01)="`"_ENTRY
 ..S FDA(1820,80.072,"+3,?1,",.01)=3071001
 ..S FDA(1820,80.072,"+3,?1,",1)=$P(ICDDIAG,U,3)
 ..D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 Q
 ;
REVD ;DIAG^IDEN^MDC^MDC25
 ;;338.4^^1
 ;;040.41^^18
 ;;040.42^^18
 ;;058.10^^18
 ;;058.11^^18
 ;;058.12^^18
 ;;058.81^^9
 ;;058.82^^9
 ;;058.89^^9
 ;;079.83^^18
 ;;233.30^^13
 ;;233.31^^13
 ;;233.32^^13
 ;;233.39^^13
 ;;255.41^^10
 ;;255.42^^10
 ;;258.01^^10
 ;;258.02^^10
 ;;258.03^^10
 ;;288.66^^16
 ;;315.34^^19
 ;;331.5^^1
 ;;359.21^^1
 ;;359.22^^1
 ;;359.23^^1
 ;;359.24^^1
 ;;359.29^^1
 ;;364.81^^2
 ;;364.89^^2
 ;;388.45^^19
 ;;389.05^^3
 ;;389.06^^3
 ;;389.13^^3
 ;;389.17^^3
 ;;389.20^^3
 ;;389.21^^3
 ;;389.22^^3
 ;;414.2^^4
 ;;415.12^^4
 ;;423.3^^5
 ;;440.4^^5
 ;;449.^^5
 ;;488.^^3
 ;;525.71^^3
 ;;525.72^^3
 ;;525.73^^3
 ;;525.79^^3
 ;;569.43^^6
 ;;624.01^^13
 ;;624.02^^13
 ;;624.09^^13
 ;;664.60^^14
 ;;664.61^^14
 ;;664.64^^14
 ;;733.45^^8
 ;;787.20^^6
 ;;787.21^^6
 ;;787.22^^6
 ;;787.23^^6
 ;;787.24^^6
 ;;787.29^^6
 ;;789.51^^23
 ;;789.59^^23
 ;;999.31^^5
 ;;999.39^^18
 ;;V12.53^^23
 ;;V12.54^^23
 ;;V13.22^^17
 ;;V16.52^^23
 ;;V17.41^^23
 ;;V17.49^^23
 ;;V18.11^^23
 ;;V18.19^^23
 ;;V25.04^^23
 ;;V26.41^^23
 ;;V26.49^^23
 ;;V26.81^^23
 ;;V26.89^^23
 ;;V49.85^^23
 ;;V68.01^^23
 ;;V68.09^^23
 ;;V72.12^^23
 ;;V73.81^^23
 ;;V84.81^^23
 ;;V84.89^^23
 ;;EXIT
