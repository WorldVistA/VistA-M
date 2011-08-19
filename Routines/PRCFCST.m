PRCFCST ;WISC@ALTOONA/CLH-CHANGE P.O. STATUS ;10 Sep 89/3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN K COUNT I '$D(PRC("SITE")) D ^PRCFSITE Q:'%
 S DIC=442,DIC(0)="AEMNQ",DIC("A")="Select PURCHASE ORDER: " D ^DIC K DIC G:+Y<0 OUT S PRCFDA=+Y
 I '$D(^PRC(442,PRCFDA,7)) W $C(7),!,"Current Status is undefined",! Q
 S PRCFSTAN=$P(^PRC(442,PRCFDA,7),"^") W !,"Current status is: " S DIC=442.3,DIC(0)="MN",X=PRCFSTAN D ^DIC K DIC I +Y<0 W "??" G EN
 S PRCFSTA=$P(Y,"^",2) W PRCFSTA
CSTAT S:'$D(COUNT) COUNT=0 S DIC=442.3,DIC("A")="Select NEW STATUS: ",DIC(0)="AEMNQ" S COUNT=COUNT+1 D ^DIC Q:COUNT>2  G:+Y<0 CSTAT S PRCFNST=+Y
 S %A="Are you sure you want to change the status",%B="",%=1 D ^PRCFYN I %'=1 W $C(7),!,"    ----  STATUS NOT CHANGED  ----" G OUT
 D WAIT^PRCFYN S X=PRCFNST,DA=PRCFDA D UPD^PRCHSTAT W !!,"Status changed",! G EN
OUT K DIC,PRCFDA,PRCFSTAN,PRCFSTA,PRCFNST,COUNT Q
