LRCAP67 ;DALISC/FHS - PURGE 67.9 FILE   LMIP PHASE 5
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
EN ;
 D ^LRPARAM I '$P($G(LRLABKY),U,3) W !!,"Sorry you do not have the proper security Key",!! G END
 W !!?5,"This routine is used to purge data from LAB MONTHLY WORKLOAD file"
 W !,"after it has been transmitted to the national database. It can also be used to"
 W !,"clear the file and recompute data found to be erroneous after review.",!!
ARCH ;
 W !?10,"If you intend to archive this data have your Site Manager save"
 W !,"in the appropriate manner the global, ^LRO(67.9, to desired media "
 W !,"before deleting any data.",!!
 W !?10,"Do you want a list of monthly compiled data in the file.",!
 S LREND=0 K DIR S DIR(0)="Y" D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIRUT)) END D:Y DIS G:$G(LREND) END
SELDIV ;
 K DIC S LRINST=$O(^LRO(67.9,0)) I 'LRINST W !!?10,"NO DATA IN THE FILE " G END
 S DIC="^LRO(67.9,"_LRINST_",1,",DIC(0)="AENMZ" D ^DIC G:Y<1 EN S LRDIV=+Y
SELMT ;
 I '$O(^LRO(67.9,LRINST,1,LRDIV,1,0)) W !!?10,"NO MONTHLY DATA IN THE FILE",! G EN
 K DA,DR S DIC=DIC_LRDIV_",1," D ^DIC G:Y<1 EN W !! S LRDIC=DIC,(LRDA,DA)=+Y,LRMT=$P(Y,U,2),DA(1)=LRDIV,DA(2)=LRINST,DR=0 D EN^DIQ
 S DIR(0)="Y",DIR("A")="You wish to purge "_$$FMTE^XLFDT(LRMT)_" data " D ^DIR
 G END:$D(DUOUT)!($D(DTOUT))!($D(DIRUT)) I Y'=1 G EN
 W !! S DA=LRDA,DIC=LRDIC,DA(1)=LRDIV,DA(2)=LRINST,DR=0 D EN^DIQ
 S DIR(0)="Y",DIR("A")="Are you very certain you wish to remove this Data? " D ^DIR G EN:Y'=1
 W !!?10,"Deleting "_$$FMTE^XLFDT(LRMT)_" DATA ",!
 S DIK=LRDIC D ^DIK W !!,"DATA DELETED",!! G EN
 Q
 ;
DIS ;
 K %ZIS,IO("Q") S %ZIS="Q" D ^%ZIS S:POP LREND=1 Q:LREND
 I $D(IO("Q")) S ZTRTN="DISDQ^LRCAP67",ZTIO=ION,ZTDESC="Print list of Lab Monthly compiled data" D ^%ZTLOAD S LREND=1 K IO("Q") D ^%ZISC Q
 U IO
DISDQ ;
 W:$E(IOST,1,2)="C-" @IOF
 S (LREND,LRINST)=0 F  S LRINST=$O(^LRO(67.9,LRINST)) Q:LRINST<1  D  G:$G(LREND) END I '$G(LRDATA) W !!?10,"NO DATA TO PURGE " G END
 . S LRDIV=0 F  S LRDIV=$O(^LRO(67.9,LRINST,1,LRDIV)) Q:LRDIV<1!($G(LREND))  W:$O(^LRO(67.9,LRINST,1,LRDIV,1,0)) !?30,$P(^DIC(4,LRDIV,0),U) D
 .  . S LRAD=0 F  S LRAD=$O(^LRO(67.9,LRINST,1,LRDIV,1,LRAD)) Q:LRAD<1!($G(LREND))  D
 .  .  .I ($Y+6)>IOSL D:$E(IOST,1,2)="C-" PAUSE Q:$G(LREND)  W @IOF,!!?30,$P(^DIC(4,LRDIV,0),U)
 .  .  .K DA,DIC,DR S LRDATA=1,DA=LRAD,DA(1)=LRDIV,DA(2)=LRINST,DIC="^LRO(67.9,"_DA(2)_",1,"_DA(1)_",1,",DR=0 D EN^DIQ
 W !! W:$E(IOST,1,2)="P-" @IOF S:$D(ZTQUEUED) ZTREQ="@" K IO("Q") D ^%ZISC Q
END ;
 K %ZIS,DA,DIC,DIK,DIR,DIRUT,DTOUT,DUOUT,LRAD,LRDA,LRDATA,LRDIC,LREND,LRINST,LRMT,ZTDESC,ZTIO,ZTQUEUED,ZTRTN D ^%ZISC
 Q
PAUSE ;
 K DIR S DIR(0)="E" D ^DIR
 S:($D(DTOUT))!($D(DUOUT))!($D(DIRUT)) LREND=1 Q:$G(LREND)
 Q
