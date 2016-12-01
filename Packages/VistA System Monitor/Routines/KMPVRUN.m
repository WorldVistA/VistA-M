KMPVRUN ;SP/JML - VSM Cache Task Manager driver ;9/1/2015
 ;;1.0;VISTA SYSTEM MONITOR;;9/1/2015;Build 89
 ;
 ;
RUN ;  Loop VSM CONFIGURATION file and run collection routine for monitors set to "ON"
 S $ETRAP="D ERR^KMPVRUN"
 N DA,DIK,FDA,Y
 N KMPVDAT,KMPVFNUM,KMPVH,KMPVIEN,KMPVMKEY,KMPVNODE,KMPVPDAT,KMPVROUT,KMPVTASK
 D GETENV^%ZOSV S KMPVNODE=$P(Y,"^",3) ;  IA 10097
 S KMPVH=+$H
 ;
 ; Ensure process only runs once a day
 ; Lock global,node - note: this node is not real, only for locking mechanism
 L ^KMPV(8969.03,KMPVNODE):30
 ; Quit if currently locked - concurrent processes
 I '$T G CLEANUP
 ;
 S KMPVIEN=$O(^KMPV(8969.03,"C",KMPVH,KMPVNODE,""))
 ; Quit if entry already exists for today - job was run previously
 I KMPVIEN'="" G CLEANUP
 ;
 ; Once single process verified - Execute Tasks and record date/times
 S FDA($J,8969.03,"+1,",.01)=+$H
 S FDA($J,8969.03,"+1,",.02)=KMPVNODE
 S KMPVMKEY=""
 F  S KMPVMKEY=$O(^KMPV(8969,"B",KMPVMKEY)) Q:KMPVMKEY=""  D
 .; ALWAYS - verify data is not building past configured number of days - if so for any reason, delete it
 .D PURGEDLY^KMPVCBG(KMPVMKEY)
 .Q:$$GETVAL^KMPVCCFG(KMPVMKEY,"ONOFF",8969)'="ON"
 .S KMPVROUT=$$GETVAL^KMPVCCFG(KMPVMKEY,"CACHE DAILY TASK",8969)
 .I KMPVROUT'="" D
 ..S KMPVTASK="RUN^"_KMPVROUT J @KMPVTASK
 ..S KMPVFNUM=+$$FLDNUM^DILFD(8969.03,KMPVMKEY_" RUNTIME")
 ..I KMPVFNUM>0 S FDA($J,8969.03,"+1,",KMPVFNUM)=$$NOW^XLFDT
 D UPDATE^DIE("","FDA($J)","","")
 ;
CLEANUP ; Purge old data in VSM CACHE TASK LOG file and release lock
 S KMPVPDAT=KMPVH-190
 S DIK="^KMPV(8969.03,"
 S KMPVDAT=""
 F  S KMPVDAT=$O(^KMPV(8969.03,"B",KMPVDAT)) Q:KMPVDAT>KMPVPDAT!(KMPVDAT="")  D
 .S DA=""
 .F  S DA=$O(^KMPV(8969.03,"B",KMPVDAT,DA)) Q:DA=""  D ^DIK
 L -^KMPV(8969.03,KMPVNODE)
 Q
 ;
ERR ; Error trap as routine is called from Cache Task Manager
 D ^%ZTER
 D UNWIND^%ZTER
 Q
