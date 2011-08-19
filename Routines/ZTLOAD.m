%ZTLOAD ;ISF/RDS,RWF - TaskMan: Programmer Interface: Entry Points ;07/26/2006
 ;;8.0;KERNEL;**67,118,127,339,381**;JUL 10, 1995;Build 2
 ;
QUEUE ;queue a task (create, schedule) (Entry Point = ^%ZTLOAD)
 G ^%ZTLOAD1
 ;
S(MSG) ;Entry Point: extrinsic variable returns boolean: should task stop?
 I $G(ZTQUEUED)>.5,$D(^%ZTSCH("TASK",ZTQUEUED)) S ^%ZTSCH("TASK",ZTQUEUED,1)=$H
 I $D(MSG),$G(ZTQUEUED)>.5 S ^%ZTSK(ZTQUEUED,.11)=MSG
 N ZTSTOP S ZTSTOP=0
 I $G(ZTQUEUED)>.5,$L($P($G(^%ZTSK(ZTQUEUED,.1)),"^",10)) S ZTSTOP=1
 Q ZTSTOP
 ;
TM() ;Entry Point: extrinsic variable returns boolean: is TM running?
 N ZTH,ZTR S ZTH=$H,ZTR=$G(^%ZTSCH("RUN"))
 Q ZTH-ZTR*86400+$P(ZTH,",",2)-$P(ZTR,",",2)<500
 ;
REQ ;Entry Point: requeue a task (edit, reschedule)
 G ^%ZTLOAD3
 ;
KILL ;Entry Point: delete a task
 S ZTSK=$G(ZTSK)
 K ZTSK(0) S ZTSK(0)=0
 I ZTSK>1,$D(^%ZTSK(ZTSK)) D  L -^%ZTSK(ZTSK) ;could be done!
 . L +^%ZTSK(ZTSK):20 Q:'$T
 . ;Don't kill running persistent tasks.
 . I $D(^%ZTSCH("ZTSK",ZTSK,"P")) Q
 . K ^%ZTSK(ZTSK) S ZTSK(0)=1
 Q
 ;
ISQED ;Entry Point: return whether task is pending (scheduled or waiting)
 G ^%ZTLOAD4
 ;
STAT ;Entry Point: return status of a task
 G ^%ZTLOAD5
 ;
DQ ;Entry Point: dequeue a task (unschedule)
 G ^%ZTLOAD6
 ;
DESC(DESC,LST) ;Find tasks with description
 G DESC^%ZTLOAD5
 ;
RTN(RTN,LST) ;Find tasks that call this routine
 G RTN^%ZTLOAD5
 ;
OPTION(OPNM,LST) ;Find tasks for this OPTION.
 G OPTION^%ZTLOAD5
 ;
JOB(ZTM) ;Return the job # for a running task
 G JOB^%ZTLOAD5
 ;
ZTSAVE(%,%1) ;input variables in string delimited by ; to build ZTSAVE array
 N %2 K:$G(%1) ZTSAVE
 F %1=1:1 S %2=$P(%,";",%1) Q:%2=""  S ZTSAVE(%2)=""
 Q
 ;
PSET(ZTM) ;e.f. Set the persistents node
 D TN Q:'$D(^%ZTSCH("TASK",ZTM)) 0
 S ^%ZTSCH("TASK",ZTM,"P")=""
 Q 1
 ;
PCLEAR(ZTM) ;Clear the persistents node
 D TN Q:'$D(^%ZTSCH("TASK",ZTM))
 K ^%ZTSCH("TASK",ZTM,"P")
 Q
 ;
ASKSTOP(ZTSK) ;E.F. Ask a task to stop.
 G ASKSTOP^%ZTLOAD2
 Q
 ;
TN S ZTM=$S($G(ZTM)>0:ZTM,$G(ZTQUEUED)>.9:ZTQUEUED,$G(ZTSK)>0:ZTSK,1:0)
 Q
