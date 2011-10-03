PRCSP12 ;WISC/SAW-CONTROL POINT ACTIVITY 2237 PRINTOUT (FREE FORM) ;7/17/00  15:02
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 H 2 G P
QUE I $D(ZTQUEUED) S DA=D0
 S DA=D0
P U IO W:$Y>0 @IOF S U="^",P(1)=0,PRCS("P")=1,L="",$P(L,"_",90)="_" D NOW^%DTC S Y=% D DD^%DT
 S P=$S($D(^PRCS(410,DA,1)):$P(^(1),U,3),1:""),P=$S(P="EM":"***EMERGENCY***",P="SP":"*SPECIAL*",1:"STANDARD") W ?36,"PRIORITY: ",P
 W !,Y,?36,$P(^PRCS(410,DA,0),U),?83,"PAGE ",PRCS("P"),!,L
 W !,?16,"REQUEST, TURN-IN, AND RECEIPT FOR PROPERTY OR SERVICES",! I $D(ZTSAVE("NOPRINT")) W ?37,"**REPRINT**",!
 W !,L
 W !,"TO: A&MM Officer",?23,"|Requesting Office",?63,"|TO BE COMPLETED BY"
 W !,?23,"|" S P=$P(^PRCS(410,DA,0),U,5),P1=$S($D(^(3)):+$P(^(3),U),1:"") I P,P1 S P=$S($D(^PRC(420,P,1,P1,0)):$P(^(0),U,10),1:"") I P,$D(^DIC(49,P,0)) W $P(^(0),U) W:$P(^(0),U,8)]"" " ("_$P(^(0),U,8)_")"
 W ?63,"|SUPPLY PERSONNEL",!,$E(L,1,23)
 W "|",$E(L,1,39)
 W "|(NOTE - Alterations in"
 W !,"Action Requested",?23,"|Date Prepared",?45,"|Date Required",?63,"|""Action"" column will be"
 W !,?4,"Delivery",?23,"|" I $D(^PRCS(410,DA,1)),$P(^(1),U)'="" S Y=$P(^(1),U) D DD^%DT W Y
 W ?45,"|" I $D(^PRCS(410,DA,1)),$P(^(1),U,4)'="" S Y=$P(^(1),U,4) D DD^%DT W Y
 W ?63,"|initialed and dated)",!,$E(L,1,23)
 W "|",$E(L,1,21)
 W "|",$E(L,1,17)
 W "|",$E(L,1,26)
 W !,?2,"ITEM NO.  |",?23,"DESCRIPTION",?38,"|QUANTITY |UNIT|ESTIMATED|UNIT COST|TOTAL COST|ACT."
 W !,"OR STOCK NO.|",?38,"|",?48,"|",?53,"|UNIT COST|",?73,"|",?84,"|NOTE1",!,$E(L,1,12),"|",$E(L,1,25),"|",$E(L,1,9),"|",$E(L,1,4),"|",$E(L,1,9),"|",$E(L,1,9),"|",$E(L,1,10),"|",$E(L,1,5)
 S:'$D(PRNTALL) PRNTALL=1
 D ^PRCSP121,^PRCSP122 W:PRNTALL=0 !,"VA FORM 90-2237-ADP MAR 1985",! D:PRNTALL=1 ^PRCSP123 I '$D(PRCHQ("DEST")) D ^PRCSP124 G EXIT
 I $D(PRCHQ("DEST")),PRCHQ("DEST")'="F" D ^PRCSP124
EXIT K FPROJ,%DT,P,PRNTALL,X,X1,Y,Z,Z1,DA,DIWL,DIWR,DIWF,I,J,K,L,PRCS,^UTILITY($J,"W") D:$D(ZTSK) KILL^%ZTLOAD Q
