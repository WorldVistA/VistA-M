HLCSDL ;ALB/MTC/SF/JC - INITIALIZE VARIABLES AND OPEN DEVICE X3.28 ;08/23/99  13:35
 ;;1.6;HEALTH LEVEL SEVEN;**2,44,49,57**;Oct 13, 1995
 ;
EN ;-- entry point for X3.28 protocol
 ;
 ;-- error trap (keepalive for disconnects)
 I ^%ZOSF("OS")["DSM" N $ETRAP S $ET=""
 S X="ERROR^HLCSDL",@^%ZOSF("TRAP")
EN1 ;-- check device init
 ;-- if device error and still running, try again
 I $$INIT,$$RUN^HLCSDL2 D EXIT2 H 5 G EN1
 ;-- setup X3.28 parameters
 I $$XSETUP G ENQ
 ;-- file start stats
 D FILE
 ;-- start LLP
 D START^HLCSDL1
 ;-- file end stats
 D END
 ;-- exit
ENQ D EXIT
 ;
 Q
 ;
INIT() ;-- check for device, open
 ;   This fucntion will return a 1 if it fails else 0
 ;
 N RESULT
 S RESULT=0
 I '$D(HLDP)&($G(%)'="") S HLDP=% ;LAUNCHED FROM VMS
 I '$D(HLDP) S RESULT=1 G INITQ
 D DT^DICRW
 I HLDP'>0 S HLDP=$O(^HLCS(870,"B",HLDP,""))
 I HLDP'>0 S RESULT=1 G INITQ
 ;HLDP IEN of LOGICAL LINK file #870
 S HLPARM=$G(^HLCS(870,HLDP,300))
 ;pointer to DEVICE file
 S HLDEVPTR=$P(HLPARM,U)
 ;-- check for valid pointer
 I HLDEVPTR'>0 S RESULT=1 G INITQ
 ;-- check for device
 S HLDEVICE=$P($G(^%ZIS(1,HLDEVPTR,0)),"^",1)
 I HLDEVICE="" S RESULT=1 G INITQ
 ;-- open device
 D MONITOR^HLCSDR2("OPEN",5,HLDP)
 K ZTIO S IOP=HLDEVICE D ^%ZIS I POP D MONITOR^HLCSDR2("OPENFAIL",5,HLDP) H 3 S RESULT=1 G INITQ
 ;-- set up environment
 S X=255 U IO X ^%ZOSF("EOFF"),^%ZOSF("RM"),^%ZOSF("TRMON")
 ;
INITQ Q RESULT
 ;
XSETUP() ;-- This function will set up all parameters required by the X3.28
 ;   protocol.
 ; This function will return a 1 if it fails, else 0
 ;
 N RESULT
 S RESULT=0
 ;-- initialize and set defaults
 ;-- max message size
 S HLMMS=$P(HLPARM,U,2) S:'HLMMS HLMMS=99999
 ;-- block size
 S HLDBLOCK=$P(HLPARM,U,3) S:'HLDBLOCK HLDBLOCK=245
 ;-- timer a
 S HLTIMA=$P(HLPARM,U,4) S:'HLTIMA HLTIMA=6
 ;-- timer b
 S HLTIMB=$P(HLPARM,U,5) S:'HLTIMB HLTIMB=3
 ;-- timer d
 S HLTIMD=$P(HLPARM,U,6) S:'HLTIMD HLTIMD=30
 ;-- timer e
 S HLTIME=$P(HLPARM,U,7) S:'HLTIME HLTIME=180
 N I,J,K F I=1:1 S J=$T(CTRLS+I) Q:J["END"  D
 .S K=$P(J,";",3),@K=$P(J,";",4)
 .S HLCTRL(@K)=$P(J,";",5)
 I $G(HLTRACE) K ^TMP("HLLOG",$J) S HLLOG=0
 ;
XSETQ Q RESULT
 ;
FILE ;-- file startup stats
 ;
 D NOW^%DTC
 L +^HLCS(870,HLDP,0):DTIME I '$T G FILE
 ;9=Time Started, 10=Time Stopped, 11=Task Number 
 ;14=Shutdown LLP, 3=Device Type, 18=Gross Errors
 I '$D(ZTSK) S ZTSK=""
 S DIE="^HLCS(870,",DA=HLDP,DR="9////^S X=%;10////@;11////^S X=ZTSK;14////0;3////SX;18////@" D ^DIE K DIE,DA,DR
 L -^HLCS(870,HLDP,0)
 Q
 ;
END ;-- file stats
 D NOW^%DTC
 D MONITOR^HLCSDR2("SHUTDOWN",5,HLDP)
 L +^HLCS(870,HLDP,0):DTIME I '$T G END
 ;10=Time Stopped,9=Time Started,11=Task Number
 S DIE="^HLCS(870,",DA=HLDP,DR="10////^S X=%;9////@;11////@" D ^DIE K DIE,DA,DR
 L -^HLCS(870,HLDP,0)
 Q
 ;
EXIT2 ;
 D ^%ZISC X ^%ZOSF("EON")
 Q
EXIT ;-- exit cleanup
 D ^%ZISC X ^%ZOSF("EON")
 K HLMMS,HLBLOCK,HLTIMA,HLTIMB,HLTIMD,HLTIME,HLTERM,HLSOH,HLSTX,HLETB,HLETX,HLEOT,HLENQ,HLRINT,HLDLE,HLNAK,HLACK0,HLACK1,HLACK2,HLACK3,HLACK4,HLACK5,HLACK6,HLACK7
 K HLDNODE,HLDEVPTR,HLDEVICE,HLRETPRM,HLDAPP,X,HLDEND,HLDSTRT,HLDVER,HLDREAD,HLDWRITE,HLDP,HLTRACE,ZTSK,HLDBSIZE
 Q
 ;
ERROR ;
 ;-- on disconnect errors, trap and try to reconnect, all others,
 ;   trap and shut down gracefully
 I $$EC^%ZOSV["DSCON" D MONITOR^HLCSDR2("Disconnect",5,HLDP) H 3 G EN1
 D ^%ZTER
 D END G EXIT
CTRLS ;X3.28 control settings
 ;;HLTERM;13;<CR>
 ;;HLSOH;1;<SOH>
 ;;HLSTX;2;<STX>
 ;;HLETB;23;<ETB>
 ;;HLETX;3;<ETX>
 ;;HLEOT;4;<EOT>
 ;;HLENQ;5;<ENQ>
 ;;HLRINT;60;<RINT>
 ;;HLDLE;16;<DLE>
 ;;HLNAK;21;<NAK>
 ;;HLACK0;48;<ACK0>
 ;;HLACK1;49;<ACK1>
 ;;HLACK2;50;<ACK2>
 ;;HLACK3;51;<ACK3>
 ;;HLACK4;52;<ACK4>
 ;;HLACK5;53;<ACK5>
 ;;HLACK6;54;<ACK6>
 ;;HLACK7;55;<ACK7>
 ;;END
