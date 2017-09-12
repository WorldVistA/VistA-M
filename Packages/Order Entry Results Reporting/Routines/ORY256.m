ORY256 ;;SLC/dcm - Pre and Post-init for patch OR*3*256 ;11/6/07  14:27
 ;;3.0;ORDER ENTRY RESULTS REPORTING;**256**;Dec 17, 1997;Build 5
 ;
PRE ; Pre-init
 N ORI
 S ORI=999
 F  S ORI=$O(^ORD(101.24,ORI)) Q:'ORI  I ORI<1110!(ORI>1116) S DA=ORI,DIK="^ORD(101.24," D ^DIK
 Q
POST ; Post-init
 Q
