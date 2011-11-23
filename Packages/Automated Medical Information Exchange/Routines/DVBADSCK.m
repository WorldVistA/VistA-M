DVBADSCK ;ALB/GTS-557/THM-DISCHARGE CHECKER ;21 JUL 89
 ;;2.7;AMIE;**15,14,24,32**;Apr 10, 1995
 ;
 S DVBAMAN=""
 D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL
 S HD="MANUAL 7132 PROCESSING" D HOME^%ZIS K ^TMP($J)
DATE S %DT(0)=-DT,%DT="AE",%DT("A")="Enter BEGINNING date: "
 W @IOF,!?(IOM-$L(HD)\2),HD,!!!
 D ^%DT G:Y<0 KILL S (BDATE,BDATE1)=Y,BDATE=BDATE-.1
 S %DT("A")="     and ENDING date: ",%DT="AE" D ^%DT G:Y<0 DATE S (EDATE1,EDATE)=Y,EDATE=EDATE+.5
 I EDATE<BDATE W *7,!!,"Invalid date sequence." H 3 G DATE
 K %DT S Y=DT X ^DD("DD") S FDT(0)=Y
 W !! S %ZIS="AEQ",%ZIS("A")="Enter output device: " D ^%ZIS K %ZIS G:POP KILL
 I $D(IO("Q")) S ZTRTN="DATA^DVBADSCK",ZTIO=ION,NOASK=1,ZTDESC="AMIE Discharge Checker" F I="BDATE*","EDATE*","FDT(0)","HD","NOASK","DVBAMAN" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",! G KILL
 G DATA
 ;
ZTM D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL
 I '$D(DT) S X="T" D ^%DT S DT=Y
 S Y=DT X ^DD("DD") S FDT(0)=Y
 K ^TMP($J) S X="T-1" D ^%DT Q:Y<0  S (BDATE,BDATE1)=Y,BDATE=Y-.1,(EDATE1,EDATE)=Y,EDATE=Y+.5 G DATA
 ;
CHK ;* Find the IFN of the 7131 which matches the admission date (If a 7131
 ;*  exists).
 F XDA=0:0 S XDA=$O(^DVB(396,"B",DFN,XDA)) Q:XDA=""  I $P($G(^DVB(396,XDA,0)),U,4)=ADMDT&($P($G(^DVB(396,XDA,2)),U,10)="A") Q
 QUIT
 ;
SET ;* Set up TMP global of admissions for discharges within range
 S DFN=DA,VAINDT=$S($D(^DGPM(+MB,0)):$P(^(0),U,1),1:""),VAINDT=VAINDT-.000002,VA200="" D INP^VADPT K VA200 S ADMDT=$P(VAIN(7),U,1),ADMNUM=VAIN(1)
 ;I ADMDT]"" S ADMDT=$P(ADMDT,".",1)
 Q:ADMDT=""  S ^TMP($J,ADMDT,+ADMNUM,DA)=""
 Q
 ;
