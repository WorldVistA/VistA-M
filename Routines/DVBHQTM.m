DVBHQTM ;ISC-ALBANY/PKE-HINQ time,sat,sun,holiday check ; 8/28/87  09:45 ; 5/10/01 10:27am
 ;;4.0;HINQ;**12,34,38**;03/25/92 
SILENT S DVBSHSS=""
EN K DVBSTOP D:'$D(DT) DT^DICRW S DVBTIM=$P($H,",",2),U="^"
 I '$D(^DVB(395,1,"HQ"))!('$D(^("HQVD"))) W:'$D(DVBSHSS) !,$C(7),"No HINQ parameters",!,"Notify system manager" S DVBSTOP="" H 3 G EX
 I '+$P(^DVB(395,1,"HQ"),U,4) W:'$D(DVBSHSS) !,$C(7),"Network is disabled     Requests may be entered in the Suspense File" S DVBSTOP="" G EX
 ;
 ;;;I $P(^DVB(395,1,"HQ"),U,1)=DT,+$P(^("HQ"),U,4) G OK
 ;
ONCE I $D(^DVB(395,1,"HQ")),$P(^("HQ"),U,1)'=DT S $P(^DVB(395,1,"HQ"),U,2)=$S($P(^("HQ"),U,1)?7N:$P(^("HQ"),U,1),1:DT) W !!! S $P(^DVB(395,1,"HQ"),U,1)=DT,$P(^DVB(395,1,"HQ"),U,9)=0
OK K DVBSTOP
EX K %Y,Y,X,D0,DA,DI,DIC,DIE,DQ,DR,DVBTIM,DVBGMT,DVBGMT2,DVBSHSS,DVBDIF,DVBZN,N QUIT
 Q
MESS S DVBSTOP="",DVBZN="CDT" G EX:$D(DVBSHSS)
 ;DVB*38 HINQ UNAVAILABLE MESSAGE  MLR 5.10.01
 W !!
 W $$CJ^XLFSTR("ATTENTION:  HINQ IS CURRENTLY UNAVAILABLE!",80,".")
 W !!,$$CJ^XLFSTR("Please enter HINQ request in Suspense File",80)
 W !,$$CJ^XLFSTR("or try again later.",80)
 W !!
 D EX
 Q  ;MESS
 ;
UP S $P(^DVB(395,1,"HQ"),"^",4)=1 W $C(7),"   Network Enabled" Q
DOWN S $P(^DVB(395,1,"HQ"),"^",4)=0 W $C(7),"   Network Disabled" Q
BUP S $P(^DVB(395,1,"HQ"),"^",5)=1 Q  ; batch processing enable
BDOWN S $P(^DVB(395,1,"HQ"),"^",5)=0 Q  ; batch processing disabled
 ;
EDIT S (DIC,DIE)="^DVB(395,",X=1,DIC(0)="" D ^DIC G EX:Y<1 S DA=+Y
 S DR="1;2;4;5;6;.05;15HINQ ALERT mail group;7;8;9;10;11New IDCU Interface;12;22;13;16;17;19;20;21"
 L +^DVB(395,1):3 I $T DO
 .D ^DIE
 E  W !?3,"HINQ parameters being edited by another user" H 1
 L -^DVB(395,1) G EX
 Q
