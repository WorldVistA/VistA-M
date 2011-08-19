XUTMHR ;ISF/RWF - Taskman Hourly checkup routine. ;10/20/10  17:13
 ;;8.0;KERNEL;**446,534,554**;Jul 10, 1995;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
HOUR ;Work to do each hour
 D SCAN ;Look for scheduled task that have dropped there schedule.
 D DEVREJ() ;Check for tasks re-scheduled for unavailable device.
 Q
 ;
SCAN ;Scan the Scheduled Tasks file.  Merge with XUTMCS sometime.
 N D0,OLD,NOW,X,X1,X2,Z0,Z4,Z5,TK
 ;Make NOW 10 minute in the past
 S U="^",D0=0,NOW=$$HTFM^XLFDT($$HADD^XLFDT($H,,,-10)),OLD=$$HTFM^XLFDT($H-1)
 F  S D0=$O(^DIC(19.2,D0)) Q:'D0  D  L -^DIC(19.2,D0)
 . L +^DIC(19.2,D0):2 I '$T Q
 . S X=$G(^DIC(19.2,D0,0)),X1=+$G(^(1)) ;X1 is the task #.
 . ;Check that the Option still exists.
 . I '($D(^DIC(19,+X,0))#2) D REMOVE(D0) Q
 . I $P(X,U,2)="" Q  ;No Scheduled time.
 . ;Lock the Task
 . L +^%ZTSK(X1):5 I $T D  L -^%ZTSK(X1)
 . . ;I $P(X,U,9)["S" Q  ;Start-up.
 . . I $P(X,U,2)>NOW,$D(^%ZTSK(X1)) Q  ;Scheduled for future
 . . ;ToDo Check if Device OK.
 . . I X1,'$D(^%ZTSK(X1)) D FIX(D0,X) Q  ;%ZTSK entry missing
 . . S TK=$G(^%ZTSK(X1,0))
 . . I $P(X,U,2)>OLD,$L($P(X,U,6)) D FIX(D0,X,$P(TK,U,3)) Q  ;
 . . Q
 . Q
 S ZTREQ="@"
 Q
 ;
FIX(DA,X,USER) ;Reschedule
 N FDA,IEN,Y,DUZ
 S Y=$$APFIND^XUSAP("TASKMAN,PROXY USER")
 S DUZ=$S($G(USER):USER,Y>0:Y,1:.5)
 S Y=$$SCH^XLFDT($P(X,U,6),$P(X,U,2),1),IEN=DA_"," Q:'Y
 S FDA(19.2,IEN,2)=Y
 D FILE^DIE("K","FDA")
 Q
 ;
REMOVE(DA) ;Remove if pointed to option is missing
 N DIK
 S DIK="^DIC(19.2," D ^DIK
 Q
 ;
DEVREJ(SKIP) ;Rejected Device cleanup
 N ZTSK,ZTDTH,CNT,VOL,Y,TRY,X,Z,XMB,XMY
 D GETENV^%ZOSV S VOL=$P(Y,U,2),Y=$O(^%ZIS(14.5,"B",VOL,0)) Q:'Y
 S TRY=$P(^%ZIS(14.5,Y,0),U,12),SKIP=$G(SKIP) Q:'TRY
 S ZTDTH=0
 F  S ZTDTH=$O(^%ZTSCH(ZTDTH)),ZTSK=0 Q:'ZTDTH  F  S ZTSK=$O(^%ZTSCH(ZTDTH,ZTSK)) Q:'ZTSK  D
 . L +^%ZTSK(ZTSK):5 Q:'$T  D  ;Catch next time. p554
 . . Q:'$D(^%ZTSK(ZTSK,0))
 . . S Z=^%ZTSK(ZTSK,0),Y=$G(^%ZTSK(ZTSK,.2)),X=$P(Y,U,8)
 . . I X>TRY D UNSCH(ZTSK,$P(Z,U,3),$S($L($P(Y,U,6)):$P(Y,U,6),1:$P(Y,U)),SKIP)
 . . Q
 . L -^%ZTSK(ZTSK)
 . Q
 Q
 ;
UNSCH(ZTSK,DZ,DEV,SKIP) ;Unschedule Task and send alert
 N XQA,XQAMSG,XQADATA,XQAROU
 D DQ^%ZTLOAD
 S XQA(DZ)="",XQAMSG="Your task #"_ZTSK_" was unscheduled, because it could not get device "_DEV,XQADATA=ZTSK,XQAROU="XQA^XUTMUTL"
 I 'SKIP D SETUP^XQALERT Q
 W !,XQAMSG
 Q
 ;
EN(ZTQPARAM) ;So can job it to run.
 ;
SNAP ;Snapshot ZTMON data into the TASKMAN SNAPSHOT file.
 S U="^"
 N %,FDA,I2,I3,IEN,NOWH3,R2,R3,SI,X,ZT1,ZT2,ZT3,ZT4,ZT5,ZTC,ZTC2,ZTQ1,ZTQ2
 S ZTQPARAM=$G(ZTQPARAM,"60,60") ;Default run for 60 minutes, snap every minute
 S ZTQ1=+ZTQPARAM*60 ;Convert minutes to seconds.
 S:ZTQ1>480 ZTQ1=480 ;Max 8 hours
 S ZTQ2=+$P(ZTQPARAM,",",2)
 S ZTQ2=$S(ZTQ2<2:2,ZTQ2>ZTQ1:ZTQ1,1:ZTQ2) ;See in bounds
 ;
 F  D SN2 S ZTQ1=ZTQ1-ZTQ2 Q:'ZTQ1  H ZTQ2
 Q
 ;
SN2 ;Do the snapshot
 K IEN,FDA,%,R2,R3,SI,I2,I3
 S IEN="+1,",NOWH3=$$H3^%ZTM($H)
 S FDA(14.72,IEN,.01)=$$NOW^XLFDT
 S FDA(14.72,IEN,2)=$$TM^ZTLOAD
 S ZT1="",ZT2=0,SI=101,R2=14.72101
 ;Get the Manager status data
 F  S ZT1=$O(^%ZTSCH("STATUS",ZT1)) Q:ZT1=""  S X=^(ZT1) D
 . S ZT2=ZT2+1,I2="+"_SI_","_IEN,SI=SI+1
 . S FDA(R2,I2,.01)=ZT1,FDA(R2,I2,2)=$P(X,U),FDA(R2,I2,3)=$P(X,U,2)
 . S FDA(R2,I2,4)=$P(X,U,3),FDA(R2,I2,5)=$P(X,U,4)
 . Q
 S FDA(14.72,IEN,3)=ZT2
 ;Check and get the LOAD Balance data
 S %=$G(^%ZTSCH("LOAD")),FDA(14.72,IEN,4)=$P(%,U),FDA(14.72,IEN,5)=$P(%,U,2)
 ;S ZT1=$O(^%ZTSCH(1)),FDA(14.72,IEN,8)=$$LATE(ZT1,NOWH3)
 S ZT1=1,ZT2=0,ZT3=0,ZTC=0,ZTC2=0,ZT5=0
 ;Look at the task schedule list
 ;ZT3 late amount, ZT5 is current time late, ZTC2 is count of late tasks.
 F  S ZT1=$O(^%ZTSCH(ZT1)),ZT2=0 Q:'ZT1  S ZT5=$$LATE(ZT1,NOWH3) S:'ZT3 ZT3=ZT5 D
 . F  S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:'ZT2  S ZTC=ZTC+1 S:ZT5 ZTC2=ZTC2+1
 S FDA(14.72,IEN,7)=ZTC,FDA(14.72,IEN,8)=ZT3,FDA(14.72,IEN,9)=ZTC2
 ;Look at the IO list
 S ZT1="",ZTC=0
 F  S ZT1=$O(^%ZTSCH("IO",ZT1)) Q:ZT1=""  S:$O(^%ZTSCH("IO",ZT1,0)) ZTC=ZTC+1
 S FDA(14.72,IEN,10)=ZTC
 S ZT1="",ZT2=0,ZT3=0,ZT4=0,ZTC=0
 F  S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2=0 Q:'ZT1  F  S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3=0 Q:'ZT2  S:'ZT4 ZT4=ZT2 F  S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTC=ZTC+1
 S FDA(14.72,IEN,11)=ZTC,FDA(14.72,IEN,12)=ZT4
 ;Look at the JOB list
 S ZT1=0,ZT2=0,ZT3=0,ZTC=0
 F  S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2=0 Q:'ZT1  F  S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:'ZT2  S ZTC=ZTC+1
 ;Look at the C list
 S ZT1="",ZT2=0,ZT3=0
 F  S ZT1=$O(^%ZTSCH("C",ZT1)),ZT2=0 Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("C",ZT1,ZT2)),ZT3=0 Q:ZT2=""  F  S ZT3=$O(^%ZTSCH("C",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTC=ZTC+1
 S FDA(14.72,IEN,15)=ZTC
 S FDA(14.72,IEN,16)=$$LATE($O(^%ZTSCH("JOB",1)),NOWH3)
 ;Look at the running Task list
 S ZT1=0,ZT2=0,ZT3=0,ZTC=0
 F  S ZT1=$O(^%ZTSCH("TASK",ZT1)) Q:'ZT1  S ZTC=ZTC+1
 S FDA(14.72,IEN,20)=ZTC
 ;Look at the SUB-Managers
 S ZT1=0,ZT2=0,ZT3=0,ZTC=0,R3=14.72201,SI=201
 F  S ZT1=$O(^%ZTSCH("SUB",ZT1)),ZT2=0 Q:'$L(ZT1)  F  S ZT2=$O(^%ZTSCH("SUB",ZT1,ZT2)) Q:'ZT2  S X=^(ZT2) D
 . S ZTC=ZTC+1,I3="+"_SI_","_IEN,SI=SI+1
 . S FDA(R3,I3,.01)=ZT2,FDA(R3,I3,2)=$P(X,U),FDA(R3,I3,3)=$P(X,U,2),FDA(R3,I3,4)=$P(X,U,3),FDA(R3,I3,5)=ZT1
 . Q
 S FDA(14.72,IEN,19)=ZTC
 S FDA(14.72,IEN,22)=$$ACTJ^%ZOSV() ;Total jobs
 ;Now save the data.
 L +^%ZIS(14.72,0):10 D UPDATE^DIE("S","FDA") L -^%ZIS(14.72,0)
 I $D(^TMP("DIERR",$J)) D ^%ZTER
 Q
 ;
LATE(T1,NOW) ;Return if a H3 time is Late
 S:T1["," T1=$$H3^%ZTM(T1)
 Q $S(T1<1:0,T1<NOW:NOW-T1,1:0)
