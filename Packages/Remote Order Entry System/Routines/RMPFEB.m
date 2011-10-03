RMPFEB ;DDC/KAW-CLOSE TRANSMISSION BATCH; [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!!,"CLOSE TRANSMISSION BATCH"
START W !!,"Currently Open Batch:",! F I=1:1:21 W "-"
A0 S RMPFBT=0
A1 F  S RMPFBT=$O(^RMPF(791812,"C",1,RMPFBT)) Q:'RMPFBT  I $D(^RMPF(791812,RMPFBT,0)) S S0=^(0),M=$P(S0,U,9) S:M M=$P($G(^RMPF(791810.5,M,0)),U,2) S:M="" M=0 I $P(S0,U,8)=RMPFSTAP,M=RMPFMENU Q
 I 'RMPFBT D MSG1 G END
 S S0=^RMPF(791812,RMPFBT,0)
 G A1:$P(S0,U,2)'=1 S Y=$P(S0,U,1) D DD^%DT
 S D=Y,N=$P(S0,U,4) W !!,"Date/Time Opened: ",D
 W !?1,"Number in Batch: ",N
A4 W !!,"Display batch entries? YES// " D READ G END:$D(RMPFOUT)
A41 I $D(RMPFQUT) W !!,"Type <Y> or <RETURN> to display entries in the batch or <N> to continue." G A4
 S:Y="" Y="Y" I "YyNn"'[Y S RMPFQUT="" G A41
 G MSG:"Nn"[Y
A42 D ^RMPFDB1
MSG W !!,"By closing this batch, you will make the batch available for transmission",!,"to the VA Denver Distribution Center."
A6 W !!,"Close this batch?  NO// " D READ
 G END:$D(RMPFOUT)
A61 I $D(RMPFQUT) W !!,"Enter <Y> to close the batch, <N> or <RETURN> to exit." G MSG
 S:Y="" Y="N" I "YyNn"'[Y S RMPFQUT="" G A61
 G END:"Nn"[Y
CLOSE S X="NOW",%DT="T" D ^%DT
 L ^RMPF(791812,RMPFBT)
 S $P(^RMPF(791812,RMPFBT,0),U,2)=2,$P(^(0),U,3)=Y,$P(^(0),U,5)=DUZ
 S ^RMPF(791812,"C",2,RMPFBT)="" K ^RMPF(791812,"C",1,RMPFBT)
 L
 W:'$D(ZTSK) !!?29,"*** BATCH CLOSED ***"
A7 D AUTOQ^RMPFQT
END K RMPFBT,RMPFBJ,RMPFB,%DT,SG,S0,D,I,N,X,Y
 K %,T,D,D0,DA,DI,DIC,DIE,DQ,DR,II,N,XMINST Q
MSG1 W !!,"*** NO OPEN BATCH ***" Q
DELETE ;;input:  RMPFB
 ;;output: None
 W !!,"Enter Order Numbers Separated by Commas: "
 D READ G DELETEE:$D(RMPFOUT)
DELE I $D(RMPFQUT) W !!,"Select the number(s) to the left of the orders you wish to delete.",!,"Separate numbers with commas." G DELETE
 G DELETEE:Y=""
 F I=1:1 S X=$P(Y,",",I) Q:X=""  I '$D(RMPFB(X)) S RMPFQUT="" Q
 G DELE:$D(RMPFQUT) S SG=Y W !!
 F I=1:1 S RX=$P(SG,",",I) Q:RX=""  I $D(RMPFB(RX)) S RMPFBJ=RMPFB(RX) I $D(^RMPF(791812,RMPFBT,101,RMPFBJ,0)) S RMPFX=$P(^(0),U,1) D DEL^RMPFER
DELETEE K RMPFQUT,SG,RX,I,X,Y,RMPFB Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
