%ZTLOAD5 ;SEA/RDS-TaskMan: P I: Task Status ;1/18/08  14:29
 ;;8.0;KERNEL;**49,339,446**;JUL 10, 1995;Build 35
 ;
INPUT ;check input parameters for error conditions
 N %,ZT1,ZT2,ZT3
 S:$D(ZTSK)[0 ZTSK=""
 I $D(ZTSK)>1 S %=ZTSK K ZTSK S ZTSK=%
 S ZTSK(0)=0,ZTSK(1)=0,ZTSK(2)="Undefined"
 I ZTSK<1!('$D(^%ZTSK(ZTSK,0))) Q
 L +^%ZTSK(ZTSK):5 E  S ZTSK(2)="Busy" Q  ;p446
 D SEARCH L -^%ZTSK(ZTSK)
 Q
 ;
SEARCH ;search ^%ZTSCH for task
 I $D(^%ZTSCH("TASK",ZTSK))#2 D  Q
 . S ZTSK(0)=1,ZTSK(1)=2,ZTSK(2)="Active: Running"
 . ;With a zero lock timeout it may report "active" falsely
 . L +^%ZTSCH("TASK",ZTSK):0 I $T S ZTSK(1)=5,ZTSK(2)="Inactive: Interrupted" L -^%ZTSCH("TASK",ZTSK) ;p446
 . Q
 S ZT1=0 D  Q:ZTSK(0)  ;*339
 . F  S ZT1=$O(^%ZTSCH(ZT1)) Q:ZT1'>0  I $D(^%ZTSCH(ZT1,ZTSK))#2 S ZTSK(0)=1,ZTSK(1)=1,ZTSK(2)="Active: Pending" Q
 S ZT1="" D  Q:ZTSK(0)
 . F  S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  D  Q:ZTSK(0)
 . . F  S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK))#2 S ZTSK(0)=1,ZTSK(1)=1,ZTSK(2)="Active: Pending" Q
 S ZT1="" D  Q:ZTSK(0)
 . F  S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  I $D(^(ZT1,ZTSK))#2 S ZTSK(0)=1,ZTSK(1)=1,ZTSK(2)="Active: Pending" Q
 S ZT1="" D  Q:ZTSK(0)
 . F  S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  D  Q:ZTSK(0)
 . . F  S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK))#2 S ZTSK(0)=1,ZTSK(1)=1,ZTSK(2)="Active: Pending" Q
 S ZT1=0 D  Q:ZTSK(0)  ;*339
 . F  S ZT1=$O(^%ZTSCH("C",ZT1)) Q:ZT1'>0  I $D(^(ZT1,ZTSK)) S ZTSK(0)=1,ZTSK(2)="Active: Pending" Q
 ;
FLAG ;If we didn't find it in a list, use status flag
 I $D(^%ZTSK(ZTSK,.1))[0 Q
 S ZT=$P(^%ZTSK(ZTSK,.1),U),ZTSK(0)=1
 I ZT=2!(ZT=4) S ZTSK(1)=1,ZTSK(2)="Active: Pending" Q
 I ZT=6 S ZTSK(1)=3,ZTSK(2)="Inactive: Finished" Q
 I ZT="H"!(ZT="K") S ZTSK(1)=4,ZTSK(2)="Inactive: Available" Q
 S ZTSK(1)=5,ZTSK(2)="Inactive: Interrupted"
 Q
 ;
DESC ;Find tasks with matching description.
 ;From %ZTLOAD input param DESC,LST
 Q:$G(DESC)=""
 N ZTSK,X D ENV
 S:'$D(LST) LST="^TMP($J)" S ZTSK=0
 F  S ZTSK=$O(^%ZTSK(ZTSK)) Q:ZTSK'>0  S X=$G(^%ZTSK(ZTSK,0)) D
 . Q:$$SKIP()
 . I $G(^%ZTSK(ZTSK,.03))=DESC S @LST@(ZTSK)=""
 . Q
 Q
RTN ;Find tasks with matching routines
 ;From %ZTLOAD input param RTN,LST
 Q:$G(RTN)=""
 N ZTSK,X D ENV
 S:'$D(LST) LST="^TMP($J)" S:RTN'["^" RTN="^"_RTN S ZTSK=0
 F  S ZTSK=$O(^%ZTSK(ZTSK)) Q:ZTSK'>0  S X=$G(^%ZTSK(ZTSK,0)) D
 . Q:$$SKIP()
 . I $P(X,"^",1,2)=RTN S @LST@(ZTSK)="" Q
 . I "^"_($P(X,"^",2))=RTN S @LST@(ZTSK)=""
 . Q
 Q
OPTION ;Find tasks with matching option names
 ;From %ZTLOAD input param OPNM, LST
 Q:$G(OPNM)=""  N ZTSK,X,FLG D ENV
 S:'$D(LST) LST="^TMP($J)" S ZTSK=0,FLG=(OPNM?1.N1"^"1A.ANP)
 Q:'FLG&(OPNM'?1A.ANP)
 F  S ZTSK=$O(^%ZTSK(ZTSK)) Q:ZTSK'>0  S X=$G(^%ZTSK(ZTSK,0)) D
 . Q:$$SKIP()
 . I FLG,$P(X,"^",8,9)=OPNM S @LST@(ZTSK)="" Q
 . I $P(X,"^",1,2)="ZTSK^XQ1",$P(X,"^",9)=OPNM S @LST@(ZTSK)=""
 . Q
 Q
SKIP() ;Screen on ZTKEY, UCI, DUZ, return: 0=OK, 1=Skip
 Q:ZTKEY 0
 Q:($P(X,U,11)_","_$P(X,U,12))'=ZTUCI 1
 Q:$P(X,U,3)'=DUZ 1
 Q 0
ENV ;Setup
 S ZTKEY=$D(^XUSEC("ZTMQ",DUZ)),U="^"
 X ^%ZOSF("UCI") S ZTUCI=Y
 Q
 ;
JOB ;Return JOB # for running task. Called from JOB^ZTLOAD (*339)
 N Z1,Z2 S Z1=""
 I $G(ZTM)>0 S Z2=$G(^%ZTSCH("TASK",ZTM)),Z1=$S($L(Z2):$P(Z2,"^",10),1:"")
 Q Z1
