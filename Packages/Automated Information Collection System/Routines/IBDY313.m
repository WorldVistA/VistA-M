IBDY313 ;ALB/JS - Post Install routine for IBD*3*13  - 28-Oct-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**13**;APR 24, 1997
 ;
UNCOMP ; -- uncompile all forms --
 N ZTQUEUED
 D MES^XPDUTL(">>> Now uncompiling all Encounter Forms.")
 S ZTQUEUED=1
 D RECMPALL^IBDF19
 D MES^XPDUTL("  Okay, forms will be recompiled as they are printed.")
 Q
