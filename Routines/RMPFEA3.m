RMPFEA3 ;DDC/KAW-AUTOQUEUE MANAGER FOR TRANSMISSION BATCHES [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: RMPFBT
 ;;output: None
 ;;Set queue time if transmission parameter set to auto-queue
 Q:'$D(RMPFBT)  Q:$P(RMPFSYS,U,3)'="A"
 S TM=$P(RMPFSYS,U,4) I TM="" S TM=.22
 S X="NOW",%DT="T" D ^%DT
 S A="."_$P(TM,".",2),B="."_$P(Y,".",2),ZTDTH=$P(DT,".",1)_A
 I A-B<0 S X1=$P(DT,".",1),X2=1 D C^%DTC S ZTDTH=$P(X,".",1)_A
QUE S ZTIO="",ZTDESC="AUTO-QUEUE ROES TRANSMISSION",ZTSAVE("RMPFBT")=""
 S ZTSAVE("RMPFSTAP")="",ZTSAVE("RMPFMENU")="",ZTSAVE("RMPFSYS")=""
 S ZTRTN="CLOSE^RMPFEB" D ^%ZTLOAD
 S $P(^RMPF(791812,RMPFBT,0),U,10)=ZTSK
END K TM,X,Y,A,B,ZTDTH,ZTIO,ZTDESC,ZTSAVE,ZTRTN,ZTSK Q
REQUE ;;Reschedule the closing and transmission of a batch
 ;; input: RMPFBT
 ;;output: None
 Q:'$D(RMPFBT)  Q:'$D(^RMPF(791812,RMPFBT,0))  S ZTSK=$P(^(0),U,10)
 I 'ZTSK W !!,$C(7),"*** THIS BATCH HAS NOT BEEN SCHEDULED FOR TRANSMISSION ***" G REQUEE
 S X="NOW",%DT="T" D ^%DT S ZTDTH=Y D REQ^%ZTLOAD
 I ZTSK(0)'=1 W !!,"*** TASK NOT REQUEUED ***"
REQUEE K X,Y,ZTSK Q
EMER ;;Queue or requeue emergency batch
 ;; input: RMPFBT,RMPFCAT
 ;;output: None
 W !!,"This order has a delivery category of: "
 W $S(RMPFCAT="E":"EMERGENCY",1:"PRIORITY")
 W !!,"Do you wish to close the open batch and transmit now? YES// "
 D READ Q:$D(RMPFOUT)
EMER1 I $D(RMPFQUT) W !!,"Enter a <Y> or <RETURN> to close and transmit the batch immediately",!?7,"an <N> to leave the batch for later transmission." G EMER
 S:Y="" Y="Y" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G EMER1
 G EMERE:"Yy"'[Y
 I $P(^RMPF(791812,RMPFBT,0),U,10) D REQUE^RMPFEA3 G EMERE
 D CLOSE^RMPFEB
EMERE Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
