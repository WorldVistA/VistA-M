ORY160 ; slc/dcm - postinit for OR*3*160 ;11/01/02  12:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**160**;Dec 17, 1997
 ;
 Q
 ;
PRE ; -- preinit
 N ORI
 S ORI=999
 F  S ORI=$O(^ORD(101.24,ORI)) Q:'ORI  I ORI<1110!(ORI>1116),ORI'=1033 S DA=ORI,DIK="^ORD(101.24," D ^DIK
 Q  ;Don't step on Kim's patch 159 or Rich's patch 151
POST ; -- postinit
 Q
