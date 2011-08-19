HLCSLM ;SFCIOFO/AC - HL7 LINK MANAGER ;03/19/2008  10:01
 ;;1.6;HEALTH LEVEL SEVEN;**49,57,109,123,140**;Oct 13, 1995;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;Entry point for start up task
 N %,HLEVLCHK,HLTSKCNT
 F %=1:1:10 L +^HLCS("HLCSLM"):2 Q:$T
 E  Q
 I $G(ZTQUEUED) S Y=$$PSET^%ZTLOAD(ZTQUEUED)
 D INIT,SAVDOLRH
 D SETNM^%ZOSV($E("HLmgr:"_$G(ZTQUEUED),1,15))
 ;
LOOP ;
 D CHKQUE
 I $$CKLMSTOP G EXIT
 D SAVDOLRH
 D CHECKMST^HLEVMST ;HL*1.6*109 - Make sure event monitor current
 ; patch HL*1.6*140
 ; H 10
 H 5
 G LOOP
 ;
EXIT N HLJ,X
 S X=1
 F  L +^HLCS(869.3,X,5):2 Q:$T
 ;52=Link Manager task number
 S HLJ(869.3,X_",",52)="@"
 D FILE^HLDIE("","HLJ","","EXIT","HLCSLM") ;HL*1.6*109
 L -^HLCS(869.3,X,5)
 L -^HLCS("HLCSLM")
 Q
 ;
SAVDOLRH ;Save Last Known $H
 N HLJ,X
 S X=1
 F  L +^HLCS(869.3,X,5):2 Q:$T
 ;54=LM LAST KNOWN $H
 S HLJ(869.3,X_",",54)=$H
 D FILE^HLDIE("","HLJ","","SAVDOLRH","HLCSLM") ;HL*1.6*109
 L -^HLCS(869.3,X,5)
 Q
 ;
