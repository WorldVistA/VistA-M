XUTMDEVQ ;ISCSF/RWF - Device call and Queue in one place ;01/18/2006
 ;;8.0;KERNEL;**20,120,275,389**;Jul 10, 1995;Build 1
 ;  this routine has four entry points:  EN, DEV, NODEV, QQ
 ;  usage:
 ;D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,[.]%ZIS,[FLAG])
 ;S X=$$DEV^XUTMQUE(ZTRTN,ZTDESC,[.]%VAR,.%VOTH,[.]%ZIS,IOP,%WR)
 ;S X=$$NODEV^XUTMQUE(ZTRTN,ZTDESC,[.]%VAR,.%VOTH,%WR)
 ;S X=$$QQ(%RTN,%DESC,[.]%VAR1,.%VOTH1,.%ZIS,IOP,%WR,%RTN2,%DESC2,[.]%VAR2,.%VOTH2)
 ;EN
 ;Call with %ZTLOAD parameters and it will call $ZIS and
 ;run or queue the output.
 ;
EN(ZTRTN,ZTDESC,ZTSAVE,%ZIS,%) ;ZTSAVE AND %ZIS pass by reference.
 Q:$G(ZTRTN)=""
 N %RET,ZTIO,ZTDTH,ZTSYNC,ZTCPU,ZTUCI N:'$G(%) ZTSK K IO("Q")
 D ZIS I POP G KILL
 I '$D(IO("Q")) D RUN G KILL
 D ZTLOAD
KILL K ZTDTH,ZTSAVE
 Q
ZIS ;
 S:$G(%ZIS)'["Q" %ZIS=$G(%ZIS)_"Q"
 D ^%ZIS
 Q
ZTLOAD ;
 K IO("Q"),ZTSK
 D ^%ZTLOAD,HOME^%ZIS
 S:$D(ZTSK) %RET=ZTSK
 Q
RUN ;
 U IO
 D @ZTRTN
 D ^%ZISC
 Q
 ;
DEV(ZTRTN,ZTDESC,%VAR,%VOTH,%ZIS,IOP,%WR) ;  single que ask for device
 ;  ZTRTN - required - [tag]^routine that taskman will run
 ; ZTDESC - optional - default to name of [tag]~routine
 ;   %VAR - optional - single value or passed by reference
 ;          this will be used to S ZTSAVE()
 ;          can be a string of variable names separated by ';'
 ;            each ;-piece will be used as a subscript in ztsave
 ;  %VOTH - optional - passed by reference
 ;          %voth(sub)="" or explicit value
 ;             sub - this is any other %ZTLOAD variable besides 
 ;                   ZTRTN,ZTDESC,ZTIO,ZTSAVE
 ;                   example:  %VOTH("ZTDTH")=$H
 ;   %ZIS - optional - default value "MQ" - passed by reference
 ;          standard %ZIS variable array for calling device handler
 ;    IOP - optional - IOP variable as defined in Kernel device handler
 ;    %WR - optional - if %WR>0 then write text to the screen as to
 ;                     whether or not the queueing was successful
 ;
 ;  return: ZTSK value if successfully queued
 ;          0 if run ztrtn without queuing
 ;         -1 if unsuccessful device call or failed %ztload call
 ;
 N ZTIO,ZTDTH,ZTSYNC,ZTCPU,ZTUCI,ZTSAVE,ZTSK,ZTPRI,ZTKIL,%RET,POP
 S %RET=-1 I $G(ZTRTN)="" G OUT
 D SETUP,ZIS I POP G OUT
 I '$D(IO("Q")) D RUN S %RET=0
 D ZTLOAD
OUT I $G(%WR),%RET'=0,'$D(ZTQUEUED) D
 .W !! I %RET<0 W "Request Aborted",!
 .E  W "Task queued ["_(+%RET)_"]",!
 .I $P(%RET,U,2) W !,"Second task queued ["_$P(%RET,U,2)_"]",!
 .Q
 Q %RET
 ;
NODEV(ZTRTN,ZTDESC,%VAR,%VOTH,%WR) ;  single que no device needed
 ;  see DEV for parameter descriptions and return values
 N ZTIO,ZTDTH,ZTSYNC,ZTCPU,ZTUCI,ZTSAVE,ZTSK,ZTKIL,ZTPRI,%RET,POP
 S %RET=-1 I $G(ZTRTN)]"" S ZTIO="" D SETUP,ZTLOAD
 G OUT
 ;
