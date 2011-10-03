DGSCHAD1 ;ALB/MRL - PURGE SCHEDULED ADMISSIONS ; 06 May 87
 ;;5.3;Registration;;Aug 13, 1993
 D:'$D(DT) DT^DICRW S U="^" S:'$D(DTIME) DTIME=999 S IOP="HOME" D ^%ZIS K IOP
 F I=1:1 S J=$P($T(T+I),";;",2) Q:J']""  W !,J
1 W !! S X1=DT,X2=-90 D C^%DTC S X1=$E(X,1,5)_"01",X2=-1 D C^%DTC S DGPD=X_".2359",Y=X X ^DD("DD") S %DT("A")="Purge Scheduled Admissions Through What Date: ",%DT("B")=Y,%DT="EA" D ^%DT K %DT G Q:Y'>0 S Y=Y_".2359"
 I Y>DGPD W !?4,"MUST RETAIN LAST 90 DAYS OF SCHEDULED ADMISSION DATA!",*7 G 1
 I $O(^DGS(41.1,"C",0))>DGPD W !!,"NO ADMISSIONS SCHEDULED ON OR BEFORE " S Y=$P(DGPD,".",1) X ^DD("DD") W Y,".",*7 G Q
 S ION="",DGPD=Y,DGVAR="DGPD",DGPGM="S^DGSCHAD1" D QUE^DGUTQ G Q:POP U IO
Q K %DT,X1,X2,X,DGPD,Y,J,I,DGPGM,DGVAR D CLOSE^DGUTQ Q
S F DGD=0:0 S DGD=$O(^DGS(41.1,"C",DGD)) Q:'DGD!(DGD>DGPD)  F DGD1=0:0 S DGD1=$O(^DGS(41.1,"C",DGD,DGD1)) Q:DGD1'>0  I $D(^DGS(41.1,DGD1,0)) S DIK="^DGS(41.1,",DA=DGD1 D ^DIK K DIK
 G Q
T ;
 ;;This routine is designed to purge your scheduled admissions file of old data.
 ;;You will be asked to select the data through which you wish to purge.  This date
 ;;must be at least 90 days into the past.  Once the date is selected you will be
 ;;asked to confirm that you indeed wish to purge all data through that date and
 ;;the process will then commence.  This procedure is performed as a background job
 ;;therefore output device selection will not be necessary.
