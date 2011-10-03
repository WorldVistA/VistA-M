PRCE58P ;WISC/SAW/LDB-CONTROL POINT ACTIVITY 1358 DISPLAY CON'T ; 2/29/00 3:39pm
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
PRF58 ;PRINT 1358 ONLY
 D EN3^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0
PRF58E S DIC="^PRCS(410," D OROBL^PRCS58OB(DIC,.PRC,.DA) G EXIT:Y<0 K DIC("S") S DA=+Y
 D NODE^PRCS58OB(DA,.TRNODE)
 I '$D(PRC("CP")) S PRC("CP")=$P(TRNODE(0),"-",4)
PRF2 K PRCSA W !,"Would you like to print the Description field for each 1358 Daily Record entry" S %=2 D YN^DICN G PRF2:%=0,EXIT:%<0 I %=1 S PRCSA=1
 S DIR("A")="Would you like to print the daily records for each authorization? ",DIR(0)="YAO",DIR("B")="NO"
 S DIR("?")="Answer 'yes' to see the all the payments for each authorization." D ^DIR G:$D(DIRUT) EXIT S PRCSA1=Y G:Y=0 PRF3
 S DIR("A")="Would you like to print descriptions for each detailed daily record? ",DIR("?")="Answer 'yes' if you would like to see the description printed for each record."
 D ^DIR
 I $D(DIRUT) S PRCSA2=0 G EXIT
 S PRCSA2=Y
PRF3 D DEV G EXIT:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="^PRCE58P2",ZTSAVE("DA")="",ZTSAVE("PRC*")="" D ^%ZTLOAD G:$D(PRCSF) EXIT Q:$G(REP)="PRCEFIS4"  D W2 G PRF58
 I $E(IOST)="P" D ^PRCE58P2 D ^%ZISC G:$D(PRCSF) EXIT Q:$G(REP)="PRCEFIS4"  D W2 G PRF58
 D ^PRCE58P0 W:$Y>0 @IOF Q:$D(PRCSF)!($G(REP)="PRCEFIS4")  D W2 G PRF58
EXIT K %,%DT,%ZIS,BY,C2,C3,D,DA,DHD,DIC,DIE,PRCS,PRCSQ,FLDS,FR,I,L,N,TO,X,Y,ZTRTN,ZTSAVE
 K DIR
 Q
W2 W !!,"Enter information for another report or an uparrow to return to the menu.",! Q
DEV K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q
W1 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
