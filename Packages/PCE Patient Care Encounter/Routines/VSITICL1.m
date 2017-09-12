VSITICL1 ;ISD/dee - Visit Tracking cleanup for VSIT*2.0*1 ;10/22/96
 ;;2.0;VISIT TRACKING;**1**;Aug 12, 1996
 ;
 Q  ; - not an entry point
 ;
PRE ;
 N DIU
 D BMES^XPDUTL("Kill file DD and Data.")
 D MES^XPDUTL("  ANCILLARY DSS ID #150.1")
 S DIU="150.1",DIU(0)="DT" D EN^DIU2 K DIU
 ;stop lab from being able to make visit
 L +^LRO(69,"AA")
 Q
 ;
POST ;
 ;turn lab back on
 L -^LRO(69,"AA")
 Q
 ;
