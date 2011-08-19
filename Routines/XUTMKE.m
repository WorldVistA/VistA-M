XUTMKE ;SEA/RDS - Taskman: Option, XUTME LOG* ;09/30/98  10:18
 ;;8.0;KERNEL;**86**;Jul 10, 1995
 ;
QUIT ;This Routine Contains Subroutines For Options
 Q
 ;
PRINT ;LIST Subroutine to Print An Error Log Entry
 N %H S %H=+$H
 Q:$D(^%ZTSCH("ER",ZT2,ZT3))[0
 S ZTE=^%ZTSCH("ER",ZT2,ZT3)
 S %="" F  S %=$O(^TMP($J,"XUTM",%)) Q:%=""  Q:ZTE[%
 I %'="" S XUSCR=XUSCR+1 Q
 S %=$$HTE^XLFDT(ZT2_","_ZT3)
 I %H-ZT2<2 W !,$S('(ZT2-%H):"TODAY",1:"YESTERDAY")," ",$P(%,"@",2)
 E  W !,$P(%,",")," ",$P(%,"@",2)
 F ZT=0:0 Q:ZTE=""  W ?20,$E(ZTE,1,60) S ZTE=$E(ZTE,61,999) W !
 S ZTE1=$S($D(^%ZTSCH("ER",ZT2,ZT3,1))[0:"Context unknown.",1:^(1))
 W ?20,"[",ZTE1,"]"
 Q
 ;
LIST ;Show Error Log
 D HOME^%ZIS:$S($D(IOSL)[0:1,IOSL="":1,$D(IOF)[0:1,1:IOF="")
 N %,%1,%2,%3,I,DIR,DIRUT,DTOUT,DUOUT,X,X1,X2,X3,XUSCR,ZTE,ZTF,ZTI,ZTJ,ZTY
 K ^TMP($J,"XUTM") F I=0:0 S I=$O(^%ZTER(2,"AC",1,I)) Q:I'>0  S %=$S($G(^%ZTER(2,I,2))]"":^(2),1:$P(^(0),U)),^TMP($J,"XUTM",%)=""
 S ZTY=IOSL-3 W @IOF
 I $O(^%ZTSCH("ER",""))="" W !!,"The TaskMan error log is empty." H 1 S Y=1 Q
 W !!!,"Timestamp",?20,"Error Message",!,"-------------------",?20,"------------------------------------------------------------"
 S ZTC=0,ZT2="",XUSCR=0
 F  S ZT2=$O(^%ZTSCH("ER",ZT2),-1),ZT3="" Q:ZT2=""  D  Q:$D(DIRUT)
 . F  S ZT3=$O(^%ZTSCH("ER",ZT2,ZT3),-1) Q:ZT3=""  D  Q:$D(DIRUT)
 . . S ZTC=ZTC+1 D PRINT I $Y>ZTY S DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF
L0 W:ZT2="" !!,?5,"Number Of Entries: ",ZTC,",  ",XUSCR," Screened Entries."
 I $D(DTOUT) W $C(7)
 I '$D(DIRUT) W ! S DIR(0)="E",DIR("A")="End of listing.  Press RETURN to continue",DIR("?")="     Enter either RETURN or '^'" D ^DIR
 S Y='$D(DUOUT)
 Q
 ;
KILL ;Delete Error Log
 K ^%ZTSCH("ER") W !,"Done." Q
 ;
RANGE ;Clean Error Log Over Range Of Dates
 K DIR S %H=$O(^%ZTSCH("ER",""))
 I '%H!'$D(^%ZTSCH("ER")) W $C(7),!!,"Taskman's error log is empty!" S DIR(0)="E",DIR("A")="Press return to continue",DIR("?")="     Press RETURN to exit the option" D ^DIR W:$D(DTOUT) $C(7) K DIR,DIRUT,DTOUT,DUOUT Q
 D YMD^%DTC S Y=X D DD^%DT
 S DIR(0)="D^::AEX"
 S DIR("A")="First date to purge",DIR("B")=Y
 S DIR("?")="     Answer must be a date",DIR("??")="^W ! D HELP^%DTC"
 D ^DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) W !!?5,"NO log entries deleted!" K DIR,DIRUT,DTOUT,DUOUT Q
 K DIR,DIRUT,DTOUT,DUOUT
 ;
 S X=Y D H^%DTC S ZTR1=%H
 D NOW^%DTC S Y=X D DD^%DT
 S DIR(0)="D^::AEX",DIR("A")="Final date to purge",DIR("B")=Y
 D ^DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) W !!?5,"NO log entries deleted!" K DIR,DIRUT,DTOUT,DUOUT Q
 K DIR,DIRUT,DTOUT,DUOUT
 ;
 S X=Y D H^%DTC S ZTR2=%H
 W !!?5,"Entries removed: ",$$PURGE(ZTR1,ZTR2,"")
 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue",DIR("?")="     Press RETURN to exit option" D ^DIR I $D(DTOUT) W $C(7)
 K %,%H,%I,%T,%Y,DIR,DIRUT,DTOUT,DUOUT,X,Y,ZT,ZTR1,ZTR2,ZTX Q
 ;
PURGE(XUR1,XUR2,CHK) ;PURGE OVER THE RANGE FROM XUR1 TO XUR2
 N ZT1,ZT2,ZT3,ZTC S ZT1="ER",ZT2="",ZTC=0
 F ZT=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)),ZT3="" Q:ZT2=""!(ZT2>XUR2)  I ZT2'<XUR1 D
 . F ZT=0:0 S ZT3=$O(^%ZTSCH(ZT1,ZT2,ZT3)) Q:ZT3=""  I $G(^(ZT3))[CHK K ^%ZTSCH(ZT1,ZT2,ZT3) S ZTC=ZTC+1 W:'$D(ZTQUEUED) "."
 Q ZTC
TYPE ;Purge Error Log Of Type Of Error
 K DIR I '$O(^%ZTSCH("ER","")) W $C(7),!!,"Taskman's error log is empty!",! S DIR(0)="E",DIR("A")="Press RETURN to continue",DIR("?")="Press RETURN to exit option" D ^DIR W:$D(DTOUT) $C(7) K DIR,DIRUT,DTOUT,DUOUT Q
 F ZTA=0:0 R !,"Type of error to remove: ",X:$S($D(DTIME)#2:DTIME,1:60) S Y=X Q:$L(X)<201&(X'="?")&(X'="??")  W !!,?5,"Answer must be a string.",!?5,"Taskman will remove every error that contains that string.",!
 I '$T S DTOUT=1,DIRUT=1 W $C(7),"**TIMEOUT**"
 I X="^" S DUOUT=1,DIRUT=1
 I Y=""!$D(DIRUT) W !!?5,"NO error log entries deleted!" K DIRUT,DTOUT,DUOUT Q
 W !!?5,"Entries removed: ",$$PURGE(0,+$H,Y)
 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue",DIR("?")="     Press RETURN to exit option" D ^DIR K DIR I $D(DTOUT) W $C(7)
 K DIRUT,DTOUT,DUOUT,ZT,ZT1,ZT2,ZT3,ZTC,ZTX Q
 ;
