KMPDUTL3 ;OAK/RAK - CM Tools Utility ;2/17/04  10:53
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
PURGE(KMPDT) ;-- purge data in file #8973.1
 ;-----------------------------------------------------------------------
 ; KMPDT.. Date to begin purge in internal fileman format. Purge will
 ;           reverse $order and delete entries 'EARLIER' than KMPDT.
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPDT)
 ;
 N DA,DATE,DIK,IEN
 W:'$D(ZTQUEUED) !!,"Purging old records..."
 S DATE=KMPDT
 F  S DATE=$O(^KMPD(8973.1,"B",DATE),-1) Q:'DATE!(DATE>KMPDT)  D 
 .F IEN=0:0 S IEN=$O(^KMPD(8973.1,"B",DATE,IEN)) Q:'IEN  D 
 ..; quit if not 'sent to cm database'.
 ..Q:'$P($G(^KMPD(8973.1,IEN,0)),U,2)
 ..I '$D(ZTQUEUED) W:$X>78 !?16 W "."
 ..; Delete entry.
 ..S DA=IEN,DIK="^KMPD(8973.1," D ^DIK
 ;
 Q
 ;
PURGE1 ;-- purge data in file #8973.2
 ;
 N DA,DATE,DAYS,DIK,IEN,PURGE
 ;
 ; days to keep data (weeks * 7)
 S DAYS=$P($G(^KMPD(8973,1,4)),U,11)
 S:'DAYS DAYS=4 S DAYS=DAYS*7
 ; determine date to start purge
 S PURGE=$$FMADD^XLFDT(DT,-DAYS) Q:'PURGE
 W:'$D(ZTQUEUED) !!,"Purging old records..."
 S DATE=PURGE-.1
 F  S DATE=$O(^KMPD(8973.2,"C",DATE),-1) Q:'DATE!(DATE>PURGE)  D 
 .F IEN=0:0 S IEN=$O(^KMPD(8973.2,"C",DATE,IEN)) Q:'IEN  D 
 ..Q:'$D(^KMPD(8973.2,IEN,0))
 ..W:'$D(ZTQUEUED)&('(IEN#10)) "."
 ..; delete entry.
 ..S DA=IEN,DIK="^KMPD(8973.2," D ^DIK
 ;
 Q
