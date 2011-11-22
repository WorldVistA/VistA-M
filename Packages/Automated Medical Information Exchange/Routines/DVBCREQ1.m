DVBCREQ1 ;ALB/GTS-557/THM-NEW 2507 REQUEST PRINTING ; 5/25/91  11:36 AM
 ;;2.7;AMIE;**19,29,126**;Apr 10, 1995;Build 8
 ;
START S PGHD="COMPENSATION AND PENSION EXAM REQUEST",ROHD="Requested by "_RONAME,PG=0
 D HDR
 D SSNOUT^DVBCUTIL ;** Set the value of DVBCSSNO
 W !?2,"Name: ",PNAM,?56,"SSN: ",DVBCSSNO,!?51,"C-Number: ",CNUM,!?56,"DOB: " S Y=DOB X ^DD("DD") W Y,!?2,"Address: ",ADR1,! W:ADR2]"" ?11,ADR2,! W:ADR3]"" ?11,ADR3,!!
 W ?2,"City,State,Zip+4: ",?48,"Res Phone: ",HOMPHON,!?5,CITY,"  ",STATE,"  ",ZIP,?48,"Bus Phone: ",BUSPHON,!   ;I IOST?1"C-".E D CRTBOT G:$D(GETOUT) EXIT  ;DVBA/126 comment off this code
 I $D(^DPT(DFN,.121)) I $D(DTT) D    ;DVBA/126
 .Q:$P(DTT,U,9)=""!($P(DTT,U,9)="N")
 .I $P(DTT,U,7)'="" Q:$P(DTT,U,7)>DT
 .I $P(DTT,U,8)'="" Q:$P(DTT,U,8)<DT
 .W !?2,"Temporary Address: ",TAD1,! W:TAD2]"" ?21,TAD2,! W:TAD3]"" ?21,TAD3,!
 .W ?2,"City,State,Zip+4: ",?48,"Temporary Phone: ",!?5,TCITY,"  ",TST,"  ",TZIP,?51,TPHONE,!
 I IOST?1"C-".E D CRTBOT G:$D(GETOUT) EXIT  ;DVBA/126
 W !,"Entered active service: " S Y=EOD X ^DD("DD") S:Y="" Y="Not specified" W Y,?40,"Last rating exam date: ",LREXMDT,! S Y=RAD X ^DD("DD") S:Y="" Y="Not specified" W "Released active service: " W Y,!
 F LINE=1:1:80 W "="
 S TVAR(1,0)="0,0,0,2:1,0^** Priority of exam: "_PRIO
 D WR^DVBAUTL4("TVAR")
 K TVAR
 I $D(^DVB(396.3,DA(1),5)),(+$P(^DVB(396.3,DA(1),5),U,1)>0) DO
 .I $D(DVBAINSF),($D(^DVB(396.3,$P(^DVB(396.3,DA(1),5),U,1),0))) DO
 ..S Y=$P(^DVB(396.3,$P(^DVB(396.3,DA(1),5),U,1),0),U,5) X ^DD("DD")
 ..S TVAR(1,0)="0,0,0,0,0^Date original 2507 Reported to MAS: "_Y K Y
 ..D WR^DVBAUTL4("TVAR")
 ..K TVAR
 S TVAR(1,0)="0,0,0,3:2,0^Selected exams: "
 D WR^DVBAUTL4("TVAR")
 K TVAR
 D TST^DVBCUTL3 G:($D(GETOUT)) EXIT
 W !!!!! I IOST?1"C-".E D CRTBOT G:$D(GETOUT) EXIT
 W "Current Rated disabilities:",!! D DDIS^DVBCUTL3 G:($D(GETOUT)) EXIT
 W "Other Disabilities:",!!?2,OTHDIS,!?2,OTHDIS1,!?2,OTHDIS2,!!,"General remarks:",!!
 K ^UTILITY($J,"W")
 I IOST?1"C-".E D CRTBOT G:$D(GETOUT) EXIT
 F LINE=0:0 S LINE=$O(^DVB(396.3,DA(1),2,LINE)) Q:(LINE="")!($D(GETOUT))  S X=^(LINE,0),DIWL=1,DIWF="NW" D ^DIWP I $Y>(IOSL-7),$O(^DVB(396.3,DA(1),2,LINE))]"" D BOT D:'$D(GETOUT) HDR,RMRK
 D:('$D(GETOUT)) ^DIWW
 ; **  Exit TAG **
EXIT D:('$D(GETOUT)) BOT K GETOUT,LPCNT,DVBCDX,DVBCSC,DVBCSSNO,DTT,TAD1,TAD2,TAD3,TCITY,TST,TZIP,TPHONE Q
 ;
HDR S PG=PG+1 I '$D(ONE)!(($D(ONE))&(PG>1))!(IOST?1"C-".E) W @IOF
 W !,"Date: ",DVBCDT(0),?(80-$L(PGHD)\2),PGHD,?71,"Page: ",PG,! S PRTDIV=$S($D(^DG(40.8,XDIV,0)):$P(^(0),U,1),1:"Unknown division") S PRTDIV="For "_PRTDIV_" Medical Center Division at "_$$SITE^DVBCUTL4
 W ?(80-$L(PRTDIV)\2),PRTDIV
 W !! S Y=$P(^DVB(396.3,DA(1),0),U,22) I Y]"" S Z="*** Transferred from ",Z=Z_$S($D(^DIC(4.2,+Y,0)):$P(^(0),U,1),1:"unknown site")_" ***" W ?(80-$L(Z)\2),Z,!
 W ?(80-$L(ROHD)\2),ROHD,! S RQ="Date Requested: ",Y=DTRQ X ^DD("DD") S RQ=RQ_Y W ?(80-$L(RQ)\2),RQ,! F XLN=1:1:80 W "="
 K XLN Q
 ;
CRTBOT ;  ** Write form number at bottom of CRT **
 I $P(^DVB(396.3,DA(1),0),U,23)="Y" W !?20,"** Claim folder review will be required **",!
 F LPCNT=$Y:1:(IOSL-7) W !
 W !,"VA Form 21-2507"
 D TERM^DVBCUTL3
 Q
 ;
BOT I $P(^DVB(396.3,DA(1),0),U,23)="Y" W !?20,"** Claim folder review will be required **",!
 I IOST?1"C-".E F LPCNT=$Y:1:(IOSL-6) W !
 I IOST'?1"C-".E F LPCNT=$Y:1:(IOSL-4) W !
 W !,"VA Form 21-2507"
 I IOST?1"C-".E D TERM^DVBCUTL3
 Q
 ;
RMRK W !?2,"Name: ",PNAM,?56,"SSN: ",DVBCSSNO
 W ! F XLN=1:1:80 W "="
 W !!,"General remarks (continued):",!!
 Q
