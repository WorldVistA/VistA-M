NUR2PRE ;HIRMFO/RM-PATCH NUR*4*2 PREINIT 8/97
 ;;4.0;NURSING SERVICE;**2**;Apr 25, 1997
 D BMES^XPDUTL("Removing data from the BUDGETED SVC. CATEGORY field in the NURS POSITION CONTROL (#211.8) File. Field Definition is changing to Computed.")
 S DA=0 F  S DA=$O(^NURSF(211.8,DA)) Q:DA'>0  I $D(^NURSF(211.8,DA,0)) W:'$D(ZTQUEUED) "." S $P(^(0),"^",3)=""
 Q
