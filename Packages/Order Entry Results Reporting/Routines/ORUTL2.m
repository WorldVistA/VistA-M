ORUTL2 ;ALB/DRI - OE/RR Utilities ;6/30/11  17:54
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**315**;Dec 17, 1997;Build 20
 ;
VEIL(ORIEN,STATUS) ;veil, unveil or delete veiled field
 N FDA
 I '$D(^OR(100,ORIEN,0)) Q  ;not a valid order
 I $S(STATUS="@":0,STATUS=0:0,STATUS=1:0,1:1) Q  ;veiled=1, unveiled=0 or delete it
 S FDA(100,ORIEN_",",8)=STATUS
 D FILE^DIE("E","FDA")
 Q
 ;
