PSSLDOSE ;BIR/RTR-Local Possible Dosages Report ;06/22/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/07;Build 67
 ;
 ;External reference to PS(50.607 supported by DBIA 2221
 ;
EN ;
 W !!,"This report will print Local Possible Dosage information only for Drugs for"
 W !,"which Dosage Checks can be performed. Drugs that are inactive, marked and/or"
 W !,"classed as supply items, not matched to NDF or excluded from dosage checks (due"
 W !,"to dosage form or VA Product override) will not be included in this report."
 W !!,"Users will be able to print Local Possible Dosage information for all eligible"
 W !,"drugs or only for drugs with missing data in the Numeric Dose and Dose Unit"
 W !,"fields. These two fields must be populated to perform Dosage Checks for a Local"
 W !,"Possible Dosage selected when placing a Pharmacy order."
 N DIR,PSSKZTPE,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IOP,%ZIS,POP,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 K DIR S DIR(0)="SO^A:ALL LOCAL POSSIBLE DOSAGES;O:ONLY LOCAL POSSIBLE DOSAGE WITH MISSING DATA",DIR("A")="Enter 'A' for All, 'O' for Only",DIR("B")="O"
 S DIR("?")=" ",DIR("?",1)="Enter 'A' to see All Local Possible Dosages, regardless of whether or not the ",DIR("?",2)="associated Numeric Dose and Dose Unit fields are populated. Enter 'O' to see"
 S DIR("?",3)="only those Local Possible Dosages with missing data in either the Numeric Dose",DIR("?",4)="or Dose Unit fields. The two fields must be populated if Dosage Checks are"
 S DIR("?",5)="to be performed when this Local Possible Dosage is selected when placing a",DIR("?",6)="Pharmacy order."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 I Y'="A",Y'="O" D MESS K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 S PSSKZTPE=Y
 W !!,"This report is designed for 132 column format!",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP)>0 D MESS K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,IOP,%ZIS,POP Q
 I $D(IO("Q")) S ZTRTN="START^PSSLDOSE",ZTDESC="Local Possible Dosages Report",ZTSAVE("PSSKZTPE")="" D ^%ZTLOAD K %ZIS W !!,"Report queued to print.",! D  Q
 .K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 ;
 ;
