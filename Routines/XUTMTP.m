XUTMTP ;SEA/RDS - TaskMan: ToolKit, Print, Part 1 ;04/18/2006  16:19
 ;;8.0;KERNEL;**20,86,169,242,381**;Jul 10, 1995;Build 2
 ;
EN(XUTSK,XUINX,FLAG) ;Print one task
 I $D(XUTMUCI)_$D(ZTNAME)_$D(ZTFLAG)'="111" D ENV^XUTMUTL
TASK ;Lookup Task File Data
 N %,%D,%H,%M,%Y,%ZTT,X,Y,ZT,ZT1,ZT2,ZT3,ZTC,ZTD,ZTF,ZTI,ZTO
 S FLAG=+$G(FLAG),ZTC=0
 L +^%ZTSK(XUTSK):2 I '$T W !,"Task: ",XUTSK," entry locked." Q
 ;Get current data
 S XUTSK(0)=$G(^%ZTSK(XUTSK,0)),XUTSK(.03)=$G(^(.03)),XUTSK(.1)=$G(^(.1)),XUTSK(.2)=$G(^(.2)),XUTSK(.11)=$G(^(.11)),XUTSK(.26)=$G(^(.26))
 I '$D(^%ZTSK(XUTSK)) D  I 'XUTSK L -^%ZTSK(XUTSK) K XUTMT Q
 . S X=$G(^%ZTSCH("TASK",XUTSK))
 . I X="" W !,XUTSK,":  No information available." S XUTSK=0 Q
 . S XUTSK(0)=$P(X,U,1,2)_"^^"_$P(X,U,7,8)_U_$P(X,U,5)_"^^"_$P(X,U,3,4)_U_$P(X,U,9),XUTSK(.1)="5^"_$P(X,U,12),XUTSK(.2)=$P(X,U,6),XUTSK("TASK")=X
 . S XUTSK(.03)="Task in running list, full information missing."
 . Q
 ;
SCHED ;Lookup Task In Schedule File
 S ZT1=0 F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  I $D(^%ZTSCH(ZT1,XUTSK))#2 S XUTSK("A",ZT1,XUTSK)="",ZT2=^(XUTSK) I ZT2]"" S $P(XUTSK(.2),U)=ZT2
 I XUTSK(.26)="" S ZT1="" F  S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:ZT2=""  S:$D(^(ZT2,XUTSK))#2 XUTSK("IO",ZT1,ZT2,XUTSK)=""
 S ZT1="" F  S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  S:$D(^(ZT1,XUTSK))#2 XUTSK("JOB",ZT1,XUTSK)=""
 S ZT1="" F  S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:ZT2=""  S:$D(^(ZT2,XUTSK))#2 XUTSK("LINK",ZT1,ZT2,XUTSK)=""
 S:$D(^%ZTSCH("TASK",XUTSK))#2 XUTSK("TASK")=^(XUTSK) S:$D(^%ZTSCH("TASK",XUTSK,1)) XUTSK("TASK1")=^(1)
 L -^%ZTSK(XUTSK)
 ;
SCREEN ;Apply Screen, If Supplied
 I $D(XUTMT("S"))#2 X XUTMT("S") E  K XUTMT Q
 ;
 S ZT1=$G(^%ZTSK(XUTSK,.3,"XQSCH")) I ZT1 D  ;Is it a scheduled task
 . S ZT2=+$G(^DIC(19.2,ZT1,1.1)) Q:'ZT2
 . S ZT2=$P($G(^VA(200,ZT2,0),"Unk"),"^") D ADD("Run under user: "_ZT2)
 . Q
