PRCHESE ;WISC/AKS-Estimated Shipping Edit ;11/2/93  10:35
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCF("X")="S" D ^PRCFSITE
EN K PRCHP Q:'$D(PRC("SITE"))  S PRCHP("S")="$P(^(0),U,2)<8" S:$D(PRCHNRQ) PRCHP("A")="REQUISITION NO.: ",PRCHP("S")="$P(^(0),U,2)=8"
 D EN3^PRCHPAT Q:'$D(PRCHPO)  I X<20!(X=45) W $C(7)," ??" G EN
 I X=28!(X=33) W $C(7),!,"Amendments not allowed until after order has been Obligated!!" G EN
 D LCK^PRCHAM3 G:$T Q S PRCH(0)=Y(0),PRCH(1)=^PRC(442,PRCHPO,1),PRCH(7)=^(7),PRCH(12)=^(12),(PRCHAMT,PRCHAN,PRCHDL,PRCHAREC,PRCHCHK)=0
 I $D(^PRC(442,PRCHPO,6)) F I=0:0 S I=$O(^PRC(442,PRCHPO,6,I)) Q:'I  S PRCHAN=I
 S PRCHAN=PRCHAN+1 W !?5,"Amendment number: ",PRCHAN S %=1,%A="      Do you wish to continue",%B="" D ^PRCFYN G:%'=1 Q
 S ^PRC(443.6,PRCHPO,0)=PRCH(0),^(1)=PRCH(1),^(7)=PRCH(7),^(12)=PRCH(12),DIE="^PRC(443.6,",DR="[PRCHAMEND]" S:$D(PRCHAV) DR="[PRCHAMENDAV]"
 D ^DIE G:$D(Y) Q I '$D(^PRC(443.6,PRCHPO,6,PRCHAN,1)) W !?5,"Can't continue without a Purchasing Agent !" G Q
ASK K ^TMP("PRCHW",$J) S DIC="^PRCD(442.2,",DIC("S")="I Y>19,($P(^(0),U,3)]"""")" S:$D(PRCHNRQ) DIC("S")=DIC("S")_",(""25;26;28;35;36""'[Y)" S DIC(0)="QEAZ"
 D ^DIC G:Y<0 CHK^PRCHAM K DIC I '$D(^PRCD(442.2,+Y,1)) W !!?5,"Amendment Lines in file 442.2 not defined " G ASK
 S ROU=$P(Y(0),U,3),PRCHL1=$P(^PRCD(442.2,+Y,1),U,1),PRCHL2=$P(^(1),U,2) I $L($T(@ROU))<2 W !!?5,"Routine line not defined " G ASK
 S PRCHT=1 D @ROU G ASK:PRCHT D EN^PRCHAM G ASK
 ;S PRCHT=1 D @ROU S:'$D(PRCHT) PRCHT=1 G ASK:PRCHT D EN^PRCHAM G ASK
DIE S DIE="^PRC(443.6,",DA=PRCHPO D ^DIE K DIE Q
Q QUIT
