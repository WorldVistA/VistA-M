DVBADSNT ;ALB/GTS-557/THM-GENERATE AMIE NOTICE OF DISCHARGE ; 1/16/91  7:37 AM
 ;;2.7;AMIE;**1,14,17,42**;Apr 10, 1995
 N DVBGUI
 S DVBGUI=0
 K ^TMP($J) G TERM
 ;
SET Q:'$D(^DPT(DFN,0))  D RCV^DVBAVDPT S ^TMP($J,XCN,CFLOC,MB,DFN)=XDA_U_XDA2_U_ADMDT_U_RCVAA_U_RCVPEN_U_CNUM
 Q
 ;
ENBROKER(Y) ;
 N DVBGUI,DVBHFS,DVBERR
 S DVBGUI=1,DVBERR=0,DVBHFS=$$HFS^DVBAB82()
 K ^TMP($J) G TERM
 Q
PRINTB S XDA=$P(DATA,U),XDA2=$P(DATA,U,2),ADMDT=$P(DATA,U,3),RCVAA=$P(DATA,U,4),RCVPEN=$P(DATA,U,5),CNUM=$P(DATA,U,6),QUIT1=1 D ADM^DVBAVDPT
 S LADM=ADM
 I '$D(^DGPM(LADM,0)) S FND=1
 I $D(^DGPM(LADM,0)) N HPAT S HPAT=$P(^DGPM(LADM,0),"^",3) I $D(^DPT(HPAT,0)) S HPAT=$P(^DPT(HPAT,0),"^") I (HPAT'=PNAM)!(ADMDT'=$P(^DGPM(LADM,0),"^")) S FND=1
 I $D(FND) N Y S Y=ADMDT D DD^%DT W !!,"Admission entry in Patient Movement File has been deleted for: ",!,?5,PNAM,?25,SSN,?35," at ",Y,!,"Contact VAMC for further information.",! K Y,FND D FUPD Q
 S DCHPTR=$P(^DGPM(LADM,0),U,17),TDIS=$S($D(^DGPM(+DCHPTR,0)):$P(^(0),U,18),1:"") I TDIS="" S TDIS="Unknown discharge type"
 S:'$D(^DG(405.2,+TDIS,0)) TDIS="Unknown discharge type" I $D(^(0)) S TDIS=$S($P(^DG(405.2,+TDIS,0),U,1)]"":$P(^(0),U,1),1:"Unknown discharge type")
 I DCHGDT="" S DCHGDT=$S($D(^DGPM(+DCHPTR,0)):$P(^(0),U),1:"")
 W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !!!!,?(80-$L(HEAD)\2),HEAD,!,?(80-$L(HEAD1)\2),HEAD1,!!
 W ?10,"Patient Name:",?26,PNAM,!!,?14,"Claim No:",?26,CNUM,!,?6,"Claim Folder Loc:",?26,CFLOC,!,?9,"Social Sec No:",?26,SSN,!,?8,"Discharge Date:",?26,$$FMTE^XLFDT(DCHGDT,"5DZ"),!
 W ?5,"Type of Discharge:",?26,TDIS,!
 D LOS^DVBAUTIL W ?8,"Length of Stay:",?26,LOS_$S(LOS="":"Discharged same day",LOS=1:" day",1:" days"),!
 W ?11,"Bed Service:",?26,BEDSEC,! S DA=DFN D ELIG^DVBAVDPT
FUPD K DA I XDA2]"",$P(^DVB(396,XDA2,0),U,9)="P" S DA=XDA2,DIE="^DVB(396,",DR="4.5////C;4.8////"_DT_";4.9////"_"Notice of Discharge" D ^DIE K DA
 I $D(DVBAD2) I DVBAD2=CFLOC!(CFLOC=376) S DIE="^DVB(396.2,",DA=XDA,DR="3///P;4///"_DT_";5////"_DUZ D ^DIE
 I DVBGUI=0 D
 . I IOST?1"C-".E W *7,!,"Press RETURN to continue or ""^"" to stop    " R ANS:DTIME S:ANS=U!('$T) QUIT=1 I '$T S DVBAQUIT=1
 S DVBAON2=""
 Q
 ;
PRINT U IO S QUIT=""
 S XCN="" F M=0:0 S XCN=$O(^TMP($J,XCN)) Q:XCN=""!(QUIT=1)  S CFLOC="" F J=0:0 S CFLOC=$O(^TMP($J,XCN,CFLOC)) Q:CFLOC=""!(QUIT=1)  D PRINT1
 I DVBGUI=1 D END^DVBAB82
 Q
PRINT1 S ADM="" F K=0:0 S ADM=$O(^TMP($J,XCN,CFLOC,ADM)) Q:ADM=""  S DFN="" F L=0:0 S DFN=$O(^TMP($J,XCN,CFLOC,ADM,DFN)) Q:DFN=""!(QUIT=1)  S DATA=^(DFN) D PRINTB
 Q
 ;
TERM D HOME^%ZIS K NOASK
 D DUZ2^DVBAUTIL I $D(DVBAQUIT) K DVBAQUIT G KILL
 ;
SETUP W @IOF,!,"NOTICE OF DISCHARGE REPORT" D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL S DTAR=^DVB(396.1,1,0),FDT(0)=$$FMTE^XLFDT(DT,"5DZ")
 S HEAD="NOTICE OF DISCHARGE",HEAD1="FOR "_$P(DTAR,U,1)_" ON "_FDT(0)
 W !,HEAD1
EN1 I DVBGUI=0 D 
 . W !!,"This program will print out any new NOTICES OF DISCHARGE,",!,"based on the hospital's discharges.",!!,"Do you want to continue" S %=2 D YN^DICN
 . I $D(%Y) I %Y["?" W !!,"Enter Y to print out the notice, N if you want to exit the program.",! G EN1
 . G:%'=1 KILL S %ZIS="Q" D ^%ZIS K %ZIS I POP G KILL
 I DVBGUI=1 D HFSOPEN^DVBAB82("DVBRP",DVBHFS,"W") I DVBERR D END^DVBAB82 Q
 ;
QUEUE I $D(IO("Q")) S ZTRTN="DEQUE^DVBADSNT",ZTIO=ION,NOASK=1,ZTDESC="AMIE NOTICE OF DISCHARGE REPORT" F I="FDT(0)","HEAD","HEAD1","NOASK","DVBAD2" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! K ZTSK G KILL
 ;
GO F XDA=0:0 S XDA=$O(^DVB(396.2,"C",DVBAD2,"R",XDA)) Q:XDA=""  I $D(^DVB(396.2,XDA,0)) S MB=^(0),DFN=$P(MB,U),ADMDT=$P(MB,U,2),MB=$P(MB,U,3) D CHK,SET I '$D(NOASK) W "."
 I '$D(^TMP($J)) U IO W !!,*7,"No data found.",!! H 2 G KILL
 D PRINT
KILL D:$D(ZTQUEUED) KILL^%ZTLOAD K DVBAON2 G KILL^DVBAUTIL
 ;
DEQUE K ^TMP($J) G GO
 ;
CHK ;pull 7131 pointer
 F XDA2=0:0 S XDA2=$O(^DVB(396,"G",ADMDT,XDA2)) Q:XDA2=""  I $D(^DVB(396,XDA2,2))&($D(^DVB(396,XDA2,0))) Q:($P(^DVB(396,XDA2,0),U,1)=DFN&($P(^DVB(396,XDA2,2),"^",10)="A"))
 Q
 ;
REPRINT D CHK,SET,PRINT G KILL
