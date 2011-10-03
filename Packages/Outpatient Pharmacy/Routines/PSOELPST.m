PSOELPST ;BIR/RTR-Status update ;11/27/01
 ;;7.0;OUTPATIENT PHARMACY;**86**;DEC 1997
 ;External reference to STATUS^ORQOR2 supported by DBIA 3458
 ;External reference to ^OR(100 supported by DBIA 3463
 ;CPRS/Outpatient status update
 ;PSOCPRS = CPRS number (Placer)
 ;PSORXNUM = Outpatient number (52 ien)
 I '$G(XPDENV) Q
 N PSOPACRF
 S DIC=9.4,DIC(0)="Z",X="OUTPATIENT PHARMACY" D ^DIC K DIC I +Y'>0 W !!,"A problem was found when trying to identify a valid Outpatient Pharmacy",!,"package reference from the PACKAGE (#9.4) file." D  S XPDQUIT=2 Q
 .W !,"This Patch cannot be installed until this problem is resolved.",!
 .K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 S PSOPACRF=+Y
 W !,"This patch queues a job to find Outpatient Pharmacy orders that are expired or",!,"Discontinued, but are Active in CPRS. This patch will update the order in CPRS",!,"with the appropriate status."
 W ! K ZTDTH S ZTRTN="EN^PSOELPST",ZTDESC="Pharmacy/CPRS status clean up",ZTIO="",ZTSAVE("PSOPACRF")="" D ^%ZTLOAD I '$G(ZTSK) D  S XPDQUIT=2
 .W !!,"Since this job was not queued, the patch will not be installed.",! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 Q
EN ;
 N PSOCPRS,PSORXNUM,PSOXCOM,PSOXDT,PSOIJ,PSOJJ,PSOREAS,PSOACRL,PSOPHR,PSOALC,PSOADT,PSONAT,PSOCOMM,PSOZDUZ,PSOELSTA,PSOELSTP,PSOETEXT,PSOECT,PSOCSTAT
 I '$G(DT) S DT=$$DT^XLFDT
 D NOW^%DTC S PSOELSTA=%
 S PSOECT=0
 S PSOCPRS="" F  S PSOCPRS=$O(^PSRX("APL",PSOCPRS)) Q:PSOCPRS=""  S PSORXNUM="" F  S PSORXNUM=$O(^PSRX("APL",PSOCPRS,PSORXNUM)) Q:PSORXNUM=""  D
 .I PSOCPRS'=$P($G(^PSRX(PSORXNUM,"OR1")),"^",2) Q
 .I '$D(^PSRX(PSORXNUM,0)) Q
 .I +$$STATUS^ORQOR2(PSOCPRS)'=6 Q
 .I PSORXNUM'=$P($G(^OR(100,PSOCPRS,4)),"^") Q
 .I PSOPACRF'=$P($G(^OR(100,PSOCPRS,0)),"^",14) Q
 .S PSOCSTAT=$P($G(^PSRX(PSORXNUM,"STA")),"^")
 .I PSOCSTAT=11 D  Q
 ..I $P(^PSRX(PSORXNUM,0),"^",19)=2 S $P(^(0),"^",19)=1
 ..S PSOXCOM="Prescription past expiration date" D EN^PSOHLSN1(PSORXNUM,"SC","ZE",PSOXCOM) S PSOECT=PSOECT+1
 ..S PSOXDT=$S($P($G(^PSRX(PSORXNUM,2)),"^",6):$E($P($G(^(2)),"^",6),1,7),1:DT)_".2200"
 ..I $D(^OR(100,PSOCPRS,3)) S $P(^(3),"^")=PSOXDT
 .I PSOCSTAT=12!(PSOCSTAT=14)!(PSOCSTAT=15) D
 ..S (PSOIJ,PSOJJ,PSOPHR,PSOADT)=0 F  S PSOIJ=$O(^PSRX(PSORXNUM,"A",PSOIJ)) Q:'PSOIJ  S PSOREAS=$P($G(^(PSOIJ,0)),"^",2) I PSOREAS="C"!(PSOREAS="L") S PSOJJ=PSOIJ
 ..I PSOJJ S PSOACRL=$G(^PSRX(PSORXNUM,"A",PSOJJ,0)) D
 ...S PSOPHR=$P(PSOACRL,"^",3),PSOALC=$P(PSOACRL,"^",5),PSOADT=$P(PSOACRL,"^"),(PSONAT,PSOCOMM)=""
 ...I PSOALC["Renewed" S PSOCOMM="Renewed by Pharmacy"
 ...I PSOALC["Auto Discontinued" S PSOPHR="",PSONAT="A",PSOCOMM=$E($P(PSOALC,".",2),2,99) S:PSOCOMM="" PSOCOMM=PSOALC
 ...I PSOALC["Discontinued During" S PSOCOMM="Discontinued by Pharmacy"
 ..I 'PSOJJ S PSOCOMM="Discontinued by Pharmacy",PSONAT=""
 ..S PSOZDUZ=$G(DUZ) S:$G(PSOPHR) DUZ=PSOPHR D EN^PSOHLSN1(PSORXNUM,"OD",$S(PSOCSTAT=15:"RP",1:""),PSOCOMM,PSONAT) S PSOECT=PSOECT+1 S DUZ=PSOZDUZ
 ..I '$G(PSOADT) S PSOADT=DT_".2200"
 ..I $D(^OR(100,PSOCPRS,6)) S $P(^(6),"^",3)=$E(PSOADT,1,12)
 ..I $D(^OR(100,PSOCPRS,3)) S $P(^(3),"^")=$E(PSOADT,1,12)
MAIL ;Send mail message upon job completion
 K PSOPACRF
 I $G(DUZ) D
 .S XMDUZ="Patch PSO*7*86 Patch Install",XMSUB="Outpatient/CPRS Status clean-up",XMY(DUZ)=""
 .D NOW^%DTC S PSOELSTP=%
 .S PSOETEXT(1)="The tasked job for patch PSO*7*86 is complete."
 .S PSOETEXT(2)="The total number of mismatched statuses found were "_+$G(PSOECT)_"."
 .S Y=$G(PSOELSTA) D DD^%DT S PSOELSTA=$G(Y)
 .S Y=$G(PSOELSTP) D DD^%DT S PSOELSTP=$G(Y)
 .S PSOETEXT(3)="The job started on "_$G(PSOELSTA)_"."
 .S PSOETEXT(4)="The job ended on "_$G(PSOELSTP)_"."
 .S XMTEXT="PSOETEXT(" N DIFROM D ^XMD K Y,XMDUZ,XMTEXT,XMSUB
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
