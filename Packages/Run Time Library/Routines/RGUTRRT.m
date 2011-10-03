RGUTRRT ;CAIRO/DKM - Remote routine transfer;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Utility to copy routines to all target machines.  A server
 ; runs in the background on all machines to receive new routines.
 ;=================================================================
 ; This is the entry point for interactive use
 D ENTRY(0)
 Q
DELETE D ENTRY(1)
 Q
ENTRY(RGDALL) ;
 D HOME^%ZIS
 D TITLE^RGUT("Remote Routine "_$S(RGDALL:"Delete",1:"Transfer"),"1.0")
 X ^%ZOSF("RSEL")
 I RGDALL D
 .N RGRTN
 .S RGRTN=$C(1)
 .F  S RGRTN=$O(^UTILITY($J,RGRTN)) Q:RGRTN=""  S ^(RGRTN)="DELETE"
 D SAVE
 Q
 ; This entry point allows passing routine names in ^UTILITY
 ; If the data of the ^UTILITY node is "DELETE", the routine is deleted!
SAVE Q:$D(^UTILITY($J))<10
 N RGRTN,RGDEL
 S RGRTN=$C(1),U="^"
 F  S RGRTN=$O(^UTILITY($J,RGRTN)) Q:RGRTN=""  D
 .S RGDEL=^(RGRTN)="DELETE"
 .K ^(RGRTN)
 .D RRT(RGRTN,RGDEL)
 D JOB
 Q
 ; This subroutine remote copies/deletes routine RGRTN
RRT(RGRTN,RGDEL) ;
 Q:RGRTN'?1.8AN!($G(^RGUTL("UCI"))="")
 N RGX,RGZ,RGZ1,RGZ2
 S RGDEL=+$G(RGDEL),U="^"
 L +^XTMP("RGUTSRV",0)
 S RGX=1+$O(^XTMP("RGUTSRV",$C(1)),-1)
 F RGZ=0:0 S RGZ=+$O(^XTMP("RGUTSRV","B",RGRTN,RGZ)) Q:'RGZ  K ^(RGZ),^XTMP("RGUTSRV",RGZ)
 S ^XTMP("RGUTSRV",RGX)=RGRTN,^XTMP("RGUTSRV","B",RGRTN,RGX)=""
 L -^XTMP("RGUTSRV",0)
 X:'RGDEL "ZL "_RGRTN_" F RGZ=1:1 S RGZ1=$T(+RGZ) Q:'$L(RGZ1)  S ^XTMP(""RGUTSRV"",RGX,RGZ)=RGZ1"
 S RGZ2=$$UCI
 F RGZ1=1:1 S RGZ=$$UCI(RGZ1) Q:'$L(RGZ)  S:RGZ'=RGZ2!RGDEL ^XTMP("RGUTSRV",RGX,0,RGZ)=""
 F RGZ1=1:1 S RGZ=$$UCI(RGZ1) Q:'$L(RGZ)  S:RGZ'=RGZ2!RGDEL ^XTMP("RGUTSRV",RGZ,RGX)=""
 Q
 ; Return indexed UCI
UCI(RGN) N RGZ,Y
 I '$G(RGN) X ^%ZOSF("UCI") Q Y
 S U="^",RGZ=$P($G(^RGUTL("UCI")),U,RGN)
 I $L(RGZ),RGZ'["," S RGZ=$P($$UCI,",")_","_RGZ
 Q RGZ
 ; Make sure all remote servers are running
JOB N RGZ,RGUCI
 F RGZ=1:1 S RGUCI=$$UCI(RGZ) Q:'$L(RGUCI)  D
 .L +^XTMP("RGUTSRV",RGUCI):0
 .E  Q
 .L -^XTMP("RGUTSRV",RGUCI)
 .I $$QUEUE^RGUTTSK("^RGUTSRV","Remote Routine Transfer",,,,RGUCI)
 Q
 ; Shutdown remote servers
SHUTDOWN N RGZ,RGUCI
 F RGZ=1:1 S RGUCI=$$UCI(RGZ) Q:'$L(RGUCI)  S ^XTMP("RGUTSRV",RGUCI,0)=1
 Q
