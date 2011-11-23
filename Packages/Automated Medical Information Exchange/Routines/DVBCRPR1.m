DVBCRPR1 ;ALBANY-ISC/GTS-REPRINT C&P REPORT CONTINUED ;4/28/93
 ;;2.7;AMIE;**2,119,156**;Apr 10, 1995;Build 8
 ;
 ;  ** Entry points called only from DVBCRPRT **
 ;  ** All TAGS are entry points **
HDR S PG=PG+1
 I +$G(DVBGUI)&(PG>1) Q
 I PG>1 D HDR3^DVBCUTL2 Q
 S:ZPR'="E" TOTTIME=$$PROCDAY^DVBCUTL2(DA(1))
 S:ZPR="E" TOTTIME=$$INSFTME^DVBCUTA1(DA(1))
 S OUTTIME="Processing time: "_TOTTIME
 I (IOST?1"C-".E)!($D(DVBAON2)) W @IOF
 S:('$D(DVBAON2)) DVBAON2=""
 W !,"Date: ",DVBCDT(0),?(80-$L(PGHD)\2),PGHD,?71,"Page: ",PG,!?(80-$L(DVBCSITE)\2),DVBCSITE,!
 W ?29,"** REPRINT OF FINAL **",! W ?(80-$L(OUTTIME)\2),OUTTIME,!
 W ?(80-$L(EXHD)\2),EXHD,! F LNE=1:1:80 W "="
 K LNE S:EXHD["AGENT ORANGE" DVBCAO=1 I EXHD'["AGENT ORANGE" K DVBCAO
 D SSNOUT^DVBCUTIL
 W !!?2,"Name: ",PNAM,?56,"SSN: ",DVBCSSNO,!?51,"C-Number: ",CNUM,!?56,"DOB: " S Y=DOB X XDD W Y,!?2,"Address: ",ADR1,! W:ADR2]"" ?11,ADR2,! W:ADR3]"" ?11,ADR3,!!
 K DVBCSSNO
 W !?2,"City,State,Zip+4: ",?48,"Res Phone: ",HOMPHON,!?5,CITY,"  ",STATE,"  ",ZIP,?48,"Bus Phone: ",BUSPHON,!
 W !,"Entered active service: " S Y=EOD X XDD S:Y="" Y="Not specified" W Y,?40,"Last rating exam date: ",LREXMDT,! S Y=RAD X XDD S:Y="" Y="Not specified" W "Released active service: " W Y,!!,"Priority of exam: ",PRIO,!
 F LNE=1:1:80 W "="
 W !
 Q
 ;
UP F XIX=$Y:1:(IOSL-8) W !  ;DVBA*156 add more lines for footer padding
 Q
 ;
BOT I '$D(AUTO),$D(PRINT) D UP W ?7,"This exam has been reviewed and approved by the examining physician" W:$D(DVBCAO) !?27,"and signed by the veteran" W ".",!!,"VA Form 2507",! ;for RO
 I $D(AUTO),$D(PRINT) D UP W ?7,"Adequated by: ___________________________________     Date: _____________",!!
 I $D(AUTO),$D(PRINT) W "Physician signature: ___________________________________     Date: _____________",!!,"VA Form 2507",!
 Q
 ;
HDA S:'$D(XPG) XPG=0 S XPG=XPG+1
 I (IOST?1"C-".E)!($D(DVBAON2)) W @IOF
 S:('$D(DVBAON2)) DVBAON2=""
 W !,"Final C&P Reports for print date " S Y=DT X XDD W Y,!!,"Operator: ",$S($D(^VA(200,+DUZ,0)):$P(^(0),U,1),1:"Unknown operator"),!,"Location: ",$S($D(^DIC(4,+DUZ(2),0)):$P(^(0),U,1),1:"Unknown location"),!
 W !,"Veteran Name",?28,"SSN",?43,"C-Number",?55,"Request date",!
 F XXLN=1:1:79 W "-"
 W !!
 Q
