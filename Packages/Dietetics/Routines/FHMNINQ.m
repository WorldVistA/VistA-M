FHMNINQ ;Hines OIFO/JT,RTK - Dietetics Monitor Inquiry ;07/26/01  09:53
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
DATE W ! K DIC S DIC="^DPT(",DIC(0)="AEQM" D ^DIC Q:Y<0  S DFN=+Y K DIC
 I $O(^DGPM("APTT1",DFN,""))="" W !,"NO ADMISSIONS FOR THIS PATIENT!" H 2 Q
 W !,"This patient has the following admissions:",!
 S FHINDX=0 F FHI=0:0 S FHI=$O(^DGPM("APTT1",DFN,FHI)) Q:FHI'>0  D
 .S FHINDX=FHINDX+1
 .S FHLST(FHINDX)=FHI S Y=FHI D DD^%DT W !,FHINDX,?5,Y
 .Q
 D SELADM I '$G(FHADM) D EX Q
 D DEV,EX Q
 ;
EN ;
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 S PG=0,EX="" D NOW^%DTC S Y=X D DD^%DT S FHNDT=Y D HDR
 S FLG=0 I '$O(^FHPT(FHDFN,"A",FHADM,"MO",0)) D
 .W "NO MONITORS FOR THIS PATIENT" S FLG=1 Q
 Q:FLG
 S J=0 F  S J=$O(^FHPT(FHDFN,"A",FHADM,"MO",J)) Q:'J!(EX=U)  D
 .I $Y>(IOSL-4) D PG I EX=U Q
 .W !!?3,$P(^FHPT(FHDFN,"A",FHADM,"MO",J,0),U,1)
 .W !?6,"Entered: " S Y=$P(^(0),U,2) X ^DD("DD") W Y K Y
 .S Y=$P(^FHPT(FHDFN,"A",FHADM,"MO",J,0),U,5) Q:'Y
 .W ?40,"Cleared: " X ^DD("DD") W Y Q
 I IOST?1"C".E,EX'=U W ! K DIR S DIR(0)="E" D ^DIR
EX K %DT,X,Y,FHI,FHINDX,FHLST,FHADM,FHNDT,FHDFN,DFN,SSN,FLG,J
 Q
DEV ;device and queue info
 W ! K %ZIS,IOP S %ZIS="Q" D ^%ZIS Q:POP
 I '$D(IO("Q")) U IO D EN,^%ZISC Q
 S ZTRTN="EN^FHMNINQ"
 S ZTSAVE("FHI")="",ZTSAVE("FHINDX")="",ZTSAVE("FHNDT")=""
 S ZTSAVE("FHLST")="",ZTSAVE("FHADM")=""
 S ZTSAVE("DFN")="",ZTSAVE("FHDFN")=""
 S ZTDESC="Dietetics Monitor Inquiry" D ^%ZTLOAD
 D ^%ZISC K %ZIS,IOP
 Q
SELADM ;
 K DIR W ! S DIR(0)="N"
 S DIR("A")="Select Admission Date for this Patient"
 D ^DIR
 Q:$D(DIRUT)
 I Y<1!(Y>FHINDX) W !!,"Response must be no less than 1 and no greater than ",FHINDX,"." D SELADM Q
 S FHI=FHLST(Y),FHADM=$O(^DGPM("APTT1",DFN,FHI,0))
 Q
PG ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 D HDR Q
HDR ;
 W:$Y @IOF W !,FHNDT,?60,"Page: " S PG=PG+1 W PG,!!
 W $E($P(^DPT(DFN,0),U,1),1,28) S SSN=$P(^(0),U,9)
 W ?30,$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 W ?44,"Admission Date: " S Y=FHI X ^DD("DD") W Y
 W ! F Z=1:1:79 W "="
