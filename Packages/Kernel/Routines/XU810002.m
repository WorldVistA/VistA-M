XU810002 ; VEN/SMH - XU*8.0*10002 Pre/Post Install;2017-01-09  3:36 PM ; 6/5/18 3:27pm
 ;;8.0;KERNEL;**10002**;;Build 26
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel 2017.
PRE ; [KIDS PEP]
 D MES^XPDUTL("Stopping Taskman...")
 D GROUP^ZTMKU("SSUB(NODE)")
 D GROUP^ZTMKU("SMAN(NODE)")
 D MES^XPDUTL("Waiting around until Taskman reports it's stopped")
 F  W "." Q:($$TM^%ZTLOAD=0)  H 1
 QUIT
 ;
POST ; [KIDS PEP]
 D PATCH^ZTMGRSET(10002)
 ;
 I ^%ZOSF("OS")["OpenM" QUIT ; Rest is for GTM
 ;
 D MES^XPDUTL("Renaming ZUGTM...")
 D DO^ZUSET("ZUGTM")
 ;
 N Y D GETENV^%ZOSV
 N UCIBOX S UCIBOX=$P(Y,U,4)
 N IEN14P7 S IEN14P7=$O(^%ZIS(14.7," "),-1)
 N FDA S FDA(14.7,IEN14P7_",",.01)=UCIBOX
 N DIERR
 D FILE^DIE(,$NA(FDA))
 I $D(DIERR) D MES^XPDUTL("Failed to updated Taskman Site Parameters. You need to update manually.")
 D MES^XPDUTL("Starting Taskman...")
 D ^ZTMB
 QUIT
