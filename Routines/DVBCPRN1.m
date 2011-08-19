DVBCPRN1 ;ALB/GTS-557/THM-C&P FINAL REPORT PRINT ; 9/3/91  8:05 AM
 ;;2.7;AMIE;**31**;Apr 10, 1995
 ;
PHYS S PHYS=$S($D(^DVB(396.4,DA,0)):$P(^(0),U,7),1:"")
 Q
 ;
STEP2A S EXMNM=$S($D(^DVB(396.6,JI,0)):$P(^(0),U,1),1:"Unknown exam") I $D(AUTO),$D(XEXMNM),EXMNM'=XEXMNM Q  ;print one exam on transcription
 S EXHD="For "_EXMNM_" Exam" D HDR W "Examining provider: ",PHYS,!,"Examined on: " S Y=$P(^DVB(396.4,DA,0),U,6) X XDD W Y,! F LINE=1:1:80 W "="
 W !!?2,"Examination results:",!! K NCN S EXSTAT=$P(^DVB(396.4,DA,0),U,4) I EXSTAT="X"!(EXSTAT="RX") W !!!!!?25,"This exam was CANCELLED by ",$S(EXSTAT="RX":"the RO.",1:"MAS."),!! Q
 D STEP3
 Q
 ;
STEP2 F DA=0:0 S DA=$O(^DVB(396.4,"C",DA(1),DA)) Q:DA=""  S RO=+$P(^DVB(396.3,DA(1),0),U,3) Q:'$D(AUTO)&(DUZ(2)'=RO)  S PG=0,JI=$P(^DVB(396.4,DA,0),U,3) D PHYS,STEP2A I $D(PRINT) D BOT K PRINT
 I '$D(AUTO) S %DT="TS",X="NOW" D ^%DT S DA=DA(1),CTIM=Y,DR="6////"_CTIM_";15////"_CTIM_";16////^S X=DUZ;17////C",DIE="^DVB(396.3,",DIC=DIE D ^DIE
 Q
 ;
STEP3 K ^UTILITY($J,"W") S DIWL=1,DIWR=80,DIWF="NW" S OLDA=DA,OLDA1=DA(1)
 F LINE=0:0 S LINE=$O(^DVB(396.4,OLDA,"RES",LINE)) Q:LINE=""  S X=^DVB(396.4,OLDA,"RES",LINE,0) D ^DIWP,STEP3A
 D ^DIWW S PRINT=1 S DA=OLDA,DA(1)=OLDA1 Q
 ;
STEP3A I $Y>(IOSL-11) D UP,NEXT,HDR W:$O(^DVB(396.4,OLDA,"RES",LINE))]"" !!,"Exam Results Continued",!!
 Q
 ;
HDR S PG=PG+1 I PG>1 D HDR2^DVBCUTL2 Q
 S:ZPR'="E" TOTTIME=$$PROCDAY^DVBCUTL2(DA(1))
 S:ZPR="E" TOTTIME=$$INSFTME^DVBCUTA1(DA(1))
 S OUTTIME="Processing time: "_TOTTIME
 W @IOF
 W !,"Date: ",DVBCDT(0),?(80-$L(PGHD)\2),PGHD,?71,"Page: ",PG,!?(80-$L(DVBCSITE)\2),DVBCSITE,!
 W ?35,"** FINAL **",! W ?(80-$L(OUTTIME)\2),OUTTIME,!?(80-$L(EXHD)\2),EXHD,! F LNE=1:1:80 W "="
 K LNE S:EXHD["AGENT ORANGE" DVBCAO=1 I EXHD'["AGENT ORANGE" K DVBCAO
 D SSNOUT^DVBCUTIL
 W !!?2,"Name: ",PNAM,?56,"SSN: ",DVBCSSNO,!?51,"C-Number: ",CNUM,!?56,"DOB: " S Y=DOB X XDD W Y,!?2,"Address: ",ADR1,! W:ADR2]"" ?11,ADR2,! W:ADR3]"" ?11,ADR3,!!
 K DVBCSSNO
 W !?2,"City,State,Zip+4: ",?48,"Res Phone: ",HOMPHON,!?5,CITY,"  ",STATE,"  ",ZIP,?48,"Bus Phone: ",BUSPHON,!
 W !,"Entered active service: " S Y=EOD X XDD S:Y="" Y="Not specified" W Y,?40,"Last rating exam date: ",LREXMDT,! S Y=RAD X XDD S:Y="" Y="Not specified" W "Released active service: " W Y,!!,"Priority of exam: ",PRIO,!
 F LNE=1:1:80 W "="
 W ! Q
 ;
ZTSK S PG=0,AUTO=1 K ULINE
 ;$D(AUTO)=copy for review, Vet file after approval
 I '$D(DT) S X="T" D ^%DT S DT=Y
 S XDD=^DD("DD"),Y=DT X XDD S DVBCDT(0)=Y,PGHD="Compensation and Pension Exam Report",DVBCSITE=$S($D(^DVB(396.1,1,0)):$P(^(0),U,1),1:"Site name not in file")
 S $P(ULINE,"_",70)="_",XEXMNM=EXMNM K EXMNM D VARS^DVBCUTIL,STEP2,BOT
 I '$D(EDPRT) G KILL^DVBCUTIL
 Q
 ;
UP F XIX=$Y:1:(IOSL-8) W !
 Q
 ;
NEXT W !,"Continued on next page",!,"VA Form 2507"
 Q
 ;
BOT I '$D(AUTO),$D(PRINT) D UP W ?7,"This exam has been reviewed and approved by the examining provider" W:$D(DVBCAO) !?27,"and signed by the veteran" W ".",!!,"VA Form 2507",! ;if for RO
 I $D(AUTO),$D(PRINT) D UP W ?7," Approved by: ___________________________________     Date: _____________",!!
 I $D(AUTO),$D(PRINT) W "Provider signature: ___________________________________     Date: _____________",!!,"VA Form 2507",! ;if file copy
 Q
