DVBHQUT ;ISC-ALBANY/PKE-stuff entry in suspense file 20 JUN 85  3:50 pm ; 9/4/87  14:43 ;
 ;;4.0;HINQ;**12,71**;03/25/92 ;Build 13
 S DVBNOWRT=""
EN W !,"Patch DVB*4.0*71 marks HINQ requests out of order due to WEBHINQ transition" Q
 Q:'$D(DUZ)  Q:DUZ<1  D:'$D(DT) DT^DICRW I 1
 I $D(DFN),+DFN S U="^",DVBP="" D BYPASS^DVBHIQD I 1
 E  Q
EN1 W !,"Patch DVB*4.0*71 marks HINQ requests out of order due to WEBHINQ transition" Q
 Q:'$D(^DPT(DFN,0))
 I '$D(DVBZ) W *7,!,"No HINQ string created entry not entered." Q
 S %=$P($H,",",2),Z=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100)
 L +^DVB(395.5,DFN):$G(DILOCKTM,3) S ^DVB(395.5,"D",DUZ,DFN,DUZ)=""
 I $D(^DVB(395.5,DFN,0)) D ENT2 I 1
 E  D ENT
 L -^DVB(395.5,DFN)
 W:'$D(DVBNOWRT) "   in HINQ suspense file" K DVBNAM,DVBNOWRT,DVBOT,J,J1,J2,J3 Q
 ;This is left over referrence
SET Q:'$D(DFN)  Q:'DFN  S U="^",X="N",%DT="T" D ^%DT S DVBTMX=Y,DVBTX=9999999-DVBTMX
 Q:'$D(^DVB(395.5,DFN,0))
 L +^DVB(395.5,DFN):$G(DILOCKTM,3) S DVBOTMX=+$P(^DVB(395.5,DFN,0),U,3),$P(^DVB(395.5,DFN,0),U,3)=DVBTMX
 I '$D(DVBMM1) S $P(^DVB(395.5,DFN,0),U,4)=$S($D(DVBSTATS):DVBSTATS,1:"")
 D KIL
 I $D(DVBIXMZ) S $P(^DVB(395.5,DFN,0),U,7,8)=DVBIXMZ_"^"_DVBTMX
 S ^DVB(395.5,"C",DVBTX,DFN)="" K:DVBTX-(9999999-DVBOTMX) ^DVB(395.5,"C",9999999-DVBOTMX,DFN) L -^DVB(395.5,DFN) K DVBOTMX,DVBTMX,DVBTX Q
KIL K:DVBSTATS'="P" ^DVB(395.5,"AD","P",DFN) I DVBSTATS="N",('$D(DVBMM1)) S ^DVB(395.5,"AC","N",DFN)="",$P(^DVB(395.5,DFN,0),U,5)="N"
 K:DVBSTATS'="N" ^DVB(395.5,"AC","N",DFN)
 Q
 ;
ENT S ^DVB(395.5,DFN,0)=DFN_"^^"_Z_"^"_"P"_"^" I +(DVBDIV) S ^(0)=^(0)_"^^^^"_DVBDIV
 S ^DVB(395.5,DFN,1,0)="^"_"395.51PA"_"^"_DUZ_"^"_1,^(DUZ,0)=DUZ_"^"_Z
 S ^DVB(395.5,DFN,"HQ")=DVBZ
 S $P(^(0),U,3,4)=DFN_"^"_($P(^DVB(395.5,0),U,4)+1),^DVB(395.5,"B",DFN,DFN)="",^DVB(395.5,"C",$E(9999999-Z,1,30),DFN)="",^DVB(395.5,"AD","P",DFN)=""
 Q
 ;
ENT2 S DVBOT=+$P(^DVB(395.5,DFN,0),U,3),$P(^(0),U,3)=Z,$P(^(0),U,4)="P" S:+(DVBDIV) $P(^(0),U,9)=DVBDIV I DVBOT'[DT S $P(^(0),U,6)=""
 I '$D(^DVB(395.5,DFN,1,0)) D BAD S ^DVB(395.5,DFN,1,0)="^"_"395.51PA"_"^"_DUZ_"^"_J2 I J3 G NXT
 I '$D(^DVB(395.5,DFN,1,DUZ,0)) S $P(^DVB(395.5,DFN,1,0),U,4)=$P(^DVB(395.5,DFN,1,0),U,4)+1
NXT S $P(^DVB(395.5,DFN,1,0),U,3)=DUZ,^(DUZ,0)=DUZ_"^"_Z,^DVB(395.5,"AD","P",DFN)="",^DVB(395.5,DFN,"HQ")=DVBZ
 K ^DVB(395.5,"C",9999999-DVBOT,DFN) S ^DVB(395.5,"C",9999999-Z,DFN)=""
 Q
 ;
BAD S (J2,J3)=0 F J1=0:0 S J1=$O(^DVB(395.5,DFN,1,J1)) Q:'J1  S J2=J2+1
 I 'J2 S (J2,J3)=1
 Q
