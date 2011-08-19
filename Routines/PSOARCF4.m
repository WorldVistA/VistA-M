PSOARCF4 ;BIR/SAB/LGH/LC-ARCHIVING SAVE OPTION ;07/07/92
 ;;7.0;OUTPATIENT PHARMACY;**27,130,268**;DEC 1997;Build 9
 ;External reference to ^DPT("SSN" supported by DBIA 10035
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
AC L +^PSOARC:$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !!!,$C(7),"Archiving is currently in progress on another terminal!...",!!! Q
 G:'+$P($G(^PSOARC(0)),"^",4) EX S PSOACRS="",PG=1,PSOAPG=1,PSOION=ION
 W !!! S DIR("A")=$P(^PSOARC(0),"^",4)_" Rx'S will be archived. Ok to continue Y/N",DIR(0)="YO",DIR("B")="NO" D ^DIR K DIR G EX1:$G(DIRUT),EX1:'Y
EN01 S DIR("A",1)="",DIR("A")="Do you want a hardcopy of your archived prescriptions",DIR("B")="NO",DIR(0)="YO" D ^DIR K DIR G:$D(DIRUT) EX1 G:'Y TDV
PDV S STOP=0 K PSOAP,PSOACPF,PSOACPL,PSOACPM,PSOATNM
 K IOP,POP,%ZIS S %ZIS("A")="Printer Device: ",%ZIS="M" D ^%ZIS I POP S IOP=PSOION D ^%ZIS K PSOION G EX1
 D:$E(IOST)'["P" PDVQ G:STOP END1 S PSOAP=IO,PSOACPF=IOF,PSOACPL=IOSL,PSOACPM=IOM,PSOATNM=1
PDV1 I $D(PSOAP) D  G:$D(DUOUT) END1 G:$D(DTOUT) EX1
 .K DIR S DIR("A")="PRINTOUT HEADER LABEL: ",DIR(0)="FO^1:64",DIR("?",1)="  ...Enter 1 to 64 characters.",DIR("?")="These characters will appear at top of every page of your printout." D ^DIR K DIR S PSOACDS=$G(X) K X
TDV W !! K %ZIS S %ZIS("A")="Host File Server Device: ",%ZIS("B")="",%ZIS("HFSMODE")="RW" D ^%ZIS K %ZIS("A")
 I POP S IOP=PSOION D ^%ZIS K IOP,%ZIS,POP G EX1
 I IOT'="HFS" D ^%ZISC W !,"Must select a HFS device" G TDV
 S PSOAT=IO,PSOABS=IOBS,PSOAF=IOF,PSOAM=IOM,PSOAIO=IO,PSOAIOT=IOT,PSOAPAR=IOPAR,PSOATNM=1
RST ;Invoked from ^PSOARCCO
 W !!,"Recording information" D:$D(PSOAP) HD D:$D(PSOAT) HDT S ZI="" F  S ZI=$O(^PSOARC("B",ZI)) Q:ZI=""  S SSN=0 F PSOK=0:0 S SSN=$O(^PSOARC("B",ZI,SSN)) Q:SSN'>0  D GAT
FILE1 S ZI=0 F J=0:0 S ZI=$O(^PSOARC("B",ZI)) Q:ZI=""  S SSN=0 F PSOK=0:0 S SSN=$O(^PSOARC("B",$G(ZI),SSN)) Q:+SSN'>0  D ARC
 W "!"
 K DA,DFN,I,I1,LMI,PSOABS,PSOAEOT,PSOK,RX0,TA,VAR1,XAR1,XTYPE
 G ^PSOARCF5
 Q
END1 S DIR("A")="Do you wish to continue? Y/N",DIR(0)="YO" D ^DIR K DIR G:$D(DIRUT)!('Y) EXIT^PSOARCCO S STOP=0 G EN01
PDVQ S DIR("A",1)="Are you sure you want to print archived information",DIR("A")="to the device that you are currently on (...this device)",DIR(0)="YO" D ^DIR K DIR S:'Y!($D(DIRUT)) STOP=1 Q
ARC S DA=$O(^DPT("SSN",SSN,0)) Q:+DA'>0  D:$D(PSOAT) ^PSOARCTG D:$D(PSOAT) TAPE1^PSOARCF5 S ZII=0 F JJ=0:0 S ZII=$O(^PSOARC("B",ZI,SSN,ZII)) Q:ZII'>""  D RX,ARCRX
 Q
RX Q:'($D(^PSRX(+ZII,0))#2)  S (RX0,DA)=ZII U IO(0) W "." I $D(PSOAP) U PSOAP D:$Y>(PSOACPL-20) HD1 D ^PSOARX
 I $D(PSOAT) D ^PSOARCCV,TAPE^PSOARCF6
 Q
ARCRX ;Mark Rx as archived in 52 by setting field 36
 N DA,DR,DIE
 S (DA,PSOARCRX,PSOARCDA)=RX0,DR="36////1",DIE="^PSRX(" D PSOL^PSSLOCK(PSOARCRX) S DA=PSOARCDA K PSOARCDA I '$G(PSOMSG) W !!,$C(7),$S($P($G(PSOMSG),"^",2)'="":$P(PSOMSG,"^",2),1:"Entry is being edited by another user!"),! K PSOARCRX,PSOMSG Q
 D ^DIE K DIE D PSOUL^PSSLOCK(PSOARCRX) K PSOMSG,PSOARCRX
 Q
 ;
GAT S NM=ZI,ZII=0,SS=SSN,LL=$L(NM)+$L(SS)+6
 K ^TMP($J,"ZRX") F KK=0:0 S ZII=$O(^PSOARC("B",ZI,SSN,ZII)) Q:+ZII'>0  S ^TMP($J,"ZRX",ZII)="",LL=LL+$L(ZII)+1
 I $D(PSOAP) D
 .U PSOAP D:($Y+(LL\132))>PSOACPL HD W !,NM_" ("_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_") - " S ZII=0
 .F KK=1:1 S ZII=$O(^TMP($J,"ZRX",ZII)) Q:+ZII'>0  W:($X+$L(ZII)+1)>(PSOACPM-5) !?($L(NM)+3) W $P(^PSRX(ZII,0),"^"),","
 D:$D(PSOAT) TAP0 Q
HD U PSOAP W @PSOACPF,!!?58,"ARCHIVING INDEX",?120,"PAGE ",PG,!,?62,$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),!! S PG=PG+1
 Q
