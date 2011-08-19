DVBHQPU ;ISC-ALBANY/PKE-Purge Hinq suspense file ; 04 OCT 85  12:46 pm
 ;;V4.0;HINQ;**18**;03/25/92 
ASK ;
 W !!,"Entries in the HINQ Suspense file before the last 30 days",!,"will be deleted  ",!!,"Do You wish to continue  "_$C(7) S %=2 D YN^DICN G EX:%'=1
 S DVBSTOP="" Q
EN W !!,"When you enter a date all entries in the HINQ Suspense",!,"file before that date will be deleted",!!,"DO you wish to continue  "_$C(7) S %=2 D YN^DICN G EX:%'=1
 ;
 W ! S X="T-1",%DT="" D DAT S %DT("A")="Enter the oldest date to retain in the HINQ Suspense file ? ",%DT(0)=-DVBSTOP,%DT="AEPX" D ^%DT K %DT(0) G EX:Y<0 S DVBSTOP=Y D QUE G EX
 Q
7 S X="T-7",%DT="" W:'$D(ZTSK) # D DAT,QUE Q
30 S X="T-30",%DT="" W:'$D(ZTSK) # S DVBALERT=1 D DAT,QUE Q
DAT S U="^" D ^%DT S DVBDAY=9999999-Y,DIK="^DVB(395.5,"
 Q
LAST S DIK="^DVB(395.5,"
 I $D(^DVB(395,1,"HQ")),+$P(^("HQ"),U,2) S DVBDAY=9999999-$P(^("HQ"),U,2)
 E  S X="T-2",%DT="" D ^%DT Q:Y<0  S DVBDAY=9999999-Y
 ;
QUE F CT=0:0 S DVBDAY=$O(^DVB(395.5,"C",DVBDAY)) Q:'DVBDAY  F DFN=0:0 S DFN=$O(^DVB(395.5,"C",DVBDAY,DFN)) Q:'DFN  Q:'$D(^DVB(395.5,DFN,0))  S DA=DFN D 1,^DIK,KALERT:$D(DVBALERT) S CT=CT+1 W:'$D(ZTSK) "."
 W:'$D(ZTSK) !!,?9,CT,"  Entries deleted from suspense file",$C(7)
EX K DFN,DA,DIE,DIC,DIK,ZTSK,%,%Y,DVBSTOP,DVBDAY,%DT,%DT(0),%DT("A"),X,Y,DIC(0),CT,DR,DVBALERT QUIT
 ;
1 S Y=$P(^DVB(395.5,DFN,0),U,3) D DD^%DT W:'$D(ZTSK) !,$S($D(^DPT(DFN,0)):$P(^(0),U),1:DFN),?30,Y
 Q
 ;
KALERT ;kills off any alerts associated with this HINQ.  This is only intended
 ;to be used with the 30 day purging date.  This should not be changed
 ;by the sites.
 D MAILGP^DVBHT2,REQUSR^DVBHT2
 S XQAID="DVB,"_DFN,XQAKILL=0
 D DELETEA^XQALERT
 K XQAID,XQAKILL
 Q
