XUINPRE ;SF/STAFF - KERNEL VERSION 8 PRE-INITIALIZATION ;11/30/94  13:27
 ;;8.0;KERNEL;;Jul 10, 1995
 ;Build check points for KIDS to run
 N %
 S %='$$NEWCP^XPDUTL("PRE1","OPFIX^XUINPRE"),%=$$NEWCP^XPDUTL("PRE2","ZZBUL^XUINPRE")
 ;Now return to KIDS, and let KIDS run the check points
 Q
OPFIX N XQI,DA,DIK
 D MES^XPDUTL("Clean up dangling 99 nodes in the OPTION File.")
 F XQI=0:0 S XQI=$O(^DIC(19,XQI)) Q:XQI'>0  D
 .I $D(^DIC(19,+XQI,99)),'$D(^DIC(19,XQI,0)) K ^DIC(19,XQI,99)
 .I $D(^DIC(19,+XQI,1,0,0)) K ^DIC(19,+XQI,1)
 I $D(^DD(19,1000,0)) D
 . D MES^XPDUTL("Remove field 1000 from Option File")
 . S DA=1000,DA(1)=19,DIK="^DD(19," D ^DIK
 Q
ZZBUL N DA,DIK
 I $D(^DD(3.6,.01,1,2,"CREATE VALUE")),^("CREATE VALUE")="ZZBUL" D
 . S DIK="^DD(3.6,.01,1,",DA=2,DA(1)=.01,DA(2)=3.6
 . D ^DIK,MES^XPDUTL("Remove the ZZBUL trigger from the bulletin file.")
 Q
