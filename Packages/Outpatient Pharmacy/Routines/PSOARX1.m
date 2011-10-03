PSOARX1 ;BHAM ISC/SAB prints archive index only ; 01/20/95
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 W ! K ^TMP($J) I '$O(^PSOARC(0)) D  G:'OUT EX G HDR
 .D ^PSOARCCO I '$O(^PSOARC(0)) W !,$C(7),"There is no data to print!" S OUT=0 Q
 .S OUT=1
 I $O(^PSOARC(0)) S OUT=1 D  G:'$G(OUT)!($D(DIRUT)) EX
 .K DIR S DIR(0)="Y" S DIR("B")="NO",DIR("A",1)="There is data in the Pharmacy Archive file."
 .S DIR("A")="Do you want to re-compile this data" D ^DIR Q:$D(DIRUT)!('Y)  D ^PSOARCCO
 .I '$O(^PSOARC(0)) W !,$C(7),"There is no data to print!" S OUT=0 Q
HDR W ! K DIR S DIR("A")="Printout Header Label",DIR(0)="F^1:64",DIR("?",1)="  ...Enter 1 to 64 characters.",DIR("?")="This Header will print at top of every page of your index."
 S DIR("B")="Prescription Archive Data Index" D ^DIR K DIR G:$D(DIRUT) EX S PSOACDS=X K X
 K %ZIS,IO("Q"),ZTSK,ZTQUEUED S PSOION=ION,%ZIS="QM" D ^%ZIS I POP S IOP=PSOION D ^%ZIS K %ZIS,PSOION G EX
 I $D(IO("Q")) S ZTRTN="EN^PSOARX1",ZTSAVE("PSOACDS")="" D ^%ZTLOAD W:$D(ZTSK) !,"Task queued to print",! K ZTSK G EX
EN K PSOQUIT S PSOAPG=1 D HD G:$G(PSQUIT) EX I '$O(^PSOARC(0)) U IO W !!,"**************There is no data to print****************",! G EX
 S ZI="" F  S ZI=$O(^PSOARC("B",ZI)) Q:ZI=""  S SSN=0 F PSOK=0:0 S SSN=$O(^PSOARC("B",ZI,SSN)) Q:SSN'>0  D  G:$G(PSQUIT) EX
 .S NM=ZI,ZII=0,SS=SSN,LL=$L(NM)+$L(SS)+6
 .K ^TMP($J,"ZRX") F KK=0:0 S ZII=$O(^PSOARC("B",ZI,SSN,ZII)) Q:+ZII'>0  S ^TMP($J,"ZRX",ZII)="",LL=LL+$L(ZII)+1
 .U IO D:($Y+4)>IOSL HD Q:$G(PSQUIT)
 .W !,NM_" ("_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_") - " S ZII=0
 .F KK=1:1 S ZII=$O(^TMP($J,"ZRX",ZII)) Q:+ZII'>0  W:($X+$L(ZII)+1)>(IOM-5) !?($L(NM)+3) D:($Y+2)>IOSL HD Q:$G(PSQUIT)  W $P(^PSRX(ZII,0),"^"),","
 ;print rx info
 S PSOP=IO,PSOACPF=IOF,PSOACPL=IOSL,PSOACPM=IOM,PSOATNM=1
 D HD Q:$G(PSQUIT)
 S ZI="" F  S ZI=$O(^PSOARC("B",ZI)) Q:ZI=""  S SSN=0 F PSOK=0:0 S SSN=$O(^PSOARC("B",ZI,SSN)) Q:SSN'>0  D  G:$G(PSQUIT) EX
 .F ZII=0:0 S ZII=$O(^PSOARC("B",ZI,SSN,ZII)) Q:'ZII  S (RX0,DA)=ZII U IO D:$Y+20>IOSL HD Q:$G(PSQUIT)  D ^PSOARX
EX D ^%ZISC K PSOPAG,PSOP,PSOACPF,PSOACPL,PSOACPM,PSOATNM,DIRUT,DUOUT,DTOUT,PG,PSOAC,PSOAC1,PSOACDS,PSOAPG,Y D:$D(ZTQUEUED) KILL^%ZTLOAD
 K POP,OUT,IO("Q"),%X,%Y,X,PSQUIT
 Q
HD I IOST["C-" K DIR S DIR("A")="Press Return to Continue",DIR(0)="E" D ^DIR S:$D(DIRUT) PSQUIT=1 K DIR,DIRUT,DUOUT Q:$G(PSQUIT)
 U IO W @IOF,!!?(IOM-$L(PSOACDS)\2),PSOACDS,?$X+10," Page: "_PSOAPG
 W !?(IOM-$L($E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3))\2),$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),! S PSOAPG=PSOAPG+1 Q
