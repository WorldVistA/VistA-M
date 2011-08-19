%ZTLOAD3 ;SEA/RDS - TaskMan: Task Requeue ;07/29/08  11:46
 ;;8.0;KERNEL;**67,127,136,192,446**;JUL 10, 1995;Build 35
 ;
INPUT ;check for error conditions
 N %H,%T,X,X1,Y,ZT,ZT1,ZT2,ZT3,ZTH,ZTL,ZTOS,ZTREC,ZTREC1,ZTREC2,ZTREC25
 S ZTSK=$G(ZTSK) K ZTSK(0),ZTREQ ;Kill ZTREQ so we don't kill the entry
 L +^%ZTSK(ZTSK):9 S ZTREC=$G(^%ZTSK(ZTSK,0)) I ZTREC="" G BAD
 I $D(ZTDTH)#2,ZTDTH]"",ZTDTH'?1.5N1","1.5N,ZTDTH'?7N.".".N,ZTDTH'="@","SHD"'[$E(ZTDTH,$L(ZTDTH)) G BAD
 ;
DQ ;make sure task is not pending
 D UNSCH^%ZTLOAD6
 I $D(^%ZTSK(ZTSK,0))[0 G BAD
 ;
ZTDTH ;determine task's next start time
 S:$P(ZTREC,"^",16)="" $P(ZTREC,"^",16)=$P(ZTREC,"^",5) ;Save original create time
 S $P(ZTREC,"^",5)=$H ;Set a new create time
 I $D(ZTDTH)[0 S ZTDTH=$P(ZTREC,"^",6) G ZTRTN ;Use original time.
 I ZTDTH="" S ZTDTH=$H G ZTRTN
 I ZTDTH?1.5N1","1.5N G ZTRTN
 I ZTDTH?7N.".".N S ZTDTH=$$FMTH^%ZTLOAD7(ZTDTH) G ZTRTN
 I ZTDTH="@" G ZTRTN
 S ZTH=$$H3^%ZTM($P(ZTREC,"^",6)),ZTL=$E(ZTDTH,$L(ZTDTH)) ;From start time
DT I ZTL="S" S ZTH=ZTH+ZTDTH
 I ZTL="H" S ZTH=(ZTDTH*3600)+ZTH
 I ZTL="D" S ZTH=(ZTDTH*86400)+ZTH
DTX I ZTH<$$H3^%ZTM($H) G DT
 S ZTDTH=$$H0^%ZTM(ZTH)
 ;
ZTRTN ;determine whether entry point should change
 I $D(ZTRTN)[0 G ZTIO
 I ZTRTN="" G ZTIO
 I ZTRTN'[U S ZTRTN=U_ZTRTN
 S ZT=$P(ZTREC,U,1,2)
 I ZT'=ZTRTN S $P(ZTREC,U,1,2)=ZTRTN I ZT="ZTSK^XQ1" S $P(ZTREC,U,7,9)="R^^"
 ;
ZTIO ;determine whether i/o device should change
 N ZTREC2,ZTREC25
 S ZTREC2=$G(^%ZTSK(ZTSK,.2)),ZT=$P(ZTREC2,U)
 I $D(ZTIO)[0 G ZTIO1
 I ZTIO="" G ZTIO1
 I $P(ZTIO,";")'=$P(ZT,";") S $P(ZTREC2,U,6)="",ZTREC25=""
 I ZTIO="@" S $P(ZTREC2,U)="" G ZTIO1
 I ZTIO'=ZT S $P(ZTREC2,U)=ZTIO
 ;
ZTIO1 ;set hunt group suppression flag
 S $P(ZTREC2,U,5)=$S($D(ZTIO(1))[0:"",ZTIO(1)="D":"DIRECT",1:"")
 ;
ZTDESC ;determine whether description should change
 I $S($D(ZTDESC)[0:1,ZTDESC="":1,1:0) S ZTDESC=$G(^%ZTSK(ZTSK,.03))
 I ZTDESC=""!(ZTDESC="No Description (%ZTLOAD)") S ZTDESC="No Description (REQ~%ZTLOAD)"
 S ^%ZTSK(ZTSK,.03)=ZTDESC
 ;
RECORD ;record changes in Task File entry
 I $D(ZTREC2)#2 S ^%ZTSK(ZTSK,.2)=ZTREC2
 I $D(ZTREC25)#2 S ^%ZTSK(ZTSK,.25)=ZTREC25
 I ZTDTH'="@" S $P(ZTREC,U,6)=ZTDTH ;Reset the Scheduled time piece
 S ^%ZTSK(ZTSK,0)=ZTREC
 S $P(^%ZTSK(ZTSK,.1),U,1,3)=$S(ZTDTH'="@":"1^"_$H_"^REQUEUED",1:"H^"_$H_"^EDITED BUT NOT REQUEUED")
 ;
ZTSAVE ;See if new data to save
 K %H,%T,X,X1,Y,ZT,ZT1,ZT2,ZT3,ZTH,ZTL,ZTOS,ZTREC,ZTREC1,ZTREC2,ZTREC25
 K ZTDESC,ZTIO,ZTRTN
 I $D(ZTSAVE) K:$G(ZTSAVE)="KILL" ^%ZTSK(ZTSK,.3) D ZTSAVE^%ZTLOAD1
SCHED ;schedule task, cleanup, quit
 I ZTDTH'="@" L +^%ZTSCH("SCHQ"):6 S ZT=$$H3^%ZTLOAD1(ZTDTH),^%ZTSK(ZTSK,.04)=ZT,^%ZTSCH(ZT,ZTSK)="" L -^%ZTSCH("SCHQ")
 K %X,%Y,X,X1,Y,ZT1,ZT2,ZT3,ZTDTH,ZTSAVE
 L -^%ZTSK(ZTSK) S ZTSK(0)=1
 Q
 ;
BAD L -^%ZTSK(ZTSK) S ZTSK(0)=0
 Q
REQP(ZT1) ;Reschedule a persistent task. Called from ZTM
 N ZTSK,ZT2,ZT3,ZTDTH,ZTSAVE S ZTDTH=$H,ZTSK=ZT1
 L +^%ZTSK(ZTSK):20 Q:'$T
 I $D(^%ZTSK(ZTSK,0))[0 Q  ;Should tell someone
 G SCHED
