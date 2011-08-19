DVBARADM ;ALB/GTS-557/THM-READMISSION REPORT ; 1/23/91  8:01 AM
 ;;2.7;AMIE;**1,17**;Apr 10, 1995
 ;
 G TERM
SORT D RCV^DVBAVDPT I $D(RONUM),$D(RO) Q:CFLOC'=RONUM&(RO="Y")
 I RCVAA S ^TMP("DVBA",$J,"A&A",DFN)=""
 I RCVPEN S ^TMP("DVBA",$J,"PEN",DFN)=""
 Q
 ;
DCHGDT S (LADMDT,LDCHGDT)="",DCHPTR=$P(^DGPM(VY,0),U,17),LADMDT=$P(^(0),U,1) I DCHPTR]"",$D(^DGPM(+DCHPTR,0)) S LDCHGDT=$P(^DGPM(+DCHPTR,0),U,1)
 Q
 ;
CAL S I="",ZI=1 F DVBAI=0:0 S I=$O(^DGPM("APID",DFN,I)) Q:I=""  F J=0:0 S J=$O(^DGPM("APID",DFN,I,J)) Q:J=""  S ZJ=$S($D(^DGPM(J,0)):^(0),1:"") I $P(ZJ,U,1)'>EDATE,$P(ZJ,U,2)=1 S ^TMP("DVBA",$J,"ADM",DFN,ZI,J)="",ZI=ZI+1
 S VX=$O(^TMP("DVBA",$J,"ADM",DFN,1,0)) Q:VX=""  S CURADMDT=$P(^DGPM(VX,0),U,1) Q:CURADMDT=""
 F VX=1:1 S VX=$O(^TMP("DVBA",$J,"ADM",DFN,VX)) Q:VX=""  F VY=0:0 S VY=$O(^TMP("DVBA",$J,"ADM",DFN,VX,VY)) Q:VY=""  D DCHGDT I CURADMDT["."&(LADMDT[".") D SET
 Q
TDIS S TDIS=$S($D(^DGPM(+DCHPTR,0)):$P(^(0),U,18),1:"") Q:TDIS=""
 S:'$D(^DG(405.2,+TDIS,0)) TDIS="Unknown discharge type" I $D(^(0)) S TDIS=$S($P(^DG(405.2,+TDIS,0),U,1)]"":$P(^(0),U,1),1:"Unknown discharge type")
 Q
 ;
SET S X1=CURADMDT,X2=LDCHGDT D ^%DTC Q:X>185
 S X2=LADMDT,X1=LDCHGDT D ^%DTC S LOS=X Q:LOS'>HOSPDAYS
 I DVBAT="A&A" DO  ;**Check last admission for A&A vet
 .S ADMDT=LADMDT
 .D ADM^DVBAVDPT,TDIS
 .I TDIS["IRREGULAR" DO  ;**Irregular discharge, set last admis info
 ..S ^TMP("DVBA",DVBAT,$J,XCN,CFLOC,VY,DFN,"LADM")=LADMDT_U_TDIS
 I $D(TDIS),(TDIS'["IRREGULAR"&(DVBAT="A&A")) Q  ;**Quit
 S ADMDT=CURADMDT
 D ADM^DVBAVDPT,TDIS
 ;**Set current admis info
 S ^TMP("DVBA",DVBAT,$J,XCN,CFLOC,VY,DFN)=CURADMDT_U_RCVAA_U_RCVPEN_U_CNUM_U_TDIS
 I DVBAT="PEN" DO  ;**Set last admis info for Pension vet 
 .S ADMDT=LADMDT
 .D ADM^DVBAVDPT,TDIS
 .S ^TMP("DVBA",DVBAT,$J,XCN,CFLOC,VY,DFN,"LADM")=LADMDT_U_TDIS
 K DVBARADQ
 S (VX,VY)=9999999
 Q
 ;
TERM D HOME^%ZIS K ^TMP("DVBA",$J),^TMP("DVBA","PEN",$J),^TMP("DVBA","A&A",$J),NOASK
 D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL
 ;
SETUP W @IOF,!,"VARO RE-ADMISSION REPORT" S DTAR=^DVB(396.1,1,0),FDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 S HEAD="RE-ADMISSION REPORT",HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0)
 W !,HEAD1
EN1 W !!,"Please enter admission dates for search, oldest date first,",!,"most recent date last.",!!,"Last report was run on " S Y=$P(DTAR,U,7) X ^DD("DD") W Y,!!
 D DATE^DVBAUTIL G:Y<0 KILL^DVBAUTIL
 S BDATE1=BDATE+.5,HEADDT="Date range: "_$$FMTE^XLFDT(BDATE1,"5DZ")_" to "_$$FMTE^XLFDT(EDATE,"5DZ")
 ;
ASK W !!,"Do you want (H)ospital or Hospital-(D)om   H// " R DVBAH:DTIME G:'$T!(DVBAH=U) KILL^DVBAUTIL
 I DVBAH="" S DVBAH="H" W DVBAH
 S:DVBAH="d" DVBAH="D"
 S:DVBAH="h" DVBAH="H"
 I DVBAH'?1"H"&(DVBAH'?1"D") W *7,!!,"Must be H for HOSPITAL or D for HOSPITAL-DOM",!! H 3 G ASK
 S HEAD=HEAD_" ("_$S(DVBAH="H":"Hospital",DVBAH="D":"Hospital-Dom",1:"Unknown selection")_")"
 S Z=$S(DVBAH="D":1,DVBAH="H":2,1:0) W $P("om^ospital",U,Z),!!
 S %ZIS("B")="0;P-OTHER",%ZIS("A")="Printing device: ",%ZIS="AEQ" D ^%ZIS G:POP KILL^DVBAUTIL
 I $D(IO("Q")) F I="NOASK","HEAD*","FDT(0)","DTAR","BDATE*","EDATE*","DVBAH" S ZTSAVE(I)=""
 I  S NOASK=1,ZTRTN="DQ^DVBARADM",ZTDESC="AMIE Re-admission Report",ZTIO=ION D ^%ZTLOAD W:$D(ZTSK) !,"Request queued.",!! G KILL^DVBAUTIL
GO I '$D(NOASK) W !!,"Looking for Pension and A&A cases ...",!!
 F DVBADT=BDATE:0 S DVBADT=$O(^DGPM("AMV1",DVBADT)) Q:DVBADT=""!(DVBADT>EDATE)  W:'$D(NOASK) "." F DFN=0:0 S DFN=$O(^DGPM("AMV1",DVBADT,DFN)) Q:DFN=""  F ADM=0:0 S ADM=$O(^DGPM("AMV1",DVBADT,DFN,ADM)) Q:ADM=""  D SORT
 I '$D(NOASK) W !!,"Examining cases found for re-admissions within 185 days ...",!!
 F DVBAT="PEN","A&A" S HOSPDAYS=$S(DVBAT="PEN"&(DVBAH="H"):89,DVBAT="PEN"&(DVBAH="D"):59,1:29) F DFN=0:0 S DFN=$O(^TMP("DVBA",$J,DVBAT,DFN)) Q:DFN=""  D CAL W:'$D(NOASK) "+"
 K ^TMP("DVBA",$J,"PEN"),^TMP("DVBA",$J,"A&A")
 I '$D(^TMP("DVBA","PEN",$J))&('$D(^TMP("DVBA","A&A",$J))) W *7,!!,"No data found for parameters entered.",!! H 2 D:$D(ZTQUEUED) KILL^%ZTLOAD G KILL^DVBAUTIL
 G ^DVBARAD1
 ;
DQ K ^TMP("DVBA",$J),^TMP("DVBA","PEN",$J),^TMP("DVBA","A&A",$J)
 G GO