START ;Print Local Possible Dosages Report
 U IO
 N PSSKZDEV,PSSKZCT,PSSKZOUT,PSSKZLIN,PSSKZNOF,PSSKZNM,PSSKZIEN,PSSKZOK,PSSKZDAT,PSSKZLIP,PSSKZND1,PSSKZND3,PSSKZZR,PSSKZNDF,PSSKZDF,PSSKZDT1,PSSKZLP1
 N PSSKZNFL,PSSKZMSG,PSSKZSTR,PSSKZUNT,PSSKZUNZ,PSSKZAPU,PSSKZ1,PSSKZ2,PSSKZ3,PSSKZLD5,PSSKZLD6,PSSKZLD7,PSSKZNN1,PSSKZNN2
 S (PSSKZOUT,PSSKZNOF)=0,PSSKZDEV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSKZCT=1
 K PSSKZLIN S $P(PSSKZLIN,"-",130)=""
 D HD
 S PSSKZNM="" F  S PSSKZNM=$O(^PSDRUG("B",PSSKZNM)) Q:PSSKZNM=""!(PSSKZOUT)  F PSSKZIEN=0:0 S PSSKZIEN=$O(^PSDRUG("B",PSSKZNM,PSSKZIEN)) Q:'PSSKZIEN!(PSSKZOUT)  D
 .K PSSKZOK,PSSKZDAT,PSSKZLIP,PSSKZZR,PSSKZNDF,PSSKZDF,PSSKZDT1,PSSKZLP1,PSSKZNFL,PSSKZMSG,PSSKZSTR,PSSKZUNT,PSSKZUNZ,PSSKZAPU,PSSKZ1,PSSKZ2,PSSKZ3,PSSKZND1,PSSKZND3
 .S PSSKZZR=$G(^PSDRUG(PSSKZIEN,0))
 .S PSSKZSTR=$P($G(^PSDRUG(PSSKZIEN,"DOS")),"^"),PSSKZUNT=$P($G(^PSDRUG(PSSKZIEN,"DOS")),"^",2)
 .S PSSKZSTR=$S($E(PSSKZSTR,1)=".":"0"_PSSKZSTR,1:PSSKZSTR)
 .I PSSKZUNT S PSSKZUNZ=$P($G(^PS(50.607,+PSSKZUNT,0)),"^")
 .S PSSKZNFL=$S($P(PSSKZZR,"^",9):1,1:0),PSSKZMSG=$P(PSSKZZR,"^",10)
 .S PSSKZAPU=$P($G(^PSDRUG(PSSKZIEN,2)),"^",3)
 .S PSSKZND1=$P($G(^PSDRUG(PSSKZIEN,"ND")),"^"),PSSKZND3=$P($G(^PSDRUG(PSSKZIEN,"ND")),"^",3)
 .S PSSKZOK=$$TEST
 .I 'PSSKZOK Q
 .S PSSKZDAT=0 F PSSKZLIP=0:0 S PSSKZLIP=$O(^PSDRUG(PSSKZIEN,"DOS2",PSSKZLIP)) Q:'PSSKZLIP!(PSSKZDAT)  I $P($G(^PSDRUG(PSSKZIEN,"DOS2",PSSKZLIP,0)),"^")'="" S PSSKZDAT=1
 .I 'PSSKZDAT Q
 .S PSSKZDT1=0 I PSSKZTPE="O" F PSSKZLP1=0:0 S PSSKZLP1=$O(^PSDRUG(PSSKZIEN,"DOS2",PSSKZLP1)) Q:'PSSKZLP1!(PSSKZDT1)  I $P($G(^PSDRUG(PSSKZIEN,"DOS2",PSSKZLP1,0)),"^")'="" D
 ..I '$P($G(^PSDRUG(PSSKZIEN,"DOS2",PSSKZLP1,0)),"^",5)!($P($G(^PSDRUG(PSSKZIEN,"DOS2",PSSKZLP1,0)),"^",6)="") S PSSKZDT1=1
 .I PSSKZTPE="O",'PSSKZDT1 Q
 .S PSSKZNOF=1
 .W !!!,"("_PSSKZIEN_")",?19,$P(PSSKZZR,"^")_$S(PSSKZNFL:"  *N/F*",1:"")
 .I ($Y+5)>IOSL D HD Q:PSSKZOUT
 .I PSSKZMSG'="" W !?12,PSSKZMSG
 .I ($Y+5)>IOSL D HD Q:PSSKZOUT
 .W !?12,"Strength: "_PSSKZSTR W ?43,"Units: " I $G(PSSKZUNZ)'="" W $G(PSSKZUNZ)
 .I $G(PSSKZUNZ)'="",$L(PSSKZUNZ)>15 W !
 .;I ($Y+5)>IOSL D HD Q:PSSKZOUT
 .W ?66,"Application Package: "_PSSKZAPU
 .I ($Y+5)>IOSL D HD Q:PSSKZOUT
 .S PSSKZ3=0 W !?4,"Local Possible Dosages: " F PSSKZ1=0:0 S PSSKZ1=$O(^PSDRUG(PSSKZIEN,"DOS2",PSSKZ1)) Q:'PSSKZ1!(PSSKZOUT)  D
 ..S PSSKZ2=$G(^PSDRUG(PSSKZIEN,"DOS2",PSSKZ1,0))
 ..I $P(PSSKZ2,"^")="" Q
 ..I $P(PSSKZ2,"^",5),$P(PSSKZ2,"^",6)'="",PSSKZTPE="O" Q
 ..S PSSKZ3=1
 ..I ($Y+5)>IOSL D HD Q:PSSKZOUT
 ..W !?6,$P(PSSKZ2,"^")
 ..I ($Y+5)>IOSL D HD Q:PSSKZOUT
 ..K PSSKZLD5,PSSKZLD6,PSSKZLD7
 ..S PSSKZLD5=$P(PSSKZ2,"^",5),PSSKZLD6=$P(PSSKZ2,"^",6)
 ..S PSSKZLD7=$S($E(PSSKZLD6,1)=".":"0"_PSSKZLD6,1:PSSKZLD6)
 ..W !?6,"Numeric Dose: "_PSSKZLD7,?46,"Dose Unit: "_$S($G(PSSKZLD5):$P($G(^PS(51.24,+PSSKZLD5,0)),"^"),1:""),?92,"Package: "_$P(PSSKZ2,"^",2)
 ..I ($Y+5)>IOSL D HD Q:PSSKZOUT
 .Q:PSSKZOUT
 .I 'PSSKZ3 W "(None)"
 .I ($Y+5)>IOSL D HD Q:PSSKZOUT
 .K PSSKZNN1,PSSKZNN2
 .I 'PSSKZND1!('PSSKZND3) Q
 .S PSSKZNN1=$$PROD0^PSNAPIS(PSSKZND1,PSSKZND3)
 .S PSSKZNN2=$S($E($P(PSSKZNN1,"^",3),1)=".":"0"_$P(PSSKZNN1,"^",3),1:$P(PSSKZNN1,"^",3))
 .I PSSKZSTR'="",PSSKZNN2'="",PSSKZNN2'=PSSKZSTR W !?3,"Note: Strength of "_PSSKZSTR_" does not match NDF strength of "_PSSKZNN2_"."
 .I ($Y+5)>IOSL D HD Q:PSSKZOUT
 .W !?3,"VA PRODUCT MATCH: "_$P(PSSKZNN1,"^")
 .I ($Y+5)>IOSL D HD Q:PSSKZOUT
 ;
