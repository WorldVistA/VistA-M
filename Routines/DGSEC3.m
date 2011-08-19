DGSEC3 ;ALB/RMO - Purge Record of User Access from Security Log ; 22 JUN 87 1:00 pm
 ;;5.3;Registration;;Aug 13, 1993
 I '$D(^XUSEC("DG SECURITY OFFICER",DUZ)) W !!?3,*7,"You do not have the appropriate access privileges to purge user access." Q
 I '+$P(^DG(43,1,0),"^",33) W !!?3,*7,"Record of user access can not be purged from the security log." Q
ASKPAT R !!,"Select PATIENT: ",X:DTIME G Q:'$T!(X="^")!(X="") I $E(X,1,3)="ALL"!($E(X,1,3)="all") S DFN="ALL" G ASKDTE
 S DIC="^DGSL(38.1,",DIC(0)="EMQ",DGSENFLG="" D ^DIC K DGSENFLG I Y>0 S DFN=+Y G ASKDTE
 W:X'["?" *7 W !!?3,"Enter 'ALL' or a select patient to purge user access from security log." G ASKPAT
 ;
ASKDTE D H^DGUTL S DGSDFLG=+$P(^DG(43,1,0),"^",33),X1=DT,X2="-"_(DGSDFLG+1) D C^%DTC S $P(DGSDFLG,"^",2)=X
 W !!?1,*7,"Record of user access can not be purged prior to ",+DGSDFLG," day(s), please",!?1,"select a day on or before " S Y=$P(DGSDFLG,"^",2) D DT^DIQ W "." D DTRNG^DGSEC2 G Q:DGPOP
 ;
ASKPRT W !!,"Do you want to print users as they are purged" S %=2 D YN^DICN G Q:%<0 S DGPRT=$S(%=2:"QUE",1:"") I '% W !!,"Enter 'YES' to print users being purged, or 'NO' to schedule purge." G ASKPRT
 S DGPGM="PURUSR^DGSEC3",DGVAR="DFN^DGBEGDT^DGENDDT^DGPRT^DUZ" I DGPRT="" W ! D ZIS^DGUTQ G Q:POP,PURUSR
 I DGPRT="QUE" S ION="" W ! D QUE^DGUTQ G Q:X["^" S IOP="HOME" D ^%ZIS K IOP G Q
 ;
PURUSR I DGPRT="" S DGCNT=0 W !!,"Purge User Access from Security Log started " D H^DGUTL S Y=DGTIME D DT^DIQ W ".",!
 D PURSEL:DFN,PURALL:DFN="ALL" I DGPRT="" W !!,"Purge completed " D H^DGUTL S Y=DGTIME D DT^DIQ W ". ","Number of records purged: ",DGCNT
 ;
Q K DFN,DGBEGDT,DGDTE,DGENDDT,DGCNT,DGPOP,DGPGM,DGPRT,DGSDFLG,DGSL0,DGVAR,POP D CLOSE^DGUTQ
 Q
 ;
PURSEL F DGDTE=DGENDDT:0 S DGDTE=$O(^DGSL(38.1,DFN,"D",DGDTE)) Q:'DGDTE!(DGBEGDT<DGDTE)  I $D(^(DGDTE,0)) S DGSL0=^(0) D DELUSR
 Q
 ;
PURALL F DGDTE=DGENDDT:0 S DGDTE=$O(^DGSL(38.1,"AD",DGDTE)) Q:'DGDTE!(DGBEGDT<DGDTE)  F DFN=0:0 S DFN=$O(^DGSL(38.1,"AD",DGDTE,DFN)) Q:'DFN  I $D(^DGSL(38.1,DFN,"D",DGDTE,0)) S DGSL0=^(0) D DELUSR
 Q
 ;
DELUSR S DA(1)=DFN,DA=DGDTE,DIK="^DGSL(38.1,DFN,""D""," D ^DIK
 I DGPRT="" W !," ...",$S($D(^VA(200,+$P(DGSL0,"^",2),0)):$E($P(^(0),"^"),1,15),1:"Unknown")," accessed ",$S($D(^DPT(DFN,0)):$E($P(^(0),"^"),1,20),1:"Unknown")," on " S Y=$P(DGSL0,"^") D DT^DIQ S DGCNT=DGCNT+1
 Q