STATUS ;Determine Status According To Lookup Data
 S XUTSK("CS")="",XUTSK("UPDATE")=$$TIME($P(XUTSK(.1),U,2))
 I $D(XUTSK("A")) S ZT1="" F ZT=0:0 S ZT1=$O(XUTSK("A",ZT1)) Q:ZT1=""  D ADD("Scheduled for "_$$TIME(ZT1),1)
 I XUTSK(.26)]"" D ADD("Waiting for hunt group"_$S(XUTSK(.26)[",":"s ",1:" ")_XUTSK(.26),"A")
 I XUTSK(.26)="",$D(XUTSK("IO")) S ZT1="" F ZT=0:0 S ZT1=$O(XUTSK("IO",ZT1)) Q:ZT1=""  D ADD("Waiting for device "_ZT1,"A"),IOQ:FLAG
 I $D(XUTSK("JOB")) D ADD("Waiting for a partition.",3),JL:FLAG
 I $D(XUTSK("LINK")) S ZT1="" F ZT=0:0 S ZT1=$O(XUTSK("LINK",ZT1)) Q:ZT1=""  D ADD("Waiting for the link to "_ZT1_" to be restored.","G"),LL:FLAG
 I $D(XUTSK("TASK")) D ADD("Started running "_XUTSK("UPDATE")_".",5)
 I $E(XUTSK(.1),1)]"",$E(XUTSK(.1),1)'=XUTSK("CS") D STATUS^XUTMTP0 S ZTC=ZTC+1
 ;
PRINT ;Go To XUTMTP1 To Print Task And Quit
 G ^XUTMTP1
 ;
TIME(%ZTT) ;Convert $H Time To A Readable Time
 Q:%ZTT="" "??"
 N %,%XT,%XD,%H,Y I %ZTT>99999 S %XD=(%ZTT\86400),%XT=%ZTT#86400
 E  S %XD=+%ZTT,%XT=$P(%ZTT,",",2)
 S %H=$H,%=%XD-%H I %*%<2 S Y=$S(%<0:"Yesterday",'%:"Today",%>0:"Tomorrow",1:"")
 I %*%>1 S Y=$$HTE^XLFDT(%XD_","_%XT,"5D") ;D 7^%DTC S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S Y=Y_" at "_(%XT\3600)_":"_$E(%XT#3600\60+100,2,3)
 Q Y
 ;
ADD(MSG,FLG) ;Add msg to list
 S XUTSK(.15,ZTC)=MSG,ZTC=ZTC+1 S:$D(FLG) XUTSK("CS")=FLG
 Q
A ;STATUS--determine position of late task in Schedule List
 N ZTP
 Q
 ;
IOQ ;STATUS--determine position in Device Waiting List
 N ZTP
 S ZTP=0,ZT2="" F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTP=ZTP+1 I ZT3=ZTSK G I1
I1 D ADD("     "_(ZTP-1)_" task"_$S(ZTP=2:"",1:"s")_" ahead of this one.")
 Q
 ;
JL ;STATUS--determine position in Job List
 N ZTP
 S ZTP=0,ZT1=""
 F  S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:ZT2=""  S ZTP=ZTP+1 I ZT2=ZTSK G J1
J1 D ADD("     "_(ZTP-1)_" task"_$S(ZTP=2:"",1:"s")_" ahead of this one.")
 Q
 ;
LL ;STATUS--determine position in Link Waiting List
 N ZTP
 S ZTP=0,ZT2=""
 F  S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)),ZT3="" Q:ZT2=""  F  S ZT3=$O(^%ZTSCH("LINK",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTP=ZTP+1 I ZT3=ZTSK G L1
L1 D ADD("    "_(ZTP-1)_" task"_$S(ZTP=2:"",1:"s")_" ahead of this one.")
 Q
 ;
TASKUSER(TSK) ;Return the user name for a task
 N S1,S2,S3
 S S1=$G(^%ZTSK(+TSK,0)) I '$L(S1) Q "Unknown"
 S S1=+$P(S1,U,3)
 S S2=$G(^VA(200,S1,0)) I '$L(S2) Q "Unknown"
 S S3=$$ACTIVE^XUSER(S1)
 Q $S(S3:$P(S2,U),1:$E($P(S2,U),1,25)_" (T)")
