HLCSTCP ;SFIRMFO/TNV-ALB/JFP,PKE - (TCP/IP) MLLP ;04/15/2008  10:58
 ;;1.6;HEALTH LEVEL SEVEN;**19,43,49,57,58,64,84,109,133,122,140**;Oct 13, 1995;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This is an implementation of the HL7 Minimal Lower Layer Protocol
 ; taskman entry/startup option, HLDP defined in menu entry.
 ;
 Q:'$D(HLDP)
 ; patch HL*1.6*122 start
 L +^HLCS("HLTCPLINK",HLDP):5 I '$T D  Q
 . D MON^HLCSTCP("TskLcked")
 N HLCSOUT,HLDBACK,HLDBSIZE,HLDREAD,HLDRETR,HLRETRA,HLDWAIT,HLOS,HLTCPADD,HLTCPCS,HLTCPLNK,HLTCPORT,HLTCPRET
 N HLZRULE
 ;HLCSOUT= 1-error
 I '$$INIT D EXITS("Init Error") Q
 S HLDP("$J")=$J
 S HLDP("$J",0,"LENGTH")=$L(HLDP("$J"))
 ; Start the client
 I $G(HLTCPCS)="C" D  Q
 . S HLDP("$J",0,"START")=HLDP("$J",0,"LENGTH")-8+$L(HLTCPORT)+$L(HLDP)
 . I HLDP("$J",0,"START")<1 S HLDP("$J",0,"START")=1
 . S HLDP("$J",0)=$E(HLDP("$J"),HLDP("$J",0,"START"),HLDP("$J",0,"LENGTH"))
 . ; identify process for ^%SY
 . ; D SETNM^%ZOSV($E("HLClnt:"_HLDP,1,15))
 . D SETNM^%ZOSV($E("HLc:"_HLTCPORT_"-"_HLDP_"-"_HLDP("$J",0),1,15))
 . K HLDP("$J",0)
 . D ST1
 . F  D ^HLCSTCP2 Q:$$STOP!$G(HLCSOUT)
 . ; I $G(HLCSOUT)=1 D MON("Error") H 1 Q
 . I $G(HLCSOUT)=1 D  Q
 .. D MON("Error") H 1
 .. L -^HLCS("HLTCPLINK",HLDP)
 . I $G(HLCSOUT)=2 D EXITS("Inactive") Q
 . D EXITS("Shutdown")
 ;
 S HLDP("$J",0,"START")=HLDP("$J",0,"LENGTH")-9+$L(HLTCPORT)
 I HLDP("$J",0,"START")<1 S HLDP("$J",0,"START")=1
 S HLDP("$J",0)=$E(HLDP("$J"),HLDP("$J",0,"START"),HLDP("$J",0,"LENGTH"))
 ; identify process for ^%SY
 ; D SETNM^%ZOSV($E("HLSrv:"_HLDP,1,15))
 D SETNM^%ZOSV($E("HLs:"_HLTCPORT_"-"_HLDP("$J",0),1,15))
 K HLDP("$J",0)
 ; to stop the listener via updated Kernel API, need to pass the
 ; listener logical link (HLDP)
 S HLZRULE="S HLDP="_HLDP_" S ZISQUIT=$$STOP^HLCSTCP"
 ;single threaded listener
 I $G(HLTCPCS)="S" D  Q
 . D ST1,MON("Listen"),LISTEN^%ZISTCP(HLTCPORT,"SERVER^HLCSTCP("""_HLDP_""")",HLZRULE)
 . I $$STOP D EXITS("Shutdown") Q
 . D EXITS("Openfail")
 ;
 ;multi-threaded listener (for OpenM/NT)
 I ($G(HLTCPCS)'="M")!(^%ZOSF("OS")'["OpenM") D  Q
 . L -^HLCS("HLTCPLINK",HLDP)
 I $$OS^%ZOSV["VMS" L -^HLCS("HLTCPLINK",HLDP) Q
 D ST1,MON("Listen"),LISTEN^%ZISTCPS(HLTCPORT,"SERVERS^HLCSTCP("""_HLDP_""")",HLZRULE)
 ; update status of listener
 I $$STOP D EXITS("Shutdown") Q
 D EXITS("Openfail")
 ; HL*1.6*122 end
 Q
 ;
SERVER(HLDP) ; single server using Taskman
 I '$$INIT D EXITS("Init error") Q
 D ^HLCSTCP1
 I $$STOP D CLOSE^%ZISTCP,EXITS("Shutdown") S IO("C")="" Q
 Q:$G(HLCSOUT)=1
 D MON("Idle")
 Q
 ;
SERVERS(HLDP) ; Multi-threaded server using Taskman
 I '$$INIT D EXITS("Init error") Q
 G LISTEN
 ;
 ;multiple process servers, called from an external utility
MSM ;MSM entry point, called from User-Defined Services
 ;HLDP=ien in the HL LOWER LEVEL PROTOCOL PARAMETER file for the
 ;HL7 Multi-Threaded SERVER
 S (IO,IO(0))=$P
 G LISTEN
 ;
LISTEN ;
 N HLLSTN,HLCSOUT,HLDBACK,HLDBSIZE,HLDREAD,HLDRETR,HLRETRA,HLDWAIT,HLOS,HLTCPADD,HLTCPCS,HLTCPLNK,HLTCPORT,HLTCPRET
 I '$$INIT D ^%ZTER Q
 ; patch HL*1.6*122 start
 S HLDP("$J")=$J
 S HLDP("$J",0,"LENGTH")=$L(HLDP("$J"))
 S HLDP("$J",0,"START")=HLDP("$J",0,"LENGTH")-9+$L(HLTCPORT)
 I HLDP("$J",0,"START")<1 S HLDP("$J",0,"START")=1
 S HLDP("$J",0)=$E(HLDP("$J"),HLDP("$J",0,"START"),HLDP("$J",0,"LENGTH"))
 ; identify process for ^%SY
 ; D SETNM^%ZOSV($E("HLSrv:"_HLDP,1,15))
 D SETNM^%ZOSV($E("HLs:"_HLTCPORT_"-"_HLDP("$J",0),1,15))
 K HLDP("$J",0)
 ; patch HL*1.6*122 end
 ;HLLSTN used to identify a listener to tag MON
 S HLLSTN=1
 ;increment job count, run server
 D UPDT(1),^HLCSTCP1,EXITM
 Q
 ;
DCOPEN(HLDP) ;open direct connect - called from HLMA2
 Q:'$$INIT 0
 Q:HLTCPADD=""!(HLTCPORT="") 0
 Q:'$$OPEN^HLCSTCP2 0
 Q 1
 ;
INIT() ; Initialize Variables
 ; HLDP should be set to the IEN or name of Logical Link, file 870
 S HLOS=$P($G(^%ZOSF("OS")),"^")
 N DA,DIQUIET,DR,TMP,X,Y
 ; patch HL*1.6*140
 ; S IOF=$$FLUSHCHR^%ZISTCP ; HL*1.6*122 set device flush character
 S HLTCPLNK("IOF")=$$FLUSHCHR^%ZISTCP
 S DIQUIET=1
 D DT^DICRW
 I 'HLDP S HLDP=$O(^HLCS(870,"B",HLDP,0)) I 'HLDP Q 0
 S DA=HLDP
 ; patch HL*1.6*122 for field 400.09
 S DR="200.02;200.021;200.022;200.03;200.04;200.05;200.09;400.01;400.02;400.03;400.04;400.05;400.09"
 D GETS^DIQ(870,DA,DR,"IN","TMP","TMP")
 ;
 I $D(TMP("DIERR")) QUIT 0
 ; -- re-transmit attempts
 S HLDRETR=+$G(TMP(870,DA_",",200.02,"I"))
 S HLDRETR("CLOSE")=+$G(TMP(870,DA_",",200.022,"I"))
 ; -- exceed re-transmit action
 S HLRETRA=$G(TMP(870,DA_",",200.021,"I"))
 ; -- block size
 S HLDBSIZE=+$G(TMP(870,DA_",",200.03,"I"))
 ; -- read timeout
 S HLDREAD=+$G(TMP(870,DA_",",200.04,"I"))
 ; -- ack timeout
 S HLDBACK=+$G(TMP(870,DA_",",200.05,"I"))
 ; -- uni-directional wait
 S HLDWAIT=$G(TMP(870,DA_",",200.09,"I"))
 ; -- tcp address
 S HLTCPADD=$G(TMP(870,DA_",",400.01,"I"))
 ; -- tcp port
 S HLTCPORT=$G(TMP(870,DA_",",400.02,"I"))
 ; -- tcp/ip service type
 S HLTCPCS=$G(TMP(870,DA_",",400.03,"I"))
 ; -- link persistence
 S HLTCPLNK=$G(TMP(870,DA_",",400.04,"I"))
 ; -- retention
 S HLTCPRET=$G(TMP(870,DA_",",400.05,"I"))
 ;
 ; patch HL*1.6*140
 ; patch HL*1.6*122 for field 400.09
 ; -- tcp/ip openfail timeout
 ; S HLTCPLNK("TIMEOUT")=$G(TMP(870,DA_",",400.09,"I"))
 S HLTCPLNK("TIMEOUT")=+$G(TMP(870,DA_",",400.09,"I"))
 ;
 ; -- set defaults in case something's not set
 S:HLDREAD=0 HLDREAD=10
 S:HLDBACK=0 HLDBACK=60
 ; patch HL*1.6*122
 ; S:HLDBSIZE=0 HLDBSIZE=245
 S:HLDBSIZE<245 HLDBSIZE=245
 S:HLDRETR=0 HLDRETR=5
 S:HLTCPRET="" X=$P($$PARAM^HLCS2,U,12),HLTCPRET=$S(X:X,1:15)
 ;
 ; patch HL*1.6*140, the defaut is 30
 ; patch HL*1.6*122 for field 400.09
 ; S:HLTCPLNK("TIMEOUT")=0 HLTCPLNK("TIMEOUT")=5
 S:(HLTCPLNK("TIMEOUT")<1) HLTCPLNK("TIMEOUT")=30
 ;
 Q 1
 ;
ST1 ;record startup in 870 for single server
 ;4=status 9=Time Started, 10=Time Stopped, 11=Task Number 
 ;14=Shutdown LLP, 3=LLP Online, 18=Gross Errors
 N HLJ,X
 ; HL*1.6*122 remove unnecessary locks
 ;F  L +^HLCS(870,HLDP,0):2 Q:$T
 S X="HLJ(870,"""_HLDP_","")"
 S @X@(4)="Init",(@X@(10),@X@(18))="@",@X@(14)=0
 I HLTCPCS["C" S @X@(3)=$S(HLTCPLNK["Y":"PC",1:"NC")
 E  S @X@(3)=$S(HLTCPCS["S":"SS",HLTCPCS["M":"MS",1:"")
 I @X@(3)'="NC" S @X@(9)=$$NOW^XLFDT
 S:$G(ZTSK) @X@(11)=ZTSK
 D FILE^HLDIE("","HLJ","","ST1","HLCSTCP") ;HL*1.6*109
 ;L -^HLCS(870,HLDP,0)
 Q
 ;
MON(Y) ;Display current state & check for shutdown
 ;don't display for multiple server
 Q:$G(HLLSTN)
 ; HL*1.6*122 remove unnecessary locks
 ;F  L +^HLCS(870,HLDP,0):2 Q:$T
 S $P(^HLCS(870,HLDP,0),U,5)=Y
 ;L -^HLCS(870,HLDP,0)
 Q:'$D(HLTRACE)
 N X U IO(0)
 W !,"IN State: ",Y
 I '$$STOP D
 . ; patch HL*1.6*122
 . ; R !,"Type Q to Quit: ",X#1:1
 . R !,"Type Q to Quit: ",X:1
 . ; I $L(X),"Qq"[X S $P(^HLCS(870,HLDP,0),U,15)=1
 . I $L(X),"Qq"[$E(X) S $P(^HLCS(870,HLDP,0),U,15)=1
 . ; patch HL*1.6*122 end
 U IO
 Q
UPDT(Y) ;update job count for multiple servers,X=1 increment
 N HLJ,X
 ;
 ; HL*1.6*122 start
 ; F  L +^HLCS(870,HLDP,0):2 Q:$T
 Q:'$G(HLDP)
 Q:'$D(^HLCS(870,"E","M",HLDP))
 F  L +^HLCS(870,HLDP,0):10 Q:$T  H 1
 ; S X=+$P(^HLCS(870,HLDP,0),U,5),$P(^(0),U,5)=$S(Y:X+1,1:X-1)_" server"
 S X=+$P(^HLCS(870,HLDP,0),U,5)
 I X<0 S X=0
 S $P(^HLCS(870,HLDP,0),U,5)=$S(Y:(X+1),X<1:0,1:X-1)_" server"
 ;if incrementing, set the Device Type field to Multi-Server
 ; I X S HLJ(870,HLDP_",",3)="MS" D FILE^HLDIE("","HLJ","","UPDT","HLCSTCP")
 I $P(^HLCS(870,HLDP,0),"^",4)']"" S $P(^HLCS(870,HLDP,0),"^",4)="MS"
 ; HL*1.6*122 end
 ;
 L -^HLCS(870,HLDP,0)
 Q
STOP() ;stop flag set
 N X
 F  L +^HLCS(870,HLDP,0):2 Q:$T
 S X=+$P(^HLCS(870,HLDP,0),U,15)
 L -^HLCS(870,HLDP,0)
 Q X
 ;
LLCNT(DP,Y,Z) ;update Logical Link counters
 ;DP=ien of Logical Link in file 870
 ;Y: 1=msg rec, 2=msg proc, 3=msg to send, 4=msg sent
 ;Z: ""=add to counter, 1=subtract from counter
 Q:'$D(^HLCS(870,+$G(DP),0))!('$G(Y))
 N P,X
 S P=$S(Y<3:"IN",1:"OUT")_" QUEUE "_$S(Y#2:"BACK",1:"FRONT")_" POINTER"
 ; patch HL*1.6*122 start
 ; F  L +^HLCS(870,DP,P):2 Q:$T
 ; S X=+$G(^HLCS(870,DP,P)),^(P)=X+$S($G(Z):-1,1:1)
 I '$L($G(OS)) N OS S OS=$G(^%ZOSF("OS"))
 I OS'["DSM",OS'["OpenM" D
 . F  L +^HLCS(870,DP,P):10 Q:$T  H 1
 . S X=+$G(^HLCS(870,DP,P)),^(P)=X+$S($G(Z):-1,1:1)
 . L -^HLCS(870,DP,P)
 E  D
 . S X=$I(^HLCS(870,DP,P),$S($G(Z):-1,1:1))
 ; L -^HLCS(870,DP,P)
 ; patch HL*1.6*122 end
 Q
SDFLD ; set Shutdown? field to yes
 Q:'$G(HLDP)
 ; HL*1.6*122 remove unnecessary lock and call to FM
 S $P(^HLCS(870,HLDP,0),U,15)=1
 ;N HLJ,X
 ;F  L +^HLCS(870,HLDP,0):2 Q:$T
 ;14=Shutdown LLP?
 ;S HLJ(870,HLDP_",",14)=1
 ;D FILE^HLDIE("","HLJ","","SDFLD","HLCSTCP") ;HL*1.6*109
 ;L -^HLCS(870,HLDP,0)
 Q
 ;
EXITS(Y) ; shutdown and clean up the listener process for either
 ; single-threaded or multi-threaded
 N HLJ,X
 F  L +^HLCS(870,HLDP,0):2 Q:$T
 ;4=status,10=Time Stopped,9=Time Started,11=Task Number
 S X="HLJ(870,"""_HLDP_","")"
 S @X@(4)=Y,@X@(11)="@"
 S:$G(HLCSOUT)'=2 @X@(10)=$$NOW^XLFDT,@X@(9)="@"
 D FILE^HLDIE("","HLJ","","EXITS","HLCSTCP") ; HL*1.6*109
 L -^HLCS(870,HLDP,0)
 I $D(ZTQUEUED) S ZTREQ="@"
 ; HL*1.6*122
 L -^HLCS("HLTCPLINK",HLDP)
 Q
 ;
EXITM ;Multiple service shutdown and clean up
 ; shutdown and clean up a connection spawned by the listener
 ; process for a multi-threaded listener
 D UPDT(0)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
