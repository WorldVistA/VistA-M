IBDY314 ;ALB/AAS - POST INSTALL FOR PATCH IBD*3*14 ; 23-JUN-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**14**;APR 24, 1997
 ;
 D UPDATE^IBDECLN(1)
 D UNCOMP
 Q
 ;
UNCOMP ; -- uncompile all forms --
 N ZTQUEUED
 D MES^XPDUTL(">>> Now uncompiling all Encounter Forms.")
 S ZTQUEUED=1
 D RECMPALL^IBDF19
 D MES^XPDUTL("    Okay, forms will be recompiled as they are printed.")
 Q
