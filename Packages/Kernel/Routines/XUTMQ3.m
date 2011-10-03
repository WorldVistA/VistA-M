XUTMQ3 ;SEA/RDS - TaskMan: Option, ZTMINQ, Part 5 (Modules) ;03/09/2000  12:58
 ;;8.0;KERNEL;**136**;Jul 10, 1995
 ;
ENTRY G ^XUTMQ
 ;
PRINT ;Subroutine--Print A Task
 N ZTSK W:'ZTC @IOF,!,ZTH,! W:'ZTF !,"-------------------------------------------------------------------------------"
 S X=0,ZTC=0,ZTF=0 D EN^XUTMTP(ZTS) I $Y>18 W ! S ZTF=1,DIR(0)="E" D ^DIR S X=$D(DTOUT)!$D(DUOUT) Q:X  W @IOF
 S ZTC=ZTC+1 Q
 ;
OUT ;Tag for breaking FOR scope to exit early
 Q
 ;
IOQ0 ;IOQ--Extending Scope Of FOR Loop
 S ZTS=ZT3 D PRINT Q:X
 Q
 ;
IO ;IO1--List the tasks waiting for the selected device
 S X=0,ZTC=0,ZTF=1,ZTH="Tasks waiting for device "_ZTION_"..."
 S ZT2="" F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:'ZT2  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D PRINT G OUT:X
 Q:X  W:'ZTC !?5,"On this volume set there are no tasks waiting for that device." W ! Q
 ;
IOQ ;Tasks waiting for devices.
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZT3,ZTC,ZTF,ZTH,ZTS S ZTC=0,ZTF=1,ZTH="Tasks waiting for devices..."
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:'ZT2  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  D IOQ0 G OUT:X
 I 'ZTC W !!,"There are no tasks waiting for devices on this volume set."
 W ! S DIR(0)="E",DIR("A")=$S(ZTC:"End of listing.  ",1:"")_"Press RETURN to continue" D ^DIR Q
 ;
IO1 ;Waiting list for a device
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZT3,ZTC,ZTF,ZTIO,ZTION,ZTH,ZTS
 F ZT=0:0 D IO2 Q:ZTION=""  S ZT1=ZTIO D IO Q:X
 Q
 ;
IO2 ;IO1--prompt user for a device
 S DIR(0)="PO^3.5:EMQZ"
 S DIR("A")="Select DEVICE"
 S DIR("?",1)="     Answer should be a device whose waiting list you want to see."
 S DIR("?")="     Enter ?? for a list of devices with waiting tasks."
 S DIR("??")="^D IO3^XUTMQ3"
 D ^DIR K DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) S ZTION="" Q
 S ZTION=$P(Y,U,2),ZTIO=$P(Y(0),U,2)
 Q
 ;
IO3 ;IO2--?? help for device selection
 N ZT,ZT1,ZT2,ZT3,ZT4,ZTC
 W !!?5,"These are the devices with waiting tasks:",!
 S ZT1="IO",ZT2=""
 F  S ZT2=$O(^%ZTSCH("IO",ZT2)) Q:ZT2=""  D IOCNT I ZTC W !?5,ZT2,?40,ZTC," task",$S(ZTC=1:"",1:"s")
 Q
 ;
IOCNT ;IO3--count tasks waiting for each device
 S ZT3="",ZTC=0
 F  S ZT3=$O(^%ZTSCH("IO",ZT2,ZT3)),ZT4="" Q:ZT3=""  F  S ZT4=$O(^%ZTSCH("IO",ZT2,ZT3,ZT4)) Q:ZT4=""  S ZTC=ZTC+1
 Q
 ;
