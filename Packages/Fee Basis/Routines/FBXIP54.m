FBXIP54 ;WOIFO/SS-PATCH INSTALL ROUTINE ;5/24/03
 ;;3.5;FEE BASIS;**54**;JAN 30, 1995
 ;File #161 input template compilation routine
 Q  ;stub
EN ;entry point for post-install routine
 ;re-compile template
 N DMAX,FBX,Y,X,FBMAX
 D BMES^XPDUTL("Recompilation of [FBAA AUTHORIZATION] Input Template:")
 S FBMAX=^DD("ROU")
 S FBX="FBAA AUTHORIZATION"
 S Y=$O(^DIE("B",FBX,0)) Q:'Y
 I $D(^DIE(Y,"ROUOLD")),^("ROUOLD")]"",$D(^(0)) D
 . S X=$P(^("ROUOLD"),"^"),DMAX=FBMAX
 . D EN^DIEZ
 Q
 ;
