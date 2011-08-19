PRCFACG ;WISC@ALTOONA/CTB-GRAB A BATCH NUMBER ;15 Nov 90/1:28 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S %A="This option reserves the next available batch number for a given station number,",%A(1)="month and batch type.  It the instructs the system that the number has"
 S %A(2)="been used and restricts further access to that number.",%A(3)="Do you wish to continue",%B="",%=1 D ^PRCFYN G Q:%'=1
 S PRCF("X")="AS" D ^PRCFSITE G:'% Q
 S %DT="AE",%DT("A")="Enter Month and Year: " D ^%DT I Y<0 W !,"NO BATCH NUMBER RESERVED" G Q
 S PMO=$E(Y,1,5)_"00" S Y=PMO D DD^%DT S MO=Y S:'$D(PRCFASYS) PRCFASYS="FEEFENIRS"
 I $D(PRCHLOG) S PRCFASYS="LOG",PTYP=5,BTYPE="LOG"
 E  S DIC=423.9,DIC(0)="AMNEZQ",DIC("S")="I PRCFASYS[$P(^(0),U,5)" D ^DIC G:Y<0 Q S PTYP=+Y,PRCFASYS=$P(Y(0),"^",5),BTYPE=$P(Y,"^",2) K DIC
 W ! S %A="RESERVE A BATCH FOR BATCH TYPE '"_BTYPE_"' IN "_MO,%B="",%=1 D ^PRCFYN I %'=1 W $C(7),"  NO BATCH SELECTED",!! R X:3 G Q
 W ! S PSN=PRC("SITE") D BATCH^PRCFACP2 W !,"BATCH NUMBER '",PBAT,"' HAS BEEN RESERVED",!!
Q K %,%DT,%H,%I,BTYPE,C,D,D0,DI,DIC,DIE,DA,DLAYGO,DR,MO,PBA,PBAT,PBATN,PMO,PRCF,PRCFASYS,PSN,PTR,PTYP,X,Y,Z Q
 Q
