XUTMR ;SEA/RDS - Taskman: Requeue Interface, Part One ;9/8/95  15:49
 ;;8.0;KERNEL;**2**;Jul 10, 1995
 ;
INIT ;Setup
 D ENV^XUTMUTL
 W @IOF
LKUP ;Lookup Task
 F %ZTI=0:0 R !!,"Task Number: ",ZTSK:DTIME G Q^XUTMR1:"^"[ZTSK Q:$D(^%ZTSK(ZTSK,0))#2!(ZTSK="??")  W:ZTSK'="?" !?10,"This task is not listed in the Task Log." W !,"Please enter the number of an entry in the Task Log that you wish to requeue."
 I ZTSK="??" D ^XUTMQ G INIT
 L +^%ZTSK(ZTSK):5 E  W !!?10,"That file is not currently available.  Please try again later." G LKUP
 S ZTREC=^%ZTSK(ZTSK,0),ZTREC2=$S($D(^%ZTSK(ZTSK,.2))#2:^(.2),1:"")
 I 'ZTKEY,$S($P(ZTREC,U,11)_","_$P(ZTREC,U,12)=XUTMUCI:DUZ'=$P(ZTREC,U,3),1:ZTNAME'=$P(ZTREC,U,10)) W !!?10,"You may only requeue tasks that you originally queued." G LKUP
 I $P(ZTREC,U,1,2)="ZTSK^XQ1",$D(^%ZTSK(ZTSK,.3,"XQSCH")) W !!,"This is a scheduled option, Please use the SCHEDULE/UNSCHDULE option." G LKUP
 S %ZTDTH=$P(ZTREC,U,6),%ZTDTH(3)=$$H3^%ZTM(%ZTDTH)
 ;S %ZTIO=""
 ;F %ZTI=0:0 S %ZTIO=$O(^%ZTSCH("IO",%ZTIO)),%ZTU="" Q:%ZTIO=""  F %ZTI=0:0 S %ZTU=$O(^%ZTSCH("IO",%ZTIO,%ZTU)) Q:%ZTU=""  I $D(^%ZTSCH("IO",%ZTIO,%ZTU,ZTSK))#2 S %ZTIO(ZTSK)=%ZTIO G TIME
 ;
TIME ;Ask Requeue Time
 W ! D EN^XUTMTP(ZTSK) W !
 S %DT="AERSX",%DT("A")="Requeue for what time: ",%DT("B")="NOW"
 I $$HDIFF^XLFDT(%ZTDTH,$H,2)>0 S %DT("B")=$$HTE^XLFDT(%ZTDTH)
 D ^%DT G NEXT^XUTMR1:Y=-1 S ZTDTH=$$FMTH^XLFDT(Y)
 ;
DEV ;Ask Requeue Device And Calculate UCI And CPU Destination
 S %ZTYND="YES" S:$P(ZTREC2,U)="" %ZTYND="NO"
 S DIR("A")="Do you wish to change the Device the task goes to:",DIR("B")="No",DIR(0)="Y"
 S DIR("?")="Please enter whether you wish to change output device for this task." D ^DIR
 G NEXT^XUTMR1:$D(DIRUT) K ZTIO S ZTCPU=""
 I Y'=1 S ZTIO=$P(ZTREC2,U),%=$P(ZTREC2,U,6) S:$L(%) ZTIO("H")=% S:$D(^%ZTSK(ZTSK,.25))#2 ZTIO("P")=^(.25) G CONT
 ;
D0 S %ZIS("B")=$S($P(ZTREC2,U)]"":$P(ZTREC2,U),1:""),%ZIS="NQZ",%ZIS("A")="Requeue to what device: " D ^%ZIS S ZTIO=$S($D(IOS)[0:"",POP:"",$D(ION)[0:"",ION]"":ION,IOS="":"",$D(^%ZIS(1,IOS,0))[0:"",1:$P(^(0),U))
 I ZTIO="" W !!,"No device selected.  Task unchanged." G NEXT^XUTMR1
 I IOT="VTRM" D HOME^%ZIS W !,"Tasks can not open virtual terminals.  Please select another device.",$C(7),! G D0
 S ZTIO=ZTIO_$S($D(IOST)[0:"",1:";"_IOST)_$S($D(IO("DOC"))[0:$S($D(IOM)[0:"",1:";"_IOM_$S($D(IOSL)[0:"",1:";"_IOSL)),1:";"_IO("DOC"))_$S($D(IO("P"))[0:"",IO("P")="":"",1:";/"_IO("P")) S:$D(IOCPU)#2 ZTCPU=IOCPU
 I $D(IO("HFSIO"))#2,$D(IOPAR)#2,IOT="HFS" S ZTIO("H")=IO("HFSIO"),ZTIO("P")=IOPAR
 ;
CONT ;Taskman Requeue Interface Is Continued In XUTMR1
 G ^XUTMR1
 ;
