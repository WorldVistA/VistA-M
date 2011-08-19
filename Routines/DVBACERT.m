DVBACERT ;ALB/GTS-557/THM-21 DAY CERT CHECKER ; 1/23/91  11:17 AM
 ;;2.7;AMIE;**5**;Apr 10, 1995
 K ^TMP($J) S DVBAMAN=""
 S HD="MANUAL 21 DAY CERTIFICATE PROCESSING" D HOME^%ZIS
 I '$D(DT) S X="T" D ^%DT S DT=Y
 W @IOF,!?(IOM-$L(HD)\2),HD,!!,"This program should be run only if the Task Manager fails.",!!!
 S %ZIS="AEQ" D ^%ZIS K %ZIS G:POP KILL
 I $D(IO("Q")) S ZTIO=ION,ZTDESC="Manual 21-day Cert program",ZTRTN="DATA^DVBACERT" F I="HD","HD1","DVBAMAN" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! G KILL
 G DATA
 ;
CHK S ADMDT=$P(^DVB(396,XDA,0),U,4),DFN=$P(^(0),U,1),STAT=$P(^(1),U,12) Q:STAT]""
 K TEMP F I=0:0 S I=$O(^DGPM("APTT1",DFN,I)) Q:I=""  F J=0:0 S J=$O(^DGPM("APTT1",DFN,I,J)) Q:J=""  S ZJ=$S($D(^DGPM(J,0)):^(0),1:"") I ZJ]"" S TEMP(+$E(I,1,14),DFN)=J_U_+$E(I,1,14)
 S DCHGDT="" I $D(TEMP(ADMDT,DFN)) D CHK1
 I DCHGDT]"" D LOS^DVBAUTIL I LOS'<21 S ^TMP($J,ADMDT,MB,DFN)=XDA_U_DCHGDT_U_$P(TEMP(ADMDT,DFN),U,2) Q  ;**Dischrgd, stay >21 days
 I DCHGDT]"" D LOS^DVBAUTIL I LOS<21 S DR="6.5////C;6.8////"_DT_";6.9////"_"Not applicable",DA=XDA,DIE="^DVB(396," D ^DIE K DA Q  ;**Dchgd, stay <21
 Q
 ;
LOOK1 S XDA=$P(^TMP($J,ADMDT,LADM,DFN),U,1),DCHGDT=$P(^(DFN),U,2) D CREATE
 Q
 ;
CHK1 S MB=$P(TEMP(ADMDT,DFN),U,1),DCHPTR=+$P(^DGPM(MB,0),U,17)
 S DCHGDT=$S($D(^DGPM(DCHPTR,0)):$P(^(0),U,1),1:"") I DCHGDT="" S DCHGDT=DT D LOS^DVBAUTIL S DCHGDT="" I LOS'<21 S ^TMP($J,ADMDT,MB,DFN)=XDA_U_DT_U_$P(TEMP(ADMDT,DFN),U,2) Q
 ;null DCHGDT/use DT if vet still in hosp
 ;** If vet not discharged, DCHGDT="" on Quit
 Q
 ;
LOOK F ADMDT=0:0 S ADMDT=$O(^TMP($J,ADMDT)) Q:ADMDT=""  F LADM=0:0 S LADM=$O(^TMP($J,ADMDT,LADM)) Q:LADM=""  F DFN=0:0 S DFN=$O(^TMP($J,ADMDT,LADM,DFN)) Q:DFN=""  D LOOK1
 Q
 ;
DATA S Y=DT X ^DD("DD") S FDT(0)=Y,CNT=0
 D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) KILL^DVBAUTIL ;for TaskMan,manual
 S DTAR=^DVB(396.1,1,0),HD1=$P(DTAR,U,1)
 U IO S NAME="" F J=0:0 S NAME=$O(^DVB(396,"B",NAME)) Q:NAME=""  F XDA=0:0 S XDA=$O(^DVB(396,"B",NAME,XDA)) Q:XDA=""  I $P(^DVB(396,XDA,0),U,7)="YES"&($P(^(0),U,13)="P") D CHK
 D LOOK ;**Loop Recs to create 21-day certs
 W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !!!,"Notice to MAS personnel on "_FDT(0),! I '$D(^TMP($J)) W !!!,"There were no 21 day certificates to print today.",!! G KILL
 W !!!,"There were "_CNT_" certificates processed on "_FDT(0),!!
 ;
KILL I $D(DVBAMAN)&($D(ZTQUEUED)) D KILL^%ZTLOAD
 K DVBAMAN,DVBAON2,^TMP($J) G KILL^DVBAUTIL
 ;
CREATE ;CERTIFICATE CREATE
 I $D(^DVB(396,XDA,2)) Q:$P(^(2),U,10)="L"
 I '$D(^DPT(DFN,0)) W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF W !!,"Patient record missing for DFN "_DFN,!! Q
 S VAINDT=$P(^TMP($J,ADMDT,LADM,DFN),U,3),VA200="" D INP^VADPT K VA200 S WARD=$P(VAIN(4),U,2) S PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9),CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown")
 S BED="Unknown" I $D(^DPT(DFN,.101)) S BED=$S($P(^(.101),U,1)]"":$P(^(.101),U,1),1:"Unknown")
 U IO
 W:(IOST?1"C-".E)!($D(DVBAON2)) @IOF
 W !,FDT(0),?32,"REPORT OF CONTACT",!,?31,"21-DAY CERTIFICATE",?(80-11),"PAGE: 1",!,?(80-$L(HD1)\2),HD1,!!!!!!!,"Patient name: ",?16,PNAM,!,?9,"SSN: ",?16,SSN,?33,"Claim #: ",?43,CNUM,!!,?9,"Ward: ",?16,WARD,?25," Bed: ",BED,!!!
 W "     The patient above has been hospitalized for 21 consecutive days ",!,"from " S Y=ADMDT X ^DD("DD") W Y," to " S Y=DCHGDT X ^DD("DD") W Y,", and the major diagnosis for",!,"this period is:",!!!!!!!!!!!!!!!!!!!!
 W "Physician signature: " F LINE=$X:1:80 W "_"
 W !!!,"        Approved by: " F LINE=$X:1:65 W "_"
 W !!?5,"ROC  119",!
 S REQDIV=$P(^DVB(396,XDA,2),"^",9)
 S DIE="^DVB(396,",DA=XDA,DR="6.5///C;6.8///"_DT_";6.9////"_"21-day certificate",NEWREQ=0 D ^DIE ;new request
 I $P(^DVB(396,XDA,0),U,9)="" S DIE="^DVB(396,",DA=XDA,DR="4///YES;4.5///P;4.6///"_REQDIV_";4.7///"_DT,NEWREQ=1 D ^DIE ;notice of dischg request
 I $P(^DVB(396,XDA,0),U,11)="" S DIE="^DVB(396,",DA=XDA,DR="5///YES;5.5///P;5.6///"_REQDIV_";5.7///"_DT,NEWREQ=1 D ^DIE ;hospital summary request
 K REQDIV
 S WWHO=$S($D(^DVB(396,XDA,2)):$P(^(2),U,8),1:"Unknown") I NEWREQ=1 S DIE="^DVB(396,",DA=XDA,DR="23///"_DT_";24///"_DT_";28///"_$E(WWHO,1,24)_"*" D ^DIE ;make new request to MAS
 ;NOTE: "*" system maintenance via this program
 S DIE="^DVB(396,",DR="6.82///N;6.86///"_DCHGDT_";6.87///"_WARD_";6.88///"_BED S DA=XDA D ^DIE S CNT=CNT+1
 S DVBAON2=""
 Q
