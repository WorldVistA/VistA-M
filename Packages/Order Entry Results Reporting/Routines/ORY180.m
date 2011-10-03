ORY180 ; slc/dcm - postinit for OR*3*180 ;03/11/03  12:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**180**;Dec 17, 1997
 ;
 Q
 ;
PRE ; -- preinit
 N ORI
 S ORI=999
 F  S ORI=$O(^ORD(101.24,ORI)) Q:'ORI  I ORI<1110!(ORI>1116),ORI'=1033 S DA=ORI,DIK="^ORD(101.24," D ^DIK
 Q  ;Don't step on Kim's patch 159 or Rich's patch 151
POST ; -- postinit
 N RPC,DA,DIC
 S RPC=$O(^XWB(8994,"B","ORQQPX IMMUN LIST",0)) Q:'RPC
 S DA(1)=+$O(^DIC(19,"B","OR CPRS GUI CHART",0)) Q:'DA(1)
 I $D(^DIC(19,DA(1),"RPC","B",RPC)) Q
 S DIC="^DIC(19,"_DA(1)_",""RPC"",",DIC(0)="LM",X="ORQQPX IMMUN LIST" D ^DIC
 Q
