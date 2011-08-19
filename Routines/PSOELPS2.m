PSOELPS2 ;BIR/EJW-CPRS and Outpatient Pharmacy Status Update ;12/04/02
 ;;7.0;OUTPATIENT PHARMACY;**119,268**;DEC 1997;Build 9
 ;External reference to STATUS^ORQOR2 supported by DBIA 3458
 ;External reference to ^OR(100 supported by DBIA 3463
 ;CPRS/Outpatient status update
 ;PSOCPRS = CPRS number (Placer)
 ;PSORXNUM = Outpatient number (52 ien)
 N PSOPACRF
 D GETPACRF
 I '$D(PSOPACRF) Q
 D BMES^XPDUTL("This post-install job searches for Outpatient Pharmacy orders")
 D MES^XPDUTL("that are deleted but are Active in CPRS. If any are found")
 D MES^XPDUTL("the order in CPRS will be updated with the appropriate status.")
 D BMES^XPDUTL("The job also looks for Outpatient Pharmacy orders that are marked")
 D MES^XPDUTL("as DC'd by provider and if they really were deleted instead")
 D MES^XPDUTL("of discontinued, the CPRS order will be updated with the")
 D MES^XPDUTL("correct Stop Date.")
 D BMES^XPDUTL("This post-install also attempts to clean up a bad node in the")
 D MES^XPDUTL("PRESCRIPTION file (#52) caused if an up-arrow (^) was entered for")
 D MES^XPDUTL("the LOT# when editing a prescription.")
 D GETDATE
 S ZTRTN="EN^PSOELPS2",ZTDESC="Pharmacy/CPRS status clean up",ZTIO="",ZTSAVE("PSOPACRF")="" D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 W:$D(ZTSK)&('$D(ZTQUEUED)) !!,"Task Queued !",!
 Q
EN ;
 L +^XTMP("PSOELPS2"):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T S:$D(ZTQUEUED) ZTREQ="@" Q
 N PSOCPRS,PSORXNUM,PSOXCOM,PSOXDT,PSOIJ,PSOJJ,PSOREAS,PSOACRL,PSOPHR,PSOALC,PSOADT,PSONAT,PSOCOMM,PSOZDUZ,PSOSTART,PSOEND,PSOETEXT,PSOECT,PSOCSTAT,PSOSTA
 I '$D(PSOPACRF) D GETPACRF I '$D(PSOPACRF) Q
 I '$G(DT) S DT=$$DT^XLFDT
 D NOW^%DTC S PSOSTART=%
 S PSOECT=0,PSORX2=0
 S PSOCPRS="" F  S PSOCPRS=$O(^PSRX("APL",PSOCPRS)) Q:PSOCPRS=""  S PSORXNUM="" F  S PSORXNUM=$O(^PSRX("APL",PSOCPRS,PSORXNUM)) Q:PSORXNUM=""  D
 .I PSOCPRS'=$P($G(^PSRX(PSORXNUM,"OR1")),"^",2) Q
 .I '$D(^PSRX(PSORXNUM,0)) Q
 .D CHKARROW ; SEE IF AN EXTRA UP-ARROW IN ^PSRX(PSORXNUM,2) NODE
 .S PSOSTA=+$$STATUS^ORQOR2(PSOCPRS) I PSOSTA'=6,PSOSTA'=1 Q
 .I PSORXNUM'=$P($G(^OR(100,PSOCPRS,4)),"^") Q
 .I PSOPACRF'=$P($G(^OR(100,PSOCPRS,0)),"^",14) Q
 .S PSOCSTAT=$P($G(^PSRX(PSORXNUM,"STA")),"^")
 .I PSOSTA=6,PSOCSTAT=13 D  ; MARKED AS ACTIVE IN CPRS, DELETED IN O/P PHARMACY
 ..D GETDEL
 ..I 'PSOJJ Q
 ..D UPDCPRS
 .I PSOSTA=1,PSOCSTAT=14 D  ; MARKED AS 'DISCONTINUED BY PROVIDER' IN CPRS - CHECK FOR PREVIOUSLY DELETED IN O/P PHARMACY
 ..D GETDEL
 ..I 'PSOJJ Q
 ..D ACT
 ..D UPDCPRS
 ..S $P(^PSRX(PSORXNUM,"STA"),"^",1)=13
MAIL ;Send MailMan message upon job completion
 K PSOPACRF
 I $G(DUZ) D
 .S XMDUZ="Patch PSO*7*119 Post-Install",XMSUB="Outpatient/CPRS Status clean-up",XMY(DUZ)=""
 .D NOW^%DTC S PSOEND=%
 .S PSOETEXT(1)="The clean-up job for patch PSO*7*119 is complete."
 .S PSOETEXT(2)="The total number of mismatched statuses found were "_+$G(PSOECT)_"."
 .S PSOETEXT(3)="The total number of missing divisions were "_PSORX2_"."
 .S Y=$G(PSOSTART) D DD^%DT S PSOSTART=$G(Y)
 .S Y=$G(PSOEND) D DD^%DT S PSOEND=$G(Y)
 .S PSOETEXT(4)="The job started on "_$G(PSOSTART)_"."
 .S PSOETEXT(5)="The job ended on "_$G(PSOEND)_"."
 .S XMTEXT="PSOETEXT(" N DIFROM D ^XMD K Y,XMDUZ,XMTEXT,XMSUB
 L -^XTMP("PSOELPS2")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
GETDEL ;
 S PSOCOMM=""
 S (PSOIJ,PSOJJ,PSOPHR,PSOADT)=0 F  S PSOIJ=$O(^PSRX(PSORXNUM,"A",PSOIJ)) Q:'PSOIJ  S PSOREAS=$P($G(^(PSOIJ,0)),"^",2) I PSOREAS="D" I $P($G(^PSRX(PSORXNUM,"A",PSOIJ,0)),"^",4)=0 S PSOJJ=PSOIJ
 I 'PSOJJ Q
 S PSOACRL=$G(^PSRX(PSORXNUM,"A",PSOJJ,0)) D
 .S PSOPHR=$P(PSOACRL,"^",3),PSOALC=$P(PSOACRL,"^",5),PSOADT=$P(PSOACRL,"^"),(PSONAT,PSOCOMM)=""
 .I PSOALC["DELETED" S PSOCOMM=PSOALC
 Q
 ;
UPDCPRS ; UPDATE CPRS ENTRY WITH CORRECT STATUS AND DATE
 S PSOZDUZ=$G(DUZ) S:$G(PSOPHR) DUZ=PSOPHR D EN^PSOHLSN1(PSORXNUM,"OC","",PSOCOMM,PSONAT) S PSOECT=PSOECT+1 S DUZ=PSOZDUZ
 I '$G(PSOADT) S PSOADT=DT_".2200"
 I '$D(^XTMP("PSOELPS2")) S X1=DT,X2=+30 D C^%DTC S ^XTMP("PSOELPS2",0)=$G(X)_"^"_DT
 I $D(^OR(100,PSOCPRS,6)) S ^XTMP("PSOELPS2",$J,PSOCPRS,6)=^(6),$P(^OR(100,PSOCPRS,6),"^",3)=$E(PSOADT,1,12)
 I $D(^OR(100,PSOCPRS,3)) S ^XTMP("PSOELPS2",$J,PSOCPRS,3)=^(3),$P(^OR(100,PSOCPRS,3),"^")=$E(PSOADT,1,12)
 Q
 ;
ACT ; SET ENTRY IN ACTIVITY LOG
 N IR,J
 S IR=0 F J=0:0 S J=$O(^PSRX(PSORXNUM,"A",J)) Q:'J  S IR=J
 S IR=IR+1,^PSRX(PSORXNUM,"A",0)="^52.3DA^"_IR_"^"_IR
 D NOW^%DTC S ^PSRX(PSORXNUM,"A",IR,0)=%_"^"_"E^"_$G(DUZ)_"^0^Dc'd by mistake, resetting back to deleted"
 Q
 ;
CHKARROW ;
 N RX2
 S RX2=$G(^PSRX(PSORXNUM,2)) I RX2="" Q
 I $P(RX2,"^",9)="" D
 .I $P(RX2,"^",5)'?7N,$P(RX2,"^",6)?7N,$P(RX2,"^",7)?7N D
 ..S ^XTMP("PSOELPS2",$J,"RX2",PSORXNUM)=RX2
 ..S RX2=$P(RX2,"^",1,3)_"^"_$P(RX2,"^",5,99)
 ..S PSORX2=PSORX2+1
 ..S ^PSRX(PSORXNUM,2)=RX2
 Q
 ;
GETPACRF ;
 S DIC=9.4,DIC(0)="Z",X="OUTPATIENT PHARMACY" D ^DIC K DIC
 I +Y'>0 D  Q
 .D BMES^XPDUTL("A problem was found when trying to identify a valid Outpatient Pharmacy")
 .D BMES^XPDUTL("package reference from the PACKAGE (#9.4) file.")
 .D BMES^XPDUTL("This post-install job cannot be run until this problem is resolved.")
 .K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 S PSOPACRF=+Y
 Q
 ;
GETDATE ; GET DATE/TIME OF WHEN BACKGROUND JOB SHOULD BE RUN
 S ZTDTH=""
 S NOW=0
 D NOW^%DTC S (Y,TODAY)=% D DD^%DT
 D BMES^XPDUTL("At the following prompt, enter a starting date@time or enter NOW to")
 D MES^XPDUTL("queue the job immediately.")
 D MES^XPDUTL("If this prompting is during patch installation, you will not see what you type.")
 W ! K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Queue clean-up Job to run Date@Time: "
 D ^%DT K %DT I $D(DTOUT)!(Y<0) D MES^XPDUTL("Task will be queued to run NOW") S ZTDTH=$H,NOW=1
 I 'NOW,Y>0 D
 .S SAVEY=Y
 .D DD^%DT
 .S X=Y
 .S Y=SAVEY
ASK D BMES^XPDUTL("Task will be queued to run "_$S(NOW:"NOW",1:X)_". Is that correct?  :")
 R XX:300 S:'$T XX="Y" I $E(XX)'="Y",$E(XX)'="y",$E(XX)'="N",$E(XX)'="n" D BMES^XPDUTL(" Enter Y or N") G ASK
 I $E(XX)'="Y",$E(XX)'="y" G GETDATE
 I Y>0,ZTDTH="" S ZTDTH=Y
 I ZTDTH="" S ZTDTH=$H
 Q
