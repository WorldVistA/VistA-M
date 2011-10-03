%ZTLOAD4 ;SEA/RDS-TaskMan: P I: Is Queued? ;1/24/08  16:15
 ;;8.0;KERNEL;**440**;JUL 10, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;Call with ZTSK, [ZTCPU]; Return ZTSK()
INPUT ;check input parameters for error conditions
 N %,$ES,$ET,%ZTVOL,ZTREC,ZTD,ZT1,ZT2,ZT3
 I $D(ZTSK)[0 S ZTSK=""
 I $D(ZTSK)>1 S %=ZTSK K ZTSK S ZTSK=%
 I ZTSK<1!(ZTSK\1'=ZTSK) S ZTSK="",ZTSK(0)="",ZTSK("E")="IT" G QUIT
 S ZTSK(0)="",ZTSK("E")="U",$ET="Q:$ES  S $EC="""" G QUIT^%ZTLOAD4"
 S %ZTVOL=^%ZOSF("VOL")
 I $D(ZTCPU)[0 S ZTCPU=%ZTVOL
 I ZTCPU="" S ZTCPU=%ZTVOL
 I ZTCPU'=%ZTVOL G THERE
 ;
HERE ;lookup task's status on current volume set
 L +^%ZTSK(ZTSK):1
 I $D(^%ZTSK(ZTSK,0))[0 S ZTSK("E")="I" G QUIT
 S ZTREC=^%ZTSK(ZTSK,0),ZTD=$G(^(.04))
 S ZTSK("DUZ")=$P(ZTREC,U,3),ZTSK("D")=$P(ZTREC,U,6) ;scheduled $H
 I ZTD]"",$D(^%ZTSCH(ZTD,ZTSK))#2 S ZTSK(0)=1 G QUIT
 I ZTD]"",$D(^%ZTSCH("JOB",ZTD,ZTSK))#2 S ZTSK(0)=1 G QUIT
 ;
 S ZT1="" F  S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  I $D(^(ZT1,ZTSK))#2 S ZTSK(0)=1 G QUIT
 S ZT1="IO",ZT2="" F  S ZT2=$O(^%ZTSCH(ZT1,ZT2)),ZT3="" Q:ZT2=""  F  S ZT3=$O(^%ZTSCH(ZT1,ZT2,ZT3)) Q:ZT3=""  I $D(^(ZT3,ZTSK))#2 S ZTSK(0)=1 G QUIT
 S ZT1="JOB",ZT2="" F  S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK))#2 S ZTSK(0)=1 G QUIT
 S ZT1="LINK",ZT2="" F  S ZT2=$O(^%ZTSCH(ZT1,ZT2)),ZT3="" Q:ZT2=""  F  S ZT3=$O(^%ZTSCH(ZT1,ZT2,ZT3)) Q:ZT3=""  I $D(^(ZT3,ZTSK))#2 S ZTSK(0)=1 G QUIT
 S ZTSK(0)=0
 ;
QUIT ;cleanup and quit
 L:ZTSK -^%ZTSK(ZTSK) ;K %ZTCPU,%ZTM,%ZTM1,%ZTM2,%ZTMAST,%ZTVOL,X,Y,ZT,ZT1,ZT2,ZT3,ZTCPU,ZTD,ZTREC
 I ZTSK(0)]"" K ZTSK("E") Q
 I ZTSK("E")'="U" Q
 S ZTSK("E",0)=$$EC^%ZOSV
 Q
 ;
THERE ;rest of code looks up task's status on some other volume set
 N %ZTCPU,%ZTM,X,Y
 ;
FILES ;find TaskMan files on the volume set to be searched
 S %ZTCPU=$O(^%ZIS(14.5,"B",ZTCPU,""))
 I %ZTCPU="" S ZTSK("E")="IS" G QUIT
 S %ZTM=$P(^%ZOSF("MGR"),",")
 S %ZTM=$S($D(^%ZIS(14.5,%ZTCPU,0))[0:%ZTM,$P(^(0),U,6)="":%ZTM,1:$P(^(0),U,6))
 S X=%ZTM,Y=ZTCPU
 S ZTSK("E")="LS",ZT=$D(^[X,Y]%ZTSK(0)),ZTSK("E")="U" ; check link
 ;
SEARCH ;find out if task is queued on that volume set
 I $D(^[X,Y]%ZTSK(ZTSK,0))[0 S ZTSK("E")="I" G QUIT
 S ZTREC=^[X,Y]%ZTSK(ZTSK,0),ZTD=$G(^(.04))
 S ZTSK("DUZ")=$P(ZTREC,U,3),ZTSK("D")=$P(ZTREC,U,6)
 I ZTD]"",$D(^[X,Y]%ZTSCH(ZTD,ZTSK))#2 S ZTSK(0)=1 G QUIT
 I ZTD]"",$D(^[X,Y]%ZTSCH("JOB",ZTD,ZTSK))#2 S ZTSK(0)=1 G QUIT
 ;
 S ZT1="" F  S ZT1=$O(^[X,Y]%ZTSCH(ZT1)) Q:'ZT1  I $D(^(ZT1,ZTSK))#2 S ZTSK(0)=1 G QUIT
 S ZT1="IO",ZT2="" F  S ZT2=$O(^[X,Y]%ZTSCH(ZT1,ZT2)),ZT3="" Q:ZT2=""  F  S ZT3=$O(^[X,Y]%ZTSCH(ZT1,ZT2,ZT3)) Q:ZT3=""  I $D(^(ZT3,ZTSK))#2 S ZTSK(0)=1 G QUIT
 S ZT1="JOB",ZT2="" F  S ZT2=$O(^[X,Y]%ZTSCH(ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK))#2 S ZTSK(0)=1 G QUIT
 S ZT1="LINK",ZT2="" F  S ZT2=$O(^[X,Y]%ZTSCH(ZT1,ZT2)),ZT3="" Q:ZT2=""  F  S ZT3=$O(^[X,Y]%ZTSCH(ZT1,ZT2,ZT3)) Q:ZT3=""  I $D(^(ZT3,ZTSK))#2 S ZTSK(0)=1 G QUIT
 S ZTSK(0)=0 G QUIT
 ;