HD1 ;Invoked from ^PSOARCF3,PSOARCF2
 W @PSOACPF,?(66-($L(PSOACDS)\2)),PSOACDS,?112,$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),?122,"PAGE ",PSOAPG S PSOAPG=PSOAPG+1 W !
 Q
HDT U PSOAT W "&^NEW",! Q
DEVICE W !!,?10,"Device not available, try again later"
 D ^%ZISC G EXIT^PSOARCCO
 Q
TAP0 ; PRINTS INDEX TO FILE
 U PSOAT S VAR1=NM_"%"_SS_"^",ZII=0 F KK=1:1 S ZII=$O(^TMP($J,"ZRX",ZII)) Q:+ZII'>0  D TAP1
 I $L(VAR1)>0 U PSOAT W VAR1,!
 S XAR1="" Q
TAP1 ;PRINT "NAME-RX LIST"
 I ($L(VAR1)+$L($P(^PSRX(ZII,0),"^"))+1)<255 S VAR1=VAR1_$P(^PSRX(ZII,0),"^")_"," Q
 U PSOAT W VAR1,! S VAR1="^"_$P(^PSRX(ZII,0),"^")_"," Q
EX W !!,"THE ",$P(^PSOARC(0),"^",1)," File is empty. Archiving will not be done."
EX1 K PSOACRS,PSOAPG,PG,%MT,DA,DFN,DIR,DIRUT,DTOUT,DUOUT,I,I1,J,JJ,KK,LL,LMI,NM,PG,PSOABS,PSOACDS,PSOACPF,PSOACPL,PSOACPM,PSOACRS,PSOACEOT,PSOAF
 K PSOAM,PSOAP,PSOAPAR,PSOAT,PSOAIO,PSOAIOT,PSOATNM,PSOION,PSOK,RX0,SS,SSN,STOP,TA,VAR1,X,XAR1,XTYPE,Y,ZI,ZII D KVA^VADPT
 L -^PSOARC
 Q
