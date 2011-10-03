ZTMONH1 ;SEA/RDS-TaskMan: Option, ZTMON, Part 4 (Help Modules) ;11/29/90  11:26 ;
 ;;7.1;KERNEL;;May 11, 1993
 ;
ENTRY G ^ZTMON
 ;
PRINT ;Subroutine--Print A Task
 N ZTMT,ZTSK W:'ZTC @IOF,!,ZTH,! W:'ZTF !,"-------------------------------------------------------------------------------"
 S X=0,ZTF=0,ZTMT=ZTS,ZTMT(0)="P" D ^ZTMT I $Y>18 W ! S ZTF=1,DIR(0)="E" D ^DIR S X=$D(DTOUT)!$D(DUOUT) Q:X  W @IOF
 S ZTC=ZTC+1 Q
 ;
OUT ;Tag for breaking FOR scope to exit early
 Q
 ;
SCHED ;Display Schedule List
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZTC,ZTF,ZTH,ZTS S ZTC=0,ZTF=1,ZTH="Schedule list..."
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  F ZTS=0:0 S ZTS=$O(^%ZTSCH(ZT1,ZTS)) Q:'ZTS  D PRINT S ZTC=ZTC+1 G OUT:X
 I 'ZTC W !!,"The Schedule List is empty."
 W ! S DIR(0)="E",DIR("A")=$S(ZTC:"End of listing.  ",1:"")_"Press RETURN to continue" D ^DIR Q
 ;
WAIT ;Display Waiting Lists
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZT3,ZTC,ZTF,ZTH,ZTS S ZTC=0,ZTF=1,ZTH="Device waiting lists..."
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:'ZT2  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  D W0 G OUT:X
 I 'ZTC W !!,"The Device Waiting Lists are empty."
 W ! S DIR(0)="E",DIR("A")=$S(ZTC:"End of listing.  ",1:"")_"Press RETURN to continue" D ^DIR Q
 ;
W0 ;WAIT Subroutine--Extending IO Loop
 S ZTS=ZT3 D PRINT S ZTC=ZTC+1 Q:X
 Q
 ;
WAIT1 ;Display One Waiting List
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZT3,ZTC,ZTF,ZTH,ZTIO,ZTION,ZTS
 F ZT=0:0 D W2 Q:ZTION=""  S ZT1=ZTIO D W1 Q:X
 Q
 ;
W1 ;WAIT1 Subroutine--Extending Loop
 S ZTC=0,ZTF=1,ZTH="Waiting list for device "_ZTION_"..."
 S X=0,ZTC=0,ZT2="" F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:'ZT2  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D PRINT S ZTC=ZTC+1 G OUT:X
 Q:X  W:'ZTC !?5,"There are no tasks waiting for device ",ZTION,"." W ! Q
 ;
W2 ;WAIT1--prompt user for a device
 S DIR(0)="PO^3.5:EMQZ"
 S DIR("A")="Select DEVICE"
 S DIR("?",1)="     Answer should be a device whose waiting list you want to see."
 S DIR("?")="     Enter ?? for a list of devices with waiting tasks."
 S DIR("??")="^D W3^ZTMONH1"
 D ^DIR K DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) S ZTION="" Q
 S ZTION=$P(Y,U,2),ZTIO=$P(Y(0),U,2)
 Q
 ;
W3 ;W2--?? help for device selection
 N ZT,ZT1,ZT2,ZT3,ZT4,ZTC
 W !!?5,"These are the devices with waiting tasks:",!
 S ZT1="IO",ZT2="" F ZT=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  W !?5,ZT2 D WCNT W ?40,ZTC," task",$S(ZTC=1:"",1:"s")
 Q
 ;
WCNT ;W3--count tasks waiting for each device
 S ZT3="",ZTC=0 F ZT=0:0 S ZT3=$O(^%ZTSCH(ZT1,ZT2,ZT3)),ZT4="" Q:ZT3=""  F ZT=0:0 S ZT4=$O(^%ZTSCH(ZT1,ZT2,ZT3,ZT4)) Q:ZT4=""  S ZTC=ZTC+1
 Q
 ;
