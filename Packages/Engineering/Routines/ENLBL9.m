ENLBL9 ;(WASH ISC)/DH-Companion Listing for Equipment Labels ;11.27.96
 ;;7.0;ENGINEERING;**12,35,80,90**;Aug 17, 1993;Build 25
 ;  Print companion list (if desired)
 ;  Also asks if previously printed labels should be reprinted
EN S DIR(0)="Y",DIR("A")="New labels only",DIR("B")="YES"
 S DIR("?",1)="The system records the printing of equipment bar code labels. If you do not"
 S DIR("?",2)="wish to have labels printed again if they have already been printed at least"
 S DIR("?")="once, please enter 'YES' at this time."
 D ^DIR K DIR Q:$D(DIRUT)
 S ENEQREP=+Y
EN1 K ENEQIO W !,"Would you like a companion listing for this set of labels" S %=1 D YN^DICN Q:%=2!(%<0)  I %<1 D HLP G EN
 S %ZIS("A")="Select PRINTER for Companion Listing: ",%ZIS="NQ",%ZIS("B")="" D ^%ZIS K %ZIS I POP D ERR G EN
 I IOM<80 D HOME^%ZIS W !,*7,"Device selected must have a MARGIN WIDTH of at least 80 char.",!! G EN
 I $E(^%ZOSF("OS"),1,3)="MSM",IO=IO(0) D ^%ZISC W !,*7,"MSM sites may not send Companion List to HOME device.",!! G EN
 S ENEQIO=IO,ENEQIOSL=IOSL,ENEQIOF=IOF,ENEQION=ION,ENEQIOST=IOST,ENEQIOST(0)=IOST(0),ENEQPG=0,ENEQY=0 S:$D(IO("S")) ENEQIO("S")=IO("S") S X="N",%DT="T" D ^%DT X ^DD("DD") S ENEQDATE=Y,ENHDMRGN=79-$L(ENEQDATE)
 D HOME^%ZIS
 I $D(DUZ),$D(^VA(200,DUZ,0)) S ENEQUSER=$P(^(0),U)
 E  S ENEQUSER=""
 Q
 ;
CPRNT ;I $D(^ENG(6914,DA,3)),$P(^(3),U,10)]"" Q  ;Suppress if already printed
 ;I $F(ENEQIO,"/") S ENEQIO=$P(ENEQIO,"/",$L(ENEQIO,"/"))
 U ENEQIO I ENEQY=0!((ENEQIOSL-ENEQY)<8) D CHDR
 K EN S (ENMAN,ENMOD,ENSN,ENCAT,ENUSE,ENSER,ENLOC,ENPMN)="",ENMEN=$P(^ENG(6914,DA,0),U,2) S:$D(^ENG(6914,DA,1)) EN(1)=^(1) S:$D(^(3)) EN(3)=^(3)
 I $D(EN(1)) S ENMAN=$P(EN(1),U,4),ENMOD=$P(EN(1),U,2),ENSN=$P(EN(1),U,3),ENCAT=$P(EN(1),U,1)
 S:ENMAN]"" ENMAN=$P(^ENG("MFG",ENMAN,0),U,1) S:ENCAT]"" ENCAT=$P(^ENG(6911,ENCAT,0),U,1)
 I $D(EN(3)) S ENUSE=$P(EN(3),U,1),ENSER=$P(EN(3),U,2),ENLOC=$P(EN(3),U,5),ENPMN=$P(EN(3),U,6) S:ENUSE]"" ENUSE=$P($P(^DD(6914,20,0),U,3),";",ENUSE) I ENSER]"",$D(^DIC(49,ENSER)) S ENSER=$P(^DIC(49,ENSER,0),U,1)
 I ENLOC=+ENLOC,$D(^ENG("SP",ENLOC,0)) S ENLOC=$P(^(0),U)
 W !!,DA,?15,$E(ENMEN,1,60),!,?5,"Man: ",$E(ENMAN,1,30),?40,"Cat: ",$E(ENCAT,1,35)
 W !,?5,"Model: ",$E(ENMOD,1,28),?40,"S/N: ",$E(ENSN,1,35),!,?5,"Servc: ",$E(ENSER,1,28),?40,"Status: ",$P(ENUSE,":",2),!,?5,"Location: ",$E(ENLOC,1,25),?40,"PM#: ",ENPMN
 S ENEQY=ENEQY+6 K EN
 D:$O(^DIC(6910,1,2,0))]"" LOC1^ENLBL16
 Q
CHDR W:ENEQPG @ENEQIOF S ENEQPG=ENEQPG+1 W "COMPANION LISTING (Bar Code Labels)",?ENHDMRGN,"Page ",ENEQPG
 W !,ENEQBY W:$L(ENEQBY)<41 "  (",$S(ENEQUSER]"":$E(ENEQUSER,1,20),1:"User unknown"),")" W ?ENHDMRGN,ENEQDATE,!,"Equip ID",?15,"* Description *"
 S X="",$P(X,"-",80)="-" W !,X
 S ENEQY=0
 Q
HLP W !!,"A 'companion listing' is simply a printout on regular paper (must be at",!,"least 80 columns wide) that is intended for use in the initial application"
 W !,"of the actual bar code labels to individual equipment items. The companion",!,"listing will contain more descriptive information than can be printed"
 W !,"on the labels themselves, and will be sorted in the same order as the",!,"labels."
 Q
OPEN ;
 S IOP=ENEQION D ^%ZIS K IOP
 S ENEQIO=IO  ;HD308658
 Q
ERR W !,*7,"Device selection unsuccessful.",!
 Q
 ;ENLBL9
