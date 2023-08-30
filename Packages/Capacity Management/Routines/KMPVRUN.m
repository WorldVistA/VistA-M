KMPVRUN ;SP/JML - VSM Cache Task Manager driver ;2/1/2023
 ;;4.0;CAPACITY MANAGEMENT;**1,2,3**;3/1/2018;Build 17
 ;
 ; Reference to GETENV^%ZOSV in ICR #10097
 ; Reference to $ESTACK, $ETRAP and ^%ZTER in ICR#1621
 ;
RUN ;  Loop VSM CONFIGURATION file and run collection routine for monitors set to "ON"
 N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER Q"
 N DA,DIK,DUZ,FDA,Y,XMSUB,XMTEXT,XMY,U
 N KMPINST,KMPNDTYP,KMPVDAT,KMPVEMAIL,KMPVFNUM,KMPVH,KMPVIEN,KMPVMKEY,KMPVNODE,KMPVPDAT,KMPVROUT,KMPVTASK
 N KMPPSTAT,KMPSINF,KMPTEXT,KMPTNS,KMPVRNS,KMPVTNS,KMPFMDAY,X,X1,X2
 ; Stagger start times - use field not in use by current versions - value can't be 0
 H $R(+$$GETVAL^KMPVCCFG("VTCM","TASKMAN SCHEDULE START",8969)+1)
 S U="^",DUZ=.5,DUZ(0)="@"
 D GETENV^%ZOSV S KMPVNODE=$P(Y,"^",3) ;supported by ICR #10097
 S KMPINST=$P(Y,":",2),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)
 S KMPSINF=$$SITEINFO^KMPVCCFG() ; site name^fac num^mail domain^prod/test^site code
 S KMPVH=+$H
 ; Make sure SSL and Webapp classes exist
 D KMPWEB
 ; Send daily configuration message
 D CFGMSG^KMPUTLW("SERVER-DAILY")
 ; Ensure process only runs once a day
 ; Lock global,node - note: this node is not real, only for locking mechanism
 L ^KMPV(8969.03,KMPVNODE):30
 ; Quit if currently locked - concurrent processes
 I '$T G CLEANUP
 ; Create top ^XTMP node for the day
 I KMPNDTYP="BE" D 
 .S KMPFMDAY=$$HTFM^XLFDT($H,1)
 .S X1=KMPFMDAY,X2=$$GETVAL^KMPVCCFG("VTCM","DAYS TO KEEP DATA",8969)  D C^%DTC
 .S ^XTMP("KMP "_KMPFMDAY,0)=X_"^"_KMPFMDAY_"^Debug data for "_$ZD($H,3)
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
 S KMPVMKEY=""
 F  S KMPVMKEY=$O(^KMPV(8969,"B",KMPVMKEY)) Q:KMPVMKEY=""  D
 .S KMPVROUT=$$GETVAL^KMPVCCFG(KMPVMKEY,"CACHE DAILY TASK",8969)
 .S KMPVTASK="RETRY^"_KMPVROUT J @KMPVTASK
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
KMPWEB ;
 N KMPPROPS,KMPVRNS,KMPSTAT,KMPSSL
 S $ZT="ERREXIT"
 S KMPVRNS=$NAMESPACE
 S $NAMESPACE="%SYS"
 I ##class(Security.Applications).Exists("/KMP")=0 D
 .S KMPPROPS("NAME")="/KMP"
 .S KMPPROPS("NameSpace")=$ZDEFNSP
 .S KMPPROPS("Enabled")=1
 .S KMPPROPS("AutheEnabled")=64
 .S KMPPROPS("Timeout")=900
 .S KMPPROPS("UseCookies")=2
 .S KMPPROPS("CookiePath")="/KMP/"
 .S KMPPROPS("DispatchClass")="KMP.VistaSystemMonitor"
 .S KMPPROPS("MatchRoles")=":%All"
 .S KMPSTAT=##class(Security.Applications).Create("/KMP",.KMPPROPS)
 ;
 I ##class(Security.SSLConfigs).Exists("KMPHttpsClient")=0 D
 .S KMPSSL=##class(Security.SSLConfigs).%New()
 .S KMPSSL.Name="KMPHttpsClient"
 .S KMPSTAT=KMPSSL.%Save()
 S $NAMESPACE=KMPVRNS
 S $ETRAP="D ERR^ZU Q"
 Q
 ;
ERREXIT ;
 S $NAMESPACE=KMPVRNS
 S $ETRAP="D ERR^ZU Q"
 Q
 ;
ZSTU ;
 N KMPISBE,KMPMAP,KMPVMKEY,KMPVROUT,KMPVTASK,DA,DIE,DR
 N DUZ,U
 S DUZ=.5,DUZ(0)="@",U="^"
 ;
 D GETENV^%ZOSV S KMPVNODE=$P(Y,U,3)_":"_$P($P(Y,U,4),":",2) ;supported by ICR #10097
 S KMPISBE=$$ISBENODE^KMPVCCFG(KMPVNODE)
 ; verify or create SSL config and Web App
 I KMPISBE D KMPWEB^KMPVRUN
 ; verify or create Cache Task
 D TASK^KMPTASK
 ; Set CPRS Switch as it is not mirrored, verify LOGRSRC flag
 I $$GETVAL^KMPVCCFG("VCSM","ONOFF",8969)="ON" S ^KMPTMP("KMPD-CPRS")=1
 I $$GETVAL^KMPVCCFG("VBEM","ONOFF",8969)="ON" S DIE=8989.3,DA=1,DR="300///YES" D ^DIE
 ; Start VTCM, VBEM and VSTM collections directly on FE
 I 'KMPISBE D
 .F KMPVMKEY="VTCM","VBEM" D
 ..Q:$$GETVAL^KMPVCCFG(KMPVMKEY,"ONOFF",8969)'="ON"
 ..S KMPVROUT=$$GETVAL^KMPVCCFG(KMPVMKEY,"CACHE DAILY TASK",8969)
 ..I KMPVROUT'="" S KMPVTASK="RUN^"_KMPVROUT J @KMPVTASK
 .; Restart VCSM collection on FE if ^KMPTMP is not mapped to the BE
 .S KMPMAP=$P(##Class(%SYS.Namespace).GetGlobalDest($ZDEFNSP,"KMPTMP",""),"^",2)
 .S KMPMAP=$SYSTEM.SQL.UPPER(KMPMAP)
 .Q:KMPMAP["SHARE"
 .Q:$$GETVAL^KMPVCCFG("VCSM","ONOFF",8969)'="ON"
 .S KMPVROUT=$$GETVAL^KMPVCCFG("VCSM","CACHE DAILY TASK",8969)
 .I KMPVROUT'="" S KMPVTASK="RUN^"_KMPVROUT J @KMPVTASK
 ; Restart all collections on the BE
 I KMPISBE D
 .S KMPVMKEY=""
 .F  S KMPVMKEY=$O(^KMPV(8969,"B",KMPVMKEY)) Q:KMPVMKEY=""  D
 ..Q:$$GETVAL^KMPVCCFG(KMPVMKEY,"ONOFF",8969)'="ON"
 ..S KMPVROUT=$$GETVAL^KMPVCCFG(KMPVMKEY,"CACHE DAILY TASK",8969)
 ..I KMPVROUT'="" S KMPVTASK="RUN^"_KMPVROUT J @KMPVTASK
 Q