SET1 ;* Get the discharge type and execute CREATE and CREAT1 as needed
 S DCHPTR=$P(^DGPM(LADM,0),U,17),TDIS=$S($D(^DGPM(+DCHPTR,0)):$P(^(0),U,18),1:"") I TDIS="" S TDIS="Unknown discharge type"
 S:'$D(^DG(405.2,+TDIS,0)) TDIS="Unknown discharge type" I $D(^(0)) S TDIS=$S($P(^DG(405.2,+TDIS,0),U,1)]"":$P(^(0),U,1),1:"Unknown discharge type")
 I XDA]"",$D(^DVB(396,XDA,0)) D CREATE Q
 I TDIS["DEATH"!(TDIS["TO CNH") D CREAT1
 Q
 ;
LOOK ;* Loop through Admission Date TMP global execute CHK and SET1
 K MA,DA,MB F ADMDT=0:0 S ADMDT=$O(^TMP($J,ADMDT)) Q:ADMDT=""  F LADM=0:0 S LADM=$O(^TMP($J,ADMDT,LADM)) Q:LADM=""  F DFN=0:0 S DFN=$O(^TMP($J,ADMDT,LADM,DFN)) Q:DFN=""  D CHK,SET1
 Q
 ;
DATA U IO W:(IOST?1"C-".E) @IOF
 W !,"Notices of discharge created on "_FDT(0)_" for discharge date range " S Y=$P(BDATE1,".",1) X ^DD("DD") W Y," TO " S Y=$P(EDATE1,".",1) X ^DD("DD") W Y,!!!
 W "Name",?35,"SSN",?50,"Admission date",! F LINE=1:1:IOM W "-"
 ;
 ;* Set up XRO array containing regional office station numbers
 ;*  contained in the AMIE Site Parameter File
 ;
 F I=0:0 S I=$O(^DVB(396.1,1,1,I)) Q:I=""!(+I=0)  S J=$P(^(I,0),U,1),J=$S($D(^DIC(4,+J,99)):$P(^(99),U),1:"") I J]"" S XRO(J)=""
 ;
 ;* Loop through Discharges ("AMV3") within entered date range DO SET
 ;*  when a discharge is found
 ;
 W !! S COUNT=0,MA=BDATE F J=0:0 S MA=$O(^DGPM("AMV3",MA)) Q:$P(MA,".")>EDATE!(MA="")  F DA=0:0 S DA=$O(^DGPM("AMV3",MA,DA)) Q:DA=""  F MB=0:0 S MB=$O(^DGPM("AMV3",MA,DA,MB)) Q:MB=""  I MA'>EDATE D SET
 ;
 ;* Loop through admission date TMP global
 ;
 D LOOK W @IOF,!!!,"Notice to MAS operator on ",FDT(0),!!! I '$D(NEW) W "There were no NOTICES OF DISCHARGE to create.",!!!
 I $D(NEW) W "There ",$S(COUNT=1:"was ",1:"were ")_COUNT_$S(COUNT=1:" notice",1:" notices")_" of discharge created.",!!!
 ;
KILL I $D(DVBAMAN)&($D(ZTQUEUED)) D KILL^%ZTLOAD
 K NEW,COUNT,XRO G KILL^DVBAUTIL
 ;
CREATE ;create notice
 ;* If a Notice of Discharge is requested on 7131, created it
 I $D(^DVB(396,XDA,2)) Q:$P(^(2),U,10)="L"
 Q:$P(^DVB(396,XDA,0),U,5)'="YES"  Q:$P(^(0),U,9)'="P"
 S XADMDT=$P(^DVB(396,XDA,0),U,4) Q:ADMDT'=XADMDT
CREAT1 Q:'$D(^DPT(DFN,0))  D ADM^DVBAVDPT
 I $G(CFLOC)="" Q   ;No station # for a claim folder location.
 I '$D(XRO(CFLOC))&(CFLOC'=376) Q  ;not a user RO
 I CFLOC=376,TDIS["DEATH" S CFLOC=$O(XRO(0)) Q:CFLOC=""
 Q:$D(^DVB(396.2,"D",ADMDT,DFN))  ;quit if one for admit date exists
 S (DIC,DIE)="^DVB(396.2,",DR="3.5///"_CFLOC_";1///"_ADMDT_";2///"_LADM_";3///R" S DLAYGO=396.2,DIC(0)="QLM",X=""""_SSN_"""" D ^DIC Q:+Y<0  S DA=+Y D ^DIE S NEW=1,COUNT=COUNT+1 K DLAYGO
 W PNAM,?35,SSN S Y=ADMDT X ^DD("DD") W ?50,Y,?70,TDIS,!
 Q
 ;
DOC ;XADMDT=admission date on 7131
 ;XDA=7131 file pointer--not all patients will have it
 ;DA=patient file pointer
 ;MB,LADM=admission pointers
 ;NOTE: DEATH,TO CNH discharges will NOT record discharge dates
