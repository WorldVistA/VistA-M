DVBADSRP ;ALB/GTS-557/THM-REPRINT NOTICE OF DISCHARGE ; 1/22/91  12:05 PM
 ;;2.7;AMIE;**1,17**;Apr 10, 1995
 K ^TMP($J) G TERM
SET Q:'$D(^DPT(DA,0))  S DFN=DA D RCV^DVBAVDPT S ^TMP($J,XCN,CFLOC,MB,DA)=ADMDT_U_RCVAA_U_RCVPEN_U_CNUM
 Q
 ;
PRINTB S ADMDT=$P(DTA,U),RCVAA=$P(DTA,U,2),RCVPEN=$P(DTA,U,3),CNUM=$P(DTA,U,4),QUIT1=1,DFN=DA D ADM^DVBAVDPT
 S LADM=ADM
 I '$D(^DGPM(LADM,0)) S FND=1
 I $D(^DGPM(LADM,0)) N HPAT S HPAT=$P(^DGPM(LADM,0),"^",3) I $D(^DPT(HPAT,0)) S HPAT=$P(^DPT(HPAT,0),"^") I (HPAT'=PNAM)!(ADMDT'=$P(^DGPM(LADM,0),"^")) S FND=1
 I $D(FND) N Y S Y=ADMDT D DD^%DT W !!,"Admission entry in Patient Movement File has been deleted for: ",!,?5,PNAM,?25,SSN,?35," at ",Y,!,"Contact VAMC for further information.",! K Y,FND S DVBAON2="" Q
 S DCHPTR=$P(^DGPM(LADM,0),U,17),TDIS=$S($D(^DGPM(+DCHPTR,0)):$P(^(0),U,18),1:"") I TDIS="" S TDIS="Unknown discharge type"
 S:'$D(^DG(405.2,+TDIS,0)) TDIS="Unknown discharge type" I $D(^(0)) S TDIS=$S($P(^DG(405.2,+TDIS,0),U,1)]"":$P(^(0),U,1),1:"Unknown discharge type")
 I DCHGDT="" S DCHGDT=$S($D(^DGPM(+DCHPTR,0)):$P(^(0),U),1:"")
 W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !!!!,?(80-$L(HEAD)\2),HEAD,!,?(80-$L(HEAD1)\2),HEAD1,!!
 W ?10,"Patient Name:",?26,PNAM,!!,?14,"Claim No:",?26,CNUM,!,?6,"Claim Folder Loc:",?26,CFLOC,!,?9,"Social Sec No:",?26,SSN,!,?8,"Discharge Date:",?26,$$FMTE^XLFDT(DCHGDT,"5DZ"),!
 W ?5,"Type of Discharge:",?26,TDIS,!
 D LOS^DVBAUTIL W ?8,"Length of Stay:",?26,LOS_$S(LOS="":"Discharged same day",LOS=1:" day",1:" days"),!
 W ?11,"Bed Service:",?26,BEDSEC,! D ELIG^DVBAVDPT ;no updating required
 I IOST?1"C-".E W *7,!,"Press RETURN to continue or ""^"" to stop" R ANS:DTIME S:ANS=U!('$T) QUIT=1 I '$T S DVBAQUIT=1
 S DVBAON2=""
 Q
 ;
PRINT U IO S QUIT=""
 S XCN="" F M=0:0 S XCN=$O(^TMP($J,XCN)) Q:XCN=""!(QUIT=1)  S CFLOC="" F J=0:0 S CFLOC=$O(^TMP($J,XCN,CFLOC)) Q:CFLOC=""!(QUIT=1)  D PRINT1
 Q
PRINT1 S ADM="" F K=0:0 S ADM=$O(^TMP($J,XCN,CFLOC,ADM)) Q:ADM=""!(QUIT=1)  S DA="" F L=0:0 S DA=$O(^TMP($J,XCN,CFLOC,ADM,DA)) Q:DA=""!(QUIT=1)  S DTA=^(DA) D PRINTB
 Q
 ;
TERM D HOME^%ZIS K NOASK
 D DUZ2^DVBAUTIL I $D(DVBAQUIT) K DVBAQUIT G KILL
 ;
SETUP W @IOF,!,"* REPRINT * NOTICE OF DISCHARGE REPORT" D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL S DTAR=^DVB(396.1,1,0),FDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 S HEAD="NOTICE OF DISCHARGE REPRINT",U="^",HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0)
 W !,HEAD1
EN1 W !!,"This program will reprint NOTICES OF DISCHARGE,",!!,"Do you want to continue" S %=2 D YN^DICN
 I $D(%Y) I %Y["?" W !!,"Enter Y to reprint or N to quit.",! G EN1
 I %'=1 G KILL
ONE W !!,"Do you want only one Veteran" S %=2 D YN^DICN G:%=1 ^DVBADSR1
 I $D(%Y) I %Y["?" W !!,"Enter Y to get one VET, N for all.",! G ONE
 G:$D(DTOUT)!(%<0) KILL
 ;
ASK W ! S %DT(0)=-DT,%DT("A")="Enter ORIGINAL PROCESSING date: ",%DT="AE" D ^%DT G:Y<0 KILL S BDATE=Y K %DT
 I X["?" W !,"The date the notices were originally printed on.",! G ASK
 G:X=""!(X=U) KILL S %ZIS="AEQ",%ZIS("B")="0;P-OTHER" D ^%ZIS K %ZIS
 I POP G KILL
 ;
QUEUE I $D(IO("Q")) S ZTRTN="DEQUE^DVBADSRP",ZTIO=ION,NOASK=1,ZTDESC="AMIE NOTICE OF DISCHARGE RPT" F I="REP","DVBATYPS","BDATE","FDT(0)","HEAD","HEAD1","NOASK","DVBAD2" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued." G KILL
GO F XDA=0:0 S XDA=$O(^DVB(396.2,"C",DVBAD2,"P",XDA)) Q:XDA=""  S MB=^DVB(396.2,XDA,0),DA=$P(MB,U),ADMDT=$P(MB,U,2),MB=$P(MB,U,3) D:$P(^DVB(396.2,XDA,0),U,5)=BDATE SET I '$D(NOASK) W "."
 I '$D(^TMP($J)) U IO W !!,*7,"No data found for parameters.",!! H 2 G KILL
 D PRINT I $D(DVBAQUIT) K DVBAON2 G KILL^DVBAUTIL
 ;
KILL K DVBAON2 D:$D(ZTQUEUED) KILL^%ZTLOAD G KILL^DVBAUTIL
 ;
DEQUE K ^TMP($J) G GO
 ;
REPRINT D SET,PRINT G KILL
