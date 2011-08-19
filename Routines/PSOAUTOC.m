PSOAUTOC ;BIR/SAB - auto cancel rxs on admission ;08/15/94
 ;;7.0;OUTPATIENT PHARMACY;**3,24,30,36,88,146,132,223,148,249,324,251**;DEC 1997;Build 202
 ;External reference to File #59.7 supported by DBIA 694
 ;External reference to File #55 supported by DBIA 2228
 ;External reference ^DPT(PSODFN,.1) supported by DBIA 10035
 ;External reference ^DGPM("AMV1" supported by DBIA 2249
 ;External reference ^DGPM("APTT1" supported by DBIA 2249
 ;External reference ^PSDRUG( supported by DBIA 221
 ;External reference ^PS(50.7 supported by DBIA 2223
AUTO I '$P(^PS(59.7,1,40.1),"^") W $C(7),!,"Auto cancel System Parameter must be set to 'YES'",!,"before prescriptions are discontinued."
 K %DT,DIC S DIC(0)="XZM",(DIE,DIC)="^DIC(19.2,",X="PSO AUTOCANCEL" D ^DIC
 I +Y>0 D EDIT^XUTMOPT("PSO AUTOCANCEL") G EX
 D RESCH^XUTMOPT("PSO AUTOCANCEL","","","24H","L"),EDIT^XUTMOPT("PSO AUTOCANCEL")
EX K Y,C,D,D0,DI,DQ,DA,DIE,DR,DIC,X
 Q
TASK ;TaskMan entry point
 G:'$P(^PS(59.7,1,40.1),"^") KILL S X="T-3" D ^%DT S PSOD2=Y,PSOD0=Y-.01,PSODL=Y+.3
 S PSOD=PSOD0 F  S PSOD=$O(^DGPM("AMV1",PSOD)),PSODFN=0 Q:'PSOD!(PSOD>PSODL)  F PSODFN=0:0 S PSODFN=$O(^DGPM("AMV1",PSOD,PSODFN)) Q:'PSODFN  I $G(^DPT(PSODFN,.1))]"",$O(^PS(55,PSODFN,"P",0)),'$O(^DGPM("APTT1",PSODFN,PSOD)) D CAN
 G KILL
CAN ;discontinue Rxs
 S DFN=PSODFN K VAIN D INP^VADPT I $P($G(VAIN(4)),"^"),$D(^PS(59.7,1,40.19,"B",$P($G(VAIN(4)),"^"))) Q
 I $D(^PS(55,PSODFN,0)),$P($G(^PS(55,PSODFN,0)),U,6)'=2 D EN^PSOHLUP(PSODFN)
 F PSORXJ=0:0 S PSORXJ=$O(^PS(55,PSODFN,"P",PSORXJ)) Q:'PSORXJ  I $D(^(PSORXJ,0)) S PSORX=^(0) D
 .I $D(^PSRX(PSORX,0)) S PSO0=^(0),PSO2=$G(^(2)),STA=+^("STA") I STA<11,PSO2,$P(PSO2,"^",6)'<DT,$E(PSO2,1,7)'>PSOD2!(STA=16) D
 ..S $P(^PSRX(PSORX,3),"^",5)=DT,$P(^("STA"),"^")=12,$P(^(7),"^")=1
 ..D CHKCMOP^PSOUTL(PSORX,"A")
 ..D REVERSE^PSOBPSU1(PSORX,,"DC",7)
 ..D CAN^PSOTPCAN(PSORX)
 ..D FIL^PSOCAN3
 ..;remove from hold
 ..I $G(^PSRX(PSORX,"H"))]"" D
 ...K:$P(^PSRX(PSORX,"H"),"^") ^PSRX("AH",$P(^PSRX(PSORX,"H"),"^"),PSORX) S ^PSRX(PSORX,"H")=""
 ...I '$P($G(^PSRX(PSORX,2)),"^",2),$P($G(^(3)),"^") S $P(^PSRX(PSORX,2),"^",2)=$P(^(3),"^")
 ..;Add activity record
 ..S ACNT=0 F SUB=0:0 S SUB=$O(^PSRX(PSORX,"A",SUB)) Q:'SUB  S ACNT=SUB
 ..S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(PSORX,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 ..D NOW^%DTC S ACNT=ACNT+1,^PSRX(PSORX,"A",0)="^52.3DA^"_ACNT_"^"_ACNT S ^PSRX(PSORX,"A",ACNT,0)=%_"^"_"C"_"^^"_RFCNT_"^"_"Auto Discontinued on Admission"
 ..;delete from suspense
 ..D:$O(^PS(52.5,"B",PSORX,0))
 ...I $O(^PSRX(PSORX,1,0)) S DA=PSORX,SUSD=$P($G(^PS(52.5,$O(^PS(52.5,"B",PSORX,0)),0)),"^",2) D:'$G(^PS(52.5,$O(^PS(52.5,"B",PSORX,0)),"P")) REF^PSOCAN2
 ...S DA=$O(^PS(52.5,"B",PSORX,0)),DIK="^PS(52.5," D ^DIK K DIK
 ..;remove from non-verified file
 ..I $G(^PS(52.4,PSORX,0))]"" S DIK="^PS(52.4,",DA=PSORX D ^DIK K DIK
 ..S STAT="OD",PHARMST="",COM="Auto Discontinued on Admission" D EN^PSOHLSN1(PSORX,STAT,PHARMST,COM,"A")
 ;auto-dc pending orders
 ;F PSOIORD=0:0 S PSOIORD=$O(^PS(52.41,"AOR",PSODFN,PSOIORD)) Q:'PSOIORD  F PSORD=0:0 S PSORD=$O(^PS(52.41,"AOR",PSODFN,PSOIORD,PSORD)) Q:'PSORD  D
 ;.I $P(^PS(52.41,PSORD,0),"^",3)="RF" S DA=PSORD,DIK="^PS(52.41," D ^DIK K DA,DIK Q
 ;.K ^PS(52.41,"AOR",PSODFN,PSOIORD,PSORD) S $P(^PS(52.41,PSORD,0),"^",3)="DC"
 ;.D EN^PSOHLSN(+^PS(52.41,PSORD,0),"OC","Auto Canceled on Admission","A")
 K PSORD,PSOIORD
 Q
KILL K %,%H,%T,ACNT,DA,DFN,DIRUT,DTOUT,PSO,PSO0,PSO2,PSOD,PSOD0,PSOD2,PSODFN,PSODL,PSORX,PSORXJ,PSOSD,RF,RFCNT,SUB,TM,TSKDT,VAIN,X,X1,X2,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 K ORD,PHARMST,STAT,COM S:$D(ZTQUEUED) ZTREQ="@"
 Q
SETUP ;initialize nightly Rx cost compile job
 K %DT,DIC,DTOUT S DIC(0)="XZM",DIC="^DIC(19.2,",X="PSO COSTDAY NIGHTJOB" D ^DIC
 I +Y>0 D EDIT^XUTMOPT("PSO COSTDAY NIGHTJOB") G OUT
 D RESCH^XUTMOPT("PSO COSTDAY NIGHTJOB","","","24H","L"),EDIT^XUTMOPT("PSO COSTDAY NIGHTJOB")
OUT K Y,DIC,X,PSOTM,PSOOPTN,PSOPTN,%DT,DTOUT
 Q
 ;initialize management data compile job
SETUP1 K %DT,DIC,DTOUT S DIC(0)="ZXM",DIC="^DIC(19.2,",X="PSO MGMT NIGHTLY COMPILE" D ^DIC
 I +Y>0 D EDIT^XUTMOPT("PSO MGMT NIGHTLY COMPILE") G OUT
 D RESCH^XUTMOPT("PSO MGMT NIGHTLY COMPILE","","","24H","L"),EDIT^XUTMOPT("PSO MGMT NIGHTLY COMPILE")
 K Y,DIC,X,PSOTM,DIR,PSOOPTN,PSOPTN,%DT,DTOUT
 Q
APSOD(PSODFN) ;sends mail message that date of death has been deleted
 I $G(PSODFN),$D(^PS(52.91,PSODFN,0)) D
 .I $P(^PS(52.91,PSODFN,0),"^",3),$P(^(0),"^",4)=5 D
 ..S $P(^PS(52.91,PSODFN,0),"^",3)="",$P(^PS(52.91,PSODFN,0),"^",4)=""
 ..S ^PS(52.91,"AX",DT,PSODFN)=""
 ..I $D(^PS(55,PSODFN,0)),$P($G(^PS(55,PSODFN,"PS")),"^")="" D
 ...N PSORESPS,PSORESFG,PSORESF1 S PSORESFG=0 F PSORESPS=0:0 S PSORESPS=$O(^PS(53,PSORESPS)) Q:'PSORESPS!(PSORESFG)  D
 ....S PSORESF1=$P($G(^PS(53,PSORESPS,0)),"^") S PSORESF1=$$UP^XLFSTR(PSORESF1) I PSORESF1="NON-VA" S $P(^PS(55,PSODFN,"PS"),"^")=PSORESPS,PSORESFG=1
 N DI,DA,DR,DIE,DIC,X,Y
 S ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")="",ZTSAVE("PSODFN")="",ZTRTN="MAIL^PSOAUTOC",ZTDESC="Sends Mail Message that a Date of Death was Deleted",ZTIO="" D ^%ZTLOAD
 Q
MAIL ;builds mail message
 S DIC=2,DA=PSODFN,DR=.351,DIQ="PTDOD" D EN^DIQ1 I PTDOD(2,DA,.351)]"" G EX1
 K ^TMP("PSOHLD",$J),^TMP("PSOAD",$J),TOTRX,TOTPRX
 F I=0:0 S I=$O(^PSRX("APSOD",PSODFN,I)) Q:'I  S TOTRX=$G(TOTRX)+1
 F I=0:0 S I=$O(^PS(52.41,"APSOD",PSODFN,I)) Q:'I  S TOTPRX=$G(TOTPRX)+1
 F I=0:0 S I=$O(^PS(55,PSODFN,"NVA","APSOD",I)) Q:'I  S TOTNVA=$G(TOTNVA)+1
 K I Q:'$G(TOTRX)&('$G(TOTPRX))&('$G(TOTNVA))
 S ENT=0,DFN=PSODFN D DEM^VADPT
 S ENT=ENT+1,^TMP("PSOAD",$J,ENT)=$P(^DPT(PSODFN,0),"^")_" ID#: "_VA("PID")_" DOB: "_$P(VADM(3),"^",2)
 S ENT=ENT+1,^TMP("PSOAD",$J,ENT)=" " S Y=DT D DD^%DT
 S ENT=ENT+1,^TMP("PSOAD",$J,ENT)="This patient had a Date of Death deleted on "_Y_"."
 S ENT=ENT+1,^TMP("PSOAD",$J,ENT)="When a Date of Death is entered ALL active prescriptions, pending orders, and",ENT=ENT+1,^TMP("PSOAD",$J,ENT)="Non-VA Meds are discontinued automatically. The following Outpatient"
 S ENT=ENT+1,^TMP("PSOAD",$J,ENT)="Prescriptions and/or Pending Orders should be reviewed for this patient using",ENT=ENT+1,^TMP("PSOAD",$J,ENT)="the Patient Prescription Processing option."
 S ENT=ENT+1,^TMP("PSOAD",$J,ENT)=" "
 I $G(TOTRX) S ENT=ENT+1,^TMP("PSOAD",$J,ENT)="Total number of Prescriptions found for review is "_TOTRX D
 .F I=0:0 S I=$O(^PSRX("APSOD",PSODFN,I)) Q:'I  S ^TMP("PSOHLD",$J,$P(^PSDRUG($P(^PSRX(I,0),"^",6),0),"^"),I)=I
 .S DRG="" F  S DRG=$O(^TMP("PSOHLD",$J,DRG)) Q:DRG=""  F I=0:0 S I=$O(^TMP("PSOHLD",$J,DRG,I)) Q:'I  S RX=^TMP("PSOHLD",$J,DRG,I) D
 ..S ENT=ENT+1,^TMP("PSOAD",$J,ENT)="Rx: "_$P(^PSRX(RX,0),"^")_"  Drug: "_DRG
 N PSOLPI,PSOLPIX,PSOLPIST,PSOLPND
 I $G(TOTPRX) S ENT=ENT+1,^TMP("PSOAD",$J,ENT)=" " D
 .S ENT=ENT+1,^TMP("PSOAD",$J,ENT)="Total number of Pending Orders found and reinstated is "_TOTPRX
 .F PSOLPI=0:0 S PSOLPI=$O(^PS(52.41,"APSOD",PSODFN,PSOLPI)) Q:'PSOLPI  D
 ..S $P(^PS(52.41,PSOLPI,0),"^",3)=$P(^PS(52.41,PSOLPI,"DDSTA"),";"),^PS(52.41,"AOR",PSODFN,$P(^PS(52.41,PSOLPI,"DDSTA"),";",2),PSOLPI)=""
 ..S PSOLPIX=$P($G(^PS(52.41,PSOLPI,0)),"^"),PSOLPIST=$P($G(^(0)),"^",3)
 ..I PSOLPIX D
 ...I PSOLPIST'="NW",PSOLPIST'="RNW",PSOLPIST'="RF" Q
 ...;Reset remaining cross references
 ...S PSOLPND=$G(^PS(52.41,PSOLPI,0))
 ...I $P(PSOLPND,"^",12),$P(PSOLPND,"^",13) S ^PS(52.41,"ACL",$P(PSOLPND,"^",13),$P(PSOLPND,"^",12),PSOLPI)=""
 ...I $P(^PS(52.41,PSOLPI,"INI"),"^"),$P(PSOLPND,"^",12) S ^PS(52.41,"AD",$P(PSOLPND,"^",12),$P(^PS(52.41,PSOLPI,"INI"),"^"),PSOLPI)=""
 ...I PSOLPIST="RNW",$P(PSOLPND,"^",21) S ^PS(52.41,"AQ",$P(PSOLPND,"^",21),PSOLPI)=""
 ...I PSOLPIST="RF" Q
 ...;Update CPRS with Pending order information on new and renewals
 ...D EN^PSOHLSN(PSOLPIX,"SC","IP")
 ..K ^PS(52.41,"APSOD",PSODFN,PSOLPI),ORTYP
 ..S ENT=ENT+1,ORTYP=$P(^PS(52.41,PSOLPI,0),"^",3)
 ..S MED=$S($P(^PS(52.41,PSOLPI,0),"^",9):$P(^PSDRUG($P(^PS(52.41,PSOLPI,0),"^",9),0),"^"),1:$P(^PS(50.7,$P(^PS(52.41,PSOLPI,0),"^",8),0),"^"))
 ..I $G(MED)']"" S MED="NO DRUG OR ORDERABLE ITEM FOUND"
 ..S ^TMP("PSOAD",$J,ENT)=$S(ORTYP="RF":"Refill",ORTYP="RNW":"Renew",ORTYP="HD":"On Hold",1:"New")_" Order Request  -  "
 ..S ^TMP("PSOAD",$J,ENT)=^TMP("PSOAD",$J,ENT)_"Medication: "_MED
 I $G(TOTNVA) S ENT=ENT+1,^TMP("PSOAD",$J,ENT)=" " D
 .N PSODD,MED,PSOOI,PSONVA,NVA S ENT=ENT+1,^TMP("PSOAD",$J,ENT)="Total number of Non-VA Med Orders found and reinstated is "_TOTNVA
 .F NVA=0:0 S NVA=$O(^PS(55,PSODFN,"NVA","APSOD",NVA)) Q:'NVA  D
 ..S PSOOI=$P(^PS(55,PSODFN,"NVA",NVA,0),"^"),PSODD=$P(^(0),"^",2),PLACER=$P(^(0),"^",8),LOCATION=$P(^(0),"^",12),DFN=PSODFN
 ..S MED=$S(PSODD:$P($G(^PSDRUG(PSODD,0)),"^"),1:$P(^PS(50.7,+PSOOI,0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,+PSOOI,0),"^",2),0),"^"))
 ..S $P(^PS(55,PSODFN,"NVA",NVA,0),"^",6)="",$P(^(0),"^",7)="" K ^PS(55,PSODFN,"NVA","APSOD",NVA)
 ..S ENT=ENT+1,^TMP("PSOAD",$J,ENT)="Non-VA "_MED,REIN=1,PSONVA=NVA D REIN^PSONVNEW
 ..K PSOOI,PSODD,PLACER,LOCATION,MED,REIN
 S XMDUZ=.5,XMSUB="Date of Death Deleted for "_$P(^DPT(PSODFN,0),"^")_" ("_VA("BID")_")",XMTEXT="^TMP(""PSOAD"",$J," N DIFROM
 F I=0:0 S I=$O(^XUSEC("PSORPH",I)) Q:'I  S XMY(I)=""
 D ^XMD
EX1 K ^TMP("PSOHLD",$J),XMSUB,XMTEXT,XMY,XMDUZ,^TMP("PSOAD",$J),I,TOTRX,TOTPRX,PSODFN,ENT,ORTYP,X,Y,MED,RX,PTDOD
 Q
