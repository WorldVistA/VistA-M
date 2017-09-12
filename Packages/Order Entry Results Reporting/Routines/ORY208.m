ORY208 ; slc/dcm - postinit for OR*3*208 ;10/8/03  11:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**208**;Dec 17, 1997
 ;
 Q
 ;
PRE ; -- preinit
 N ORI,DA,DIK
 S ORI=999
 F  S ORI=$O(^ORD(101.24,ORI)) Q:'ORI  I ORI<1110!(ORI>1116),ORI'=1033 S DA=ORI,DIK="^ORD(101.24," D ^DIK
 Q  ;Don't step on Kim's patch 159 or Rich's patch 151
POST ; -- postinit
 Q
