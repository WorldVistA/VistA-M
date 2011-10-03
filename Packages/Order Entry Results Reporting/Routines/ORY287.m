ORY287 ;dcm - Pre and Post-init for patch OR*3*287 ;1/14/08  11:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**287**;Dec 17, 1997;Build 2
PRE ; initiate pre-init processes
 Q:$$PATCH^XPDUTL("OR*3.0*243")
 S ORI=999
 F  S ORI=$O(^ORD(101.24,ORI)) Q:'ORI  I ORI<1110!(ORI>1116) S DA=ORI,DIK="^ORD(101.24," D ^DIK
 Q
POST ; initiate post-init processes
 Q
