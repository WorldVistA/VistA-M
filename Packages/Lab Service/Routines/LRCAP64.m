LRCAP64 ;DALISC/FHS - PURGE 64.1 FILE   LMIP PHASE 6
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
EN ;
 D ^LRPARAM I '$P($G(LRLABKY),U,3) W !!,"Sorry you do not have the proper security Key",!! G END
 W !!?5,"This option is used to purge data from WORKLOAD [WKLD] DATA file"
 W !,"after is has been transmitted to the national database."
ARCH ;
 W !!?10,"If you intend to archive this data, you should FIRST use Fileman"
 W !,"option TRANSFER FILE ENTRIES to move the data from the WORKLOAD [WKLD] DATA "
 W !,"file (64.1) to the ARCHIVE WORKLAD [WKLD] DATA file (64.19999)"
 W !!,"MAKE SURE THE DATA IS NOT PURGED AFTER TRANSFER WHEN USING THE"
 W !,"FILEMAN TRANSFER OPTION",!
 W !!?5,"Then copy this global [^LRO(64.19999,] to your long term storage media"
 W !,"After coping the ^LRO(64.19999) global, FILEMAN can be used to delete"
 W !,"all of the data from that file [^LRO(64.19999)]."
 W !!,"After the global has been copied, proceed with this step",!!
LRDIV ;
 K DIC S LRINST=$O(^LRO(67.9,0)) I 'LRINST W !!?10,"NO DATA IN THE FILE " G END
 S DIC="^LRO(64.1,",DIC(0)="AENMZ" D ^DIC G:Y<1 END S LRDIV=+Y
 W !?10,"Do you want a list of months in the file.",!
 S LREND=0 K DIR S DIR(0)="Y" D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIRUT)) END D:Y DIS G:$G(LREND) END
SELDIV ;
SELMT ;
 I '$O(^LRO(64.1,LRDIV,1,0)) W !!?10,"NO MONTHLY DATA IN THE FILE",! G EN
 K %DT S %DT="EAP" D ^%DT G EN:Y<1 S LRMT=$E(Y,1,5)_"00" I LRMT'<($E(DT,1,5)_"00") W !!?7,"YOU CAN ONLY DELETE PAST MONTH'S DATA ",$C(7) G SELMT
 I '$O(^LRO(64.1,LRDIV,1,LRMT)) W !!?10,"DO DATA FOR "_$$FMTE^XLFDT(LRMT) G SELMT
 ;
 W ! S DIR(0)="Y",DIR("A")="You wish to purge "_$$FMTE^XLFDT(LRMT)_" data " D ^DIR
 G END:$D(DUOUT)!($D(DTOUT))!($D(DIRUT)) I Y'=1 G EN
 W ! S DIR(0)="Y",DIR("A")="Are you very certain you wish to remove this Data " D ^DIR G EN:Y'=1
 W !!?10,"Deleting "_$$FMTE^XLFDT(LRMT)_" DATA ",!
 S DIK="^LRO(64.1,"_LRDIV_",1,",LRDA=LRMT,DA(1)=LRDIV,DA(2)=64.1 D
 . W ! F  S LRDA=$O(^LRO(64.1,LRDIV,1,LRDA)) Q:$E(LRDA,1,5)'=$E(LRMT,1,5)  S DA=LRDA I '$P($G(^(LRDA,0)),U,2) W !,$$FMTE^XLFDT(LRDA)," Not reported   NOT DELETED",$C(7) Q
 . W "." D ^DIK
 . Q
 W !!,"Data for "_$$FMTE^XLFDT(LRMT)_" deleted " G EN
 Q
DIS ;
 K %ZIS,IO("Q") S %ZIS="Q" D ^%ZIS S:POP LREND=1 Q:LREND
 I $D(IO("Q")) S ZTRTN="DISDQ^LRCAP67",ZTIO=ION,ZTDESC="Print list of Lab Monthly compiled data" D ^%ZTLOAD S LREND=1 K IO("Q") D ^%ZISC Q
 U IO
DISDQ ;
 W:$E(IOST,1,2)="C-" @IOF  W !!?20,"List of Months which have data to be purged",!!
 W ! S (LREND,LRMT)=0 F  S LRMT=$O(^LRO(64.1,LRDIV,1,LRMT)) Q:LRMT<1!($E(LRMT,1,5)=$E(DT,1,5))  D  G:$G(LREND) END I '$G(LRDATA) W !!?10,"NO DATA TO PURGE " G END
 . I ($Y+6)>IOSL D:$E(IOST,1,2)="C-" PAUSE Q:$G(LREND)
 . S LRDATA=1,LRMT=$E(LRMT,1,5)_"00" W $$FMTE^XLFDT(LRMT) S LRMT=LRMT+100 W ?($X+20) W:$X>(IOM-12) !
 W !! W:$E(IOST,1,2)="P-" @IOF S:$D(ZTQUEUED) ZTREQ="@" K IO("Q") D ^%ZISC Q
END ;
 K %ZIS,DA,DIC,DIK,DIR,DIRUT,DTOUT,DUOUT,LRAD,LRDA,LRDATA,LRDIC,LRDIV,LREND,LRINST,LRMT,ZTDESC,ZTIO,ZTQUEUED,ZTRTN D ^%ZISC
 Q
PAUSE ;
 K DIR S DIR(0)="E" D ^DIR
 S:($D(DTOUT))!($D(DUOUT))!($D(DIRUT)) LREND=1 Q:$G(LREND)
 Q