END ;
 I '$G(PSSKZOUT),PSSKZTPE="O",'$G(PSSKZNOF) W !!,"No local possible dosage missing data found.",!
 I PSSKZDEV="P" W !!,"End of Report.",!
 I '$G(PSSKZOUT),PSSKZDEV="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I PSSKZDEV="C" W !
 E  W @IOF
 K PSSKZTPE
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
 ;
HD ;Report Header
 I PSSKZDEV="C",PSSKZCT'=1 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR I 'Y S PSSKZOUT=1 Q
 W @IOF
 I PSSKZTPE="A" W !,"Local Possible Dosages Report (All)"
 I PSSKZTPE="O" W !,"Local Possible Dosages Report (Missing Data Only)"
 W ?118,"PAGE: "_PSSKZCT,!,PSSKZLIN,! S PSSKZCT=PSSKZCT+1
 Q
 ;
 ;
MESS ;
 W !!,"Nothing queued to print.",!
 Q
 ;
 ;
TEST() ;Test to see if Drug meets criteria
 ;No need to have Local Possible Dose check here, you have it right after calling this at top
 I 'PSSKZND3!('PSSKZND1) Q 0
 I $P($G(^PSDRUG(PSSKZIEN,"I")),"^"),$P($G(^PSDRUG(PSSKZIEN,"I")),"^")<DT Q 0
 N PSSKZDOV
 S PSSKZDOV=""
 I PSSKZND1,PSSKZND3,$T(OVRIDE^PSNAPIS)]"" S PSSKZDOV=$$OVRIDE^PSNAPIS(PSSKZND1,PSSKZND3)
 I $P(PSSKZZR,"^",3)["S"!($E($P(PSSKZZR,"^",2),1,2)="XA") Q 0
 K PSSKZDF
 I PSSKZND1,PSSKZND3 S PSSKZNDF=$$DFSU^PSNAPIS(PSSKZND1,PSSKZND3) S PSSKZDF=$P(PSSKZNDF,"^")
 I $G(PSSKZDF)'>0,$P($G(^PSDRUG(PSSKZIEN,2)),"^") S PSSKZDF=$P($G(^PS(50.7,+$P($G(^PSDRUG(PSSKZIEN,2)),"^"),0)),"^",2)
 I PSSKZDOV=""!('$G(PSSKZDF))!($P($G(^PS(50.606,+$G(PSSKZDF),1)),"^")="") Q 1
 I $P($G(^PS(50.606,+$G(PSSKZDF),1)),"^"),'PSSKZDOV Q 0
 I '$P($G(^PS(50.606,+$G(PSSKZDF),1)),"^"),PSSKZDOV Q 0
 Q 1
