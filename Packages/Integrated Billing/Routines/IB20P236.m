IB20P236 ;WOIFO/SS-PATCH INSTALL ROUTINE ;7/30/03
 ;;2.0;INTEGRATED BILLING;**236**;21-MAR-94
 ;File #399 input template compilation routine
 Q  ;stub
EN ;entry point for post-install routine
 ;re-compile template
 N DMAX,IBX,Y,X,IBMAX
 D BMES^XPDUTL("Recompilation of [IB SCREEN1] Input Template:")
 S IBMAX=^DD("ROU")
 S IBX="IB SCREEN1"
 S Y=$O(^DIE("B",IBX,0)) Q:'Y
 I $D(^DIE(Y,"ROUOLD")),^("ROUOLD")]"",$D(^(0)) D
 . S X=$P(^("ROUOLD"),"^"),DMAX=IBMAX
 . D EN^DIEZ
 Q
 ;
