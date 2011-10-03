PSOPOLY ;BHAM ISC/SAB - patients with a minimum amount of rx's within a # of days ;10/06/93
 ;;7.0;OUTPATIENT PHARMACY;**19,28,132,326**;DEC 1997;Build 11
 ;External reference ^PS(55 supported by DBIA# 2228
 ;External reference ^PSDRUG( supported by DBIA# 221
 ;External reference ^DPT( supported by DBIA# 10035
 ;External reference ^PS(50.606 supported by DBIA 2174
 ;External reference ^PS(50.7 supported by DBIA 2223
 K ^TMP($J),DIR S PG=0
 S DIR("A")="Number Of Days To Begin Search",DIR("?")="^D HLP^PSOPOLY",DIR(0)="N^1:730:0",DIR("B")=180 D ^DIR G:$D(DIRUT) END S DAYS=Y K DIR
 S DIR("A")="Minimum Number Of Rxs and Active Non-VA Meds",DIR("B")=7,DIR("?")="^D HLP1^PSOPOLY",DIR(0)="N^1:100:0" D ^DIR G:$D(DIRUT) END S RX=Y K DIR
PAT W !! S DIC("A")="Enter Patient's Name or ^ALL for All Patients: "
 S DIC(0)="QEM" D EN^PSOPATLK S Y=PSOPTLK G:$E(Y,1,2)="^A"!($E(Y,1,2)="^a") ALL G:"^"[$E(Y) END S (PSODFN,DFN)=+Y
 D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN) S ALL=0 D DEV G:$G(QP)!($D(ZTSK)) END
ENQ D CON,PID^VADPT S DFN=PSODFN I '$O(^PS(55,DFN,"P","A",PSDATE)),'$O(^PS(55,DFN,"NVA",0)) G NRX
BEG S RXS=0 S:$G(PSDATEX) PSDATE=PSDATEX
 F  S PSDATE=$O(^PS(55,DFN,"P","A",PSDATE)) Q:'PSDATE  S (P,J)=0 F  S J=$O(^PS(55,DFN,"P","A",PSDATE,J)) Q:'J  D:$D(^PSRX(J,0))
 .I 134'[$E(+$P($G(^PSRX(J,"STA")),"^")),$P($G(^PSDRUG($P($G(^PSRX(J,0)),"^",6),0)),"^",3)'["S" S RXS=RXS+1,RX(DFN,J)=+$P($G(^PSRX(J,"STA")),"^")
 N NVA F NVA=0:0 S NVA=$O(^PS(55,DFN,"NVA",NVA)) Q:'NVA  I '$P(^PS(55,DFN,"NVA",NVA,0),"^",7) S RXS=RXS+1
 I RXS'<RX F  S P=$O(RX(DFN,P)) Q:'P  S RX0=$S($D(^PSRX(P,0)):^(0),1:""),RX2=$S($D(^(2)):^(2),1:""),RX3=$S($D(^(3)):^(3),1:"") D
 .S STA=RX(DFN,P),DRUG=$S($D(^PSDRUG($P(RX0,"^",6),0)):$P(^PSDRUG($P(RX0,"^",6),0),"^"),1:"UNKNOWN"),CLASS=$S($P($G(^PSDRUG($P(RX0,"^",6),0)),"^",2)]"":$P(^(0),"^",2),1:"UNKNOWN")
A .S STAT="A^N^R^H^N^S^^^^^^E^DC^^DC^DE^H^P^",STATUS=$P(STAT,"^",STA+1)
 .S FILLDATE=9999999-$P(^PSRX(P,2),"^",2)
 .S ^TMP($J,$P(^DPT(DFN,0),"^"),CLASS,DRUG,FILLDATE,P)=$P(^PSRX(P,0),"^",2)_"^"_RXS_"^"_$P(RX3,"^")_"^"_$P(RX0,"^",4)_"^"_STATUS_"^"_VA("BID")_"^"_DFN
 I RXS'<RX,$O(^TMP($J,$P(^DPT(DFN,0),"^"),""))="" S CLASS="NVA",^TMP($J,$P(^DPT(DFN,0),"^"),CLASS)=DFN_"^"_RXS
 S RXS=0 K RX(DFN),CLASS
 I 'ALL,'$D(^TMP($J)) G NRX
 I 'ALL D PRI G:$G(PSOTRUE) END D NVA G END
 Q
 ;
PRI S PG=0 D HDR S (DFN,ZDFN)="" D
 .F  S DFN=$O(^TMP($J,DFN)) Q:DFN=""  S (ZCLASS,CLASS)="" D  I ALL,$G(CLASS)="" D:'$G(PSOTRUE) NVA K PSOTRUE W ! F I=1:1:132 W "-"
 ..F  S CLASS=$O(^TMP($J,DFN,CLASS)) Q:CLASS=""  D
 ...I CLASS="NVA" S PSODFN=$P(^TMP($J,DFN,"NVA"),"^"),PSOTRUE=1 D NVA Q
 ...S DRUG="" F  S DRUG=$O(^TMP($J,DFN,CLASS,DRUG)) Q:DRUG=""  S FILLDATE="" F  S FILLDATE=$O(^TMP($J,DFN,CLASS,DRUG,FILLDATE)) Q:'FILLDATE  D
 ....F RNX=0:0 S RNX=$O(^TMP($J,DFN,CLASS,DRUG,FILLDATE,RNX)) Q:'RNX  S POLY=^(RNX),PSODFN=$P(POLY,"^",7) D
 .....I ($Y+5)>IOSL D HDR
 .....W ! W:ZDFN'=DFN !,DFN_" ("_$P(POLY,"^",6)_")" W:ZDFN'=DFN ?65,$J($P(POLY,"^",2),3),! W:ZCLASS'=CLASS ?2,$E(CLASS,1,16)
 .....W ?22,DRUG,?65,$P(POLY,"^",5) S Y=$P(POLY,"^",3) W ?77 D DT^DIQ S PROV=$P($G(^VA(200,$P(POLY,"^",4),0)),"^") W ?92,$E(PROV,1,25),?121,$P(^PSRX(RNX,0),"^") S ZCLASS=CLASS,ZDFN=DFN
 .....S TOTRX=$G(TOTRX)+1 S:'$D(^TMP($J,"PAT",DFN)) TOTP=$G(TOTP)+1,^TMP($J,"PAT",DFN)=""
 I ALL U IO W !!,"Total Number of Patients: "_TOTP,?40,"Total Number of Rxs: "_TOTRX,?80,"Average Rxs per Patient: "_(TOTRX\TOTP)
 Q
END W ! D ^%ZISC K QP,^TMP($J),DIR,DTOUT,DUOUT,DIRUT,DIROUT,%DT,ALL,CLASS,DAYS,DFN,DIC,DRUG,EDT,FILLDATE,PSDATEX,G,I,J,P,PSDATE,RX,RXS,RX0,RX2,RX3,SDT,X,Y,POLY,PROV,POP,RNX,Z0,Z1,Z2,ZCLASS,PG,ZDFN,ZTSK,STA,STAT,STATUS D KVA^VADPT
 K PSODFN,PAT,TOTRX,TOTP S:$D(ZTQUEUED) ZTREQ="@"
 Q
ALL ;print all patients
 W ! S ALL=1,(TOTRX,TOTP)=0 D DEV G:$G(QP)!($D(ZTSK)) END
ALLP D CON
 F DFN=0:0 S DFN=$O(^PS(55,DFN)) Q:'DFN  S ALL=1 D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN) D PID^VADPT,BEG
 I '$D(^TMP($J)) G NRX
 D PRI,END
 Q
CON ;convert data to date
 S %DT="",X="T-"_DAYS D ^%DT S SDT=Y,(PSDATE,PSDATEX)=SDT-1,X="T" D ^%DT S EDT=Y,RXS=0
 Q
NRX ;prints no rx message
 D HDR U IO W:'ALL !,$P(^DPT(DFN,0),"^")_" ("_VA("BID")_")" W !?20,">>>> No Active Prescriptions and/or Non-VA Meds found within the Range <<<<" W @IOF G END
 Q
HLP ;help module
 W !!,$C(7),"Enter numeric value greater than zero.",!,"The value must a whole number, no decimals or fractions.",!!
 Q
HLP1 W !!,$C(7),"Enter a numeric value greater than zero.",!,"The number seven (7) is the default, no decimals or fractions.",!,"The count will include both Active Prescriptions and Non-VA Medications.",!!
 Q
DEV K %ZIS,IOP,ZTSK S %ZIS("B")="",PSOION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S QP=1,IOP=PSOION D ^%ZIS K IOP,PSOION Q
 I $G(IOM)<132 W $C(7),!!,"Printout Must be 132 Columns.",!! G DEV
 K PSOION I $D(IO("Q")) D  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is queued to print !",!
 .S ZTDESC="Poly Pharmacy Report",ZTRTN=$S('ALL:"ENQ^PSOPOLY",1:"ALLP^PSOPOLY") F G="ALL","RX","DAYS","DFN","PG","PSODFN" S:$D(@G) ZTSAVE(G)=""
 Q
HDR ;report header
 S PG=PG+1 U IO W @IOF,?55,"Poly Pharmacy Report",!?50,$E(SDT,4,5)_"-"_$E(SDT,6,7)_"-"_($E(SDT,1,3)+1700)_"    to    "_$E(EDT,4,5)_"-"_$E(EDT,6,7)_"-"_($E(EDT,1,3)+1700)
 W !?37," for "_DAYS_" Days for "_RX_" or More Active Prescriptions and/or Non-VA Meds"
 W ?122,"Page "_PG,!,"Patient",?40,"ID#",?62,"Active Rx's",!,?2,"Class",?22,"Drug",?65,"Status",?77,"Last Filled",?92,"Provider",?121,"Rx Number"
 W ! F I=1:1:132 W "-"
 Q
NVA ;displays non-va meds
 Q:'$O(^PS(55,PSODFN,"NVA",0))  N TITLE
 S PSOSTA=">>>Non-VA MEDS (Not dispensed by VA)<<<"
 S STR=($L(PSOSTA)+IOM/2)-$L(PSOSTA),STP=IOM-(STR+$L(PSOSTA)) F I=1:1:STR S TITLE=$G(TITLE)_" "
 S TITLE=TITLE_PSOSTA F I=1:1:STP S TITLE=TITLE_" "
 D:($Y+7)>IOSL HDR W !!,TITLE
 I $G(CLASS)="NVA" W !,DFN_" ("_VA("BID")_")",?40,"Total Non-VA Meds: "_$P(^TMP($J,DFN,CLASS),"^",2)
 F NVAO=0:0 S NVAO=$O(^PS(55,PSODFN,"NVA",NVAO)) Q:'NVAO  D
 .Q:$P(^PS(55,PSODFN,"NVA",NVAO,0),"^",7)  Q:'$P(^PS(55,PSODFN,"NVA",NVAO,0),"^")
 .S DUPRX0=^PS(55,PSODFN,"NVA",NVAO,0)
 .I ($Y+7)>IOSL D HDR W !!,TITLE,!,$P(^DPT(PSODFN,0),"^")_" ("_VA("BID")_")"
 .S DOI=$S($P(DUPRX0,"^",2):$P(^PSDRUG($P(DUPRX0,"^",2),0),"^"),1:$P(^PS(50.7,$P(DUPRX0,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^"))
 .W !?2,DOI_" "_$P(DUPRX0,"^",3)
 .W !?5,"Schedule: "_$P(DUPRX0,"^",5)
 .W !?5,"Start Date: "_$$FMTE^XLFDT($P(DUPRX0,"^",9)),?45," Documented: "_$$FMTE^XLFDT($P(DUPRX0,"^",10)) ;_"  Status: Active"
 K DUPRX0,NVA,STP,STR,PSOSTA,TITLE,DOI
 Q