QQ(%RTN,%DESC,%VAR1,%VOTH1,%ZIS,IOP,%WR,%RTN2,%DESC2,%VAR2,%VOTH2) ;
 ;  double queuing - queue up the second routine to device, but do not
 ;                   schedule the task in Taskman
 ;    queue up the first job to ZTIO="" and schedule it
 ;  %RTN - required - [tag]^routine for the 1st job to be run (usually a
 ;                    search and build sorted data type process)
 ; %DESC - optional - ZTDESC value for 1st job (default [tag]~routine)
 ; %VAR1 - optional - ZTSAVE values for 1st job - see %VAR descript above
 ;%VOTH1 - optional - 1st job - see %VOTH description above
 ;  %ZIS - optional - see %ZIS description above, except for one diff
 ;         the 2nd job will be tasked to this device call
 ;         exception: IF $D(%ZIS)=0 then default value is "MQ" and call
 ;                    device handler
 ;                    IF $D(%ZIS)=1,%ZIS="" then queue 2nd job also with
 ;                       ZTIO=""  i.e., do not do device handler call
 ;   IOP - optional - see above - default value "Q" - if IOP is passed
 ;                    and IOP does not start with "Q;" then "Q;" will
 ;                    be added
 ;   %WR - optional - see above
 ; %RTN2 - required - [tag]^routine for the 2nd job to be run (usually a
 ;                    print job)
 ;%DESC2 - optional - ZTDESC value for 2nd job (default [tag]~routine)
 ; %VAR2 - optional - ZTSAVE values for 2nd job - see %VAR descript above
 ;         if %VAR1 is not passed and $D(%VAR) then also send %VAR
 ;         data to 2nd tasked job.  If $D(%VAR1) then do not send %VAR
 ;         data to 2nd tasked job.
 ;%VOTH2 - optional - 2nd job - see %VOTH description above - usually not
 ;         needed - note: if %VOTH1("ZTDTH") is passed it will be ignored
 ;         as it is necessary to S ZTDTH="@" for the 2nd job - this will
 ;          create the task but not schedule it
 ;
 ;  return: if successfully queued, return ztsk1^ztsk2 where
 ;           ztsk1 = ZTSK value of 1st job, ztsk2 = ZTSK value of 2nd job
 ;         -1 if unsuccessful device call or failed %ztload call
 ;
 N ZTIO,ZTDTH,ZTSYNC,ZTCPU,ZTUCI,ZTSAVE,ZTSK,ZTPRI,ZTKIL,ZTDESC,%RET,POP
 N %VAR,%VOTH,%TMP S %RET=-1
 I $G(%RTN)=""!($G(%RTN2)="") G OUT
 ;  setup 2nd job to %ZIS
 S ZTRTN=%RTN2
 I $D(%VAR2) M %VAR=%VAR2
 I '$D(%VAR),$D(%VAR1) M %VAR=%VAR1
 I $D(%VOTH2) M %VOTH=%VOTH2
 I $G(%DESC2)]"" S ZTDESC=%DESC2
 I $D(%ZIS)=1,%ZIS="" S ZTIO=""
 E  D
 .I $D(IOP),IOP'?1"Q;".E S IOP="Q;"_IOP
 .I '$D(IOP) S IOP="Q"
 .Q
 D SETUP,ZIS:'$D(ZTIO) I $G(POP) G OUT
 S ZTDTH="@" D ZTLOAD
 K %VAR,%VOTH,%ZIS,IOP S %TMP=%RET
 S ZTRTN=%RTN
 I $D(%VAR1) M %VAR=%VAR1
 I $D(%VOTH1) M %VOTH=%VOTH1
 I $G(%DESC)]"" S ZTDESC=%DESC
 D SETUP S ZTIO="",%RET=-1,ZTSAVE("XUTMQQ")=%TMP D ZTLOAD I %RET>0 S %RET=%RET_U_%TMP
 G OUT
 ;
REQQ(ZTSK,ZTDTH,%VAR) ;Reschedule the second part of a QQ task.
 ;The task to work on should be in XUTMQQ.
 N ZTIO,ZTDESC,ZTRTN,ZTSYNC,ZTCPU,ZTUCI,ZTSAVE,ZTPRI,ZTKIL,ZTREQ
 I $G(ZTSK)=""!($G(ZTDTH)="") Q 0
 D VAR
 D REQ^%ZTLOAD
 Q $G(ZTSK(0),0)  ;Return 1 for rescheduled, 0 for fail.
 ;
SETUP ;  setup %ztload variables
 K ZTDTH,ZTSYNC,ZTCPU,ZTUCI,ZTSAVE,ZTPRI,ZTKIL,ZTSK,IO("Q") N I,X,Y
 D VAR
 I $D(%VOTH) F  S X=$O(%VOTH(X)) Q:X=""  S:'$D(@X) @X=%VOTH(X)
 I '$D(ZTDESC) S ZTDESC=$TR($P(ZTRTN,"("),U,"~")
 Q
 ;
VAR ;Setup ZTSAVE
 I $D(%VAR)#2 F I=1:1:$L(%VAR,";") S X=$P(%VAR,";",I),ZTSAVE(X)=""
 S X="" F  S X=$O(%VAR(X)) Q:X=""  S ZTSAVE(X)=%VAR(X)
 Q