CHKQUE ;Check queues for messages to send
 ;HLTSKCNT(logical link)=task #^$H
 N HLDA,HLDP,HLMSG,HLTSK,Y
 S (HLDA,HLMSG)=""
 F HLDP=0:0 S HLDP=+$O(^HLMA("AC","O",HLDP)) Q:HLDP'>0  S HLMSG=+$O(^(HLDP,0)) I HLMSG D  L -^HLCS("HLCSLSM",HLDP)
 .;quit if persistent link
 .Q:$P($G(^HLCS(870,HLDP,400)),U,4)="Y"
 .L +^HLCS("HLCSLSM",HLDP):0 E  K HLTSKCNT(HLDP) Q
 .Q:'$$LLOK(+HLDP)
 .;get tasknumber from file 870 and HLTSKCNT array
 .S Y=$$TASKNUM(HLDP),HLTSK=$G(HLTSKCNT(HLDP))
 . ;
 . ;patch HL*1.6*123 start
 . S HLDP("TASK-ACTIVE")=0
 . ;
 . I Y D
 .. N ZTSK
 .. S ZTSK=Y
 .. ; Check status of task
 .. D STAT^%ZTLOAD
 .. I "12"[ZTSK(1) S HLDP("TASK-ACTIVE")=1
 . Q:HLDP("TASK-ACTIVE")
 . ;
 . I HLTSK D
 .. N ZTSK
 .. S ZTSK=+HLTSK
 .. ; Check status of task
 .. D STAT^%ZTLOAD
 .. I "12"[ZTSK(1) S HLDP("TASK-ACTIVE")=1
 . Q:HLDP("TASK-ACTIVE")
 . ;
 . ;no tasknumber, link not running nor queued, task it
 . I 'HLTSK!'Y D TASKLSUB(HLDP),SAVTSK(HLDP) Q
 ; comment out the following lines
 ; .;link was tasked, check time
 ; .S Y=$P(HLTSK,U,2)
 ; .;check that time task is less than 30 minutes
 ; .Q:$$HDIFF^XLFDT($H,Y,2)<1800
 ; .;shutdown and send alert
 ; .D SDFLD^HLCSTCP,EXITS^HLCSTCP("Shutdown"),SNDALERT
 ; loop through links that have been tasked
 ; F HLDP=0:0 S HLDP=$O(HLTSKCNT(HLDP)) Q:HLDP'>0  K:'$D(^HLMA("AC","O",HLDP)) HLTSKCNT(HLDP)
 F HLDP=0:0 S HLDP=$O(HLTSKCNT(HLDP)) Q:HLDP'>0  D
 . N ZTSK
 . S ZTSK=+HLTSKCNT(HLDP)
 . ; Check status of task
 . D STAT^%ZTLOAD
 . ; kill HLTSKCNT(HLDP) if process is not active
 . I "12"'[ZTSK(1) K HLTSKCNT(HLDP)
 ; patch HL*1.6*123 end
 Q
 ;
INIT ;Create Task number and clear Stop flag.
 N HLJ,X
 S X=1
 F  L +^HLCS(869.3,X,5):2 Q:$T
 ;52=Link Manager task number,53=Stop Link Manager
 S HLJ(869.3,X_",",52)=$G(ZTQUEUED)
 S HLJ(869.3,X_",",53)="@"
 D FILE^HLDIE("","HLJ","","INIT","HLCSLM") ;HL*1.6*109
 L -^HLCS(869.3,X,5)
 Q
TASKNUM(X) ;Look-up task number
 N %,DA,Y
 S DA=X
 ;
 ;**109**
 ;F  L +^HLCS(870,+DA,0):2 Q:$T
 ;
 S Y=$$GET1^DIQ(870,DA_",",11)
 ;
 ;**109
 ;L -^HLCS(870,+DA,0)
 ;
 Q Y
STATUS(X) ;Status of task
 N Y,ZTSK
 S ZTSK=X
 D STAT^%ZTLOAD
 S Y=ZTSK(1)
 Q Y
 ;
LLOK(X) ;Function to check whether LL ok.
 ;return value 1 = ok, 0 = not ok.
 Q:'$G(X)
 N HLDP,HLDP0,HLPARM4,HLTYPTR
 S HLDP=+X,HLDP0=$G(^HLCS(870,HLDP,0)),HLPARM4=$G(^(400)) Q:HLDP0="" 0
 ;must be a client
 Q:$P(HLPARM4,U,3)'="C" 0
 ;
 ; patch HL*1.6*123
 ;shutdown LLP must be 0
 ; Q:$P(HLDP0,U,15)'=0 0
 ; change to 1, in case the data is empty
 Q:$P(HLDP0,U,15)=1 0
 ;
 ;must have LLP Type of TCP
 S HLTYPTR=+$P(HLDP0,U,3) Q:$P($G(^HLCS(869.1,HLTYPTR,0)),U)'="TCP" 0
 Q 1
 ;
SAVTSK(X) ;
 N HLDP,HLJ
 S HLDP=X
 ;
 ;**109**
 F  L +^HLCS(870,HLDP,0):2 Q:$T
 ;
 ;4=status,10=Time Stopped,9=Time Started,11=Task Number,3=Online ?
 S X=$NA(HLJ(870,HLDP_",")),@X@(11)=$G(ZTSK)
 ;S HLJ(870,HLDP_",",11)=$G(ZTSK)
 D FILE^HLDIE("","HLJ","","SAVTSK","HLCSLM") ; HL*1.6*109
 S HLTSKCNT(HLDP)=$G(ZTSK)_"^"_$H
 ;
 ;**109**
 L -^HLCS(870,HLDP,0)
 ;
 Q
 ;
STRTSTOP ;ENTRY POINT TO START/STOP TCP LINK MANAGER
 N DIR,DIRUT,Y
 L +^HLCS("HLCSLM"):3 E  D  Q
 .W !,*7,"Link Manager already running!"
 .W ! S DIR(0)="YO",DIR("A")="Would you like to stop the Link Manager now",DIR("B")="NO" D ^DIR K DIR
 .I $D(DIRUT)!'Y Q
 .D STOPLM
 W !,*7,"Link Manager is NOT currently running!"
 W ! S DIR(0)="YO",DIR("A")="Would you like to start the Link Manager now",DIR("B")="YES" D ^DIR K DIR
 I '$D(DIRUT)&Y D TASKLM
 L -^HLCS("HLCSLM")
 Q
 ;
STOPLM ;ENTRY POINT TO STOP LINK MANAGER
 N DIC,X,Y,DTOUT,DUOUT,DLAYGO,DIE,DA,DR
 S DIC="^HLCS(869.3,"
 S X=1
 D ^DIC
 S DA=+Y,DIE=DIC
 S DR="53////1"
 D ^DIE
 W !,"Link Manager has been asked to stop"
 Q
STAT() ;Status of LINK MANAGER--up, down or unable to determine.
 N %,DA,X,Y
 S DA=1
 S X=$$GET1^DIQ(869.3,DA_",",52)
 Q:X']"" 0
 S X=$$GET1^DIQ(869.3,DA_",",54)
 Q:X']"" 0
 I $$HDIFF^XLFDT($H,X,2)>500 Q 0
 Q 1
 ;
TASKLSUB(X) ;Task LINK SUB-MANAGER.
 ;This may be a place to log the time which the LINK SUBMANAGER is tasked.
 N HLDP,HLDP0,HLDAPP,HLTYPTR,HLBGR,HLENV,HLPARM,HLPARM4,HLQUIT,ZTRTN,ZTDESC,ZTCPU,ZTSAVE
 ;ZTSK is not Newed here because it will be needed by SAVTSK.
 S HLDP=X,HLDP0=$G(^HLCS(870,HLDP,0)),HLPARM4=$G(^(400))
 ; Q:"N"'[$P(HLPARM4,U,4)  ; patch HL*1.6*123: comment out
 ;quit if no LLP TYPE
 S HLDAPP=$P(HLDP0,U),HLTYPTR=$P(HLDP0,U,3) Q:'HLTYPTR
 S HLBGR=$G(^HLCS(869.1,HLTYPTR,100)),HLENV=$G(^(200))
 I HLENV'="" K HLQUIT X HLENV Q:$D(HLQUIT)
 S ZTRTN="^HLCSLSM",HLBGR=$P(HLBGR," ",2)
 S ZTDESC=HLDAPP_" Low Level Protocol",ZTSAVE("HLDP")="",ZTSAVE("HLBGR")=""
 S ZTIO="",ZTDTH=$H
 ;get startup node
 I $P(HLPARM4,U,6),$D(^%ZIS(14.7,+$P(HLPARM4,U,6),0)) S ZTCPU=$P(^(0),U)
 D ^%ZTLOAD
 D MON^HLCSTCP("Tasked") ;HL*1.6*123
 Q
 ;
TASKLM ;Task Link Manager
 ;Declare variables
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK,TMP
 S ZTIO=""
 S ZTDTH=$H
 ;Task Link Manager
 S ZTRTN="EN^HLCSLM"
 S ZTDESC="HL7 Link Manager"
 ;Call TaskMan
 D ^%ZTLOAD
 I $G(ZTSK) W !,"Link Manager queued as task number ",ZTSK
 E  W $C(7),!!,"Unable to start/restart Link Manager"
 Q
 ;
CKLMSTOP() ;Check whether Link Manager should stop
 N PTRMAIN,NODE5,STOP
 S PTRMAIN=+$O(^HLCS(869.3,0))
 L +^HLCS(869.3,PTRMAIN,5):1
 I $T L -^HLCS(869.3,PTRMAIN,5)
 S NODE5=$G(^HLCS(869.3,PTRMAIN,5))
 S STOP=+$P(NODE5,"^",3)
 Q:STOP STOP
 S STOP=$$S^%ZTLOAD
 Q STOP
 ;
SNDALERT ;Send Alert
 N XQA,XQAMSG,XQAOPT,XQAROU,XQAID,Z
 S Z=$P($$PARAM^HLCS2,U,8) Q:Z=""
 S XQA("G."_Z)="",XQAMSG="HL7 Logical Link "_$P(^HLCS(870,HLDP,0),U)_" shutdown due to TaskMan unable to process task request"
 D SETUP^XQALERT
 Q
