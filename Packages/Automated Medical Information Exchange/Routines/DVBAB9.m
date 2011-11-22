DVBAB9 ;ALB/SPH - CAPRI DISCHARGE REPORT ;09/06/00
 ;;2.7;AMIE;**35**;Apr 10, 1995
 ;
STRT(MSG,BDATE,EDATE,RONUM,DUZ) ;
 S DVBACEPT=1  ; Force to find all d/c types
 ;
 K ^TMP($J) G TERM
 ;
SET Q:'$D(^DPT(DA,0))  S DFN=DA,DVBASC="" D RCV^DVBAVDPT Q:CFLOC'=RONUM&(RO="Y")&(CFLOC'=0)&(CFLOC'=376)  Q:ADTYPE="S"&(DVBASC'="Y")  Q:ADTYPE="A"&(RCVAA'=1)  Q:ADTYPE="P"&(RCVPEN'="1")
 S TDIS=$S($D(^DGPM(+MB,0)):$P(^(0),U,18),1:"")
 I $D(^DG(405.2,+TDIS,0)) DO
 .I '$D(^TMP("DVBA",$J,"DUP",+TDIS)) Q
 .S TDIS=$S($P(^DG(405.2,+TDIS,0),U,1)]"":$P(^(0),U,1),1:"Unknown discharge type")
 .S ^TMP($J,XCN,CFLOC,MB,DA)=MA_U_RCVAA_U_RCVPEN_U_CNUM_U_TDIS
 .Q
 Q
 ;
PRINTB S MA=$P(DATA,U),RCVAA=$P(DATA,U,2),RCVPEN=$P(DATA,U,3),CNUM=$P(DATA,U,4),TDIS=$P(DATA,U,5),DFN=DA,QUIT1=1 D DCHGDT^DVBAVDPT
 W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !!!,?(80-$L(HEAD)\2),HEAD,!,?(80-$L(HEAD1)\2),HEAD1,!!
 W ?10,"Patient Name:",?26,PNAM,!!,?14,"Claim No:",?26,CNUM,!,?6,"Claim Folder Loc:",?26,CFLOC,!,?9,"Social Sec No:",?26,SSN,!
 W ?8,"Discharge Date:",?26,$$FMTE^XLFDT(DCHGDT,"5DZ"),!,?5,"Type of Discharge:",?26,TDIS,!
 D LOS^DVBAUTIL W ?8,"Length of Stay:",?26,LOS_$S(LOS="":"Discharged same day",LOS=1:" day",1:" days"),!
 W ?11,"Bed Service:",?26,BEDSEC,!
 W ?13,"Recv A&A?:",?26,$S(RCVAA="0":"NO",RCVAA="1":"YES",1:"Not specified"),!
 W ?14,"Pension?:",?26,$S(RCVPEN="0":"NO",RCVPEN="1":"YES",1:"Not specified"),! D ELIG^DVBAVDPT
 I IOST?1"C-".E W *7,!,"Press RETURN to continue or ""^"" to stop    " R ANS:DTIME S:ANS=U!('$T) QUIT=1 I ANS=U S DVBAQUIT=1
 S DVBAON2=""
 Q
 ;
PRINT U IO S QUIT=""
 S XCN="" F M=0:0 S XCN=$O(^TMP($J,XCN)) Q:XCN=""!(QUIT=1)  S CFLOC="" F J=0:0 S CFLOC=$O(^TMP($J,XCN,CFLOC)) Q:CFLOC=""!(QUIT=1)  D PRINT1
 Q
PRINT1 S ADM="" F K=0:0 S ADM=$O(^TMP($J,XCN,CFLOC,ADM)) Q:ADM=""!(QUIT=1)  S DA="" F L=0:0 S DA=$O(^TMP($J,XCN,CFLOC,ADM,DA)) Q:DA=""!(QUIT=1)  S DATA=^(DA) D PRINTB
 Q
 ;
TERM D HOME^%ZIS K NOASK
 ;
SETUP W @IOF,!,"VARO DISCHARGE REPORT" D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL S DTAR=^DVB(396.1,1,0),FDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 S DSRP=1,HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0) W !,HEAD1
 ;
EN1 ;W !!,"Please enter dates for search, oldest date first, most recent date last.",!!,"Last report was run on " S Y=$P(DTAR,U,4) X ^DD("DD") W Y,!!
 ;D DATE^DVBAUTIL
 ;G:X=""!(Y<0) KILL
 ;
ADTYPE ;D ADTYPE^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL
 W @IOF
 ;K DVBACEPT
 ;D EN^VALM("DVBA DISCHARGE TYPES")
 I '$D(DVBACEPT) D KILL^DVBAUTIL Q
 I '$O(^TMP("DVBA",$J,"DUP",0)) D KILL^DVBAUTIL Q
 ;
 W !!! S %ZIS="Q" D ^%ZIS K %ZIS G:POP KILL^DVBAUTIL
 ;
QUEUE I $D(IO("Q")) S ZTRTN="DEQUE^DVBADSRT",ZTIO=ION,NOASK=1,ZTDESC="AMIE DISCHARGE REPORT" F I="^TMP(""DVBA"",$J,""DUP""","ADTYPE","DVBATYPS","BDATE","BDATE1","EDATE","FDT(0)","HEAD","HEAD1","HD","RO","RONUM","NOASK" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",! G KILL
 ;
GO S MA=BDATE F J=0:0 S MA=$O(^DGPM("AMV3",MA)) Q:MA>EDATE!(MA="")  W:'$D(NOASK) "." F DA=0:0 S DA=$O(^DGPM("AMV3",MA,DA)) Q:DA=""  F MB=0:0 S MB=$O(^DGPM("AMV3",MA,DA,MB)) Q:MB=""  D SET
 I '$D(^TMP($J)) U IO W !!,*7,"No data found for parameters entered.",!! H 2 G KILL
 D PRINT I $D(DVBAQUIT) K DVBAON2 G KILL^DVBAUTIL
 ;
KILL D ^%ZISC D:$D(ZTQUEUED) KILL^%ZTLOAD S X=4 K DVBAON2 G FINAL^DVBAUTIL
 ;
DEQUE K ^TMP($J) G GO
