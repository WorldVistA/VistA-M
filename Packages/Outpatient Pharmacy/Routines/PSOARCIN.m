PSOARCIN ;BHAM ISC/LGH,SAB - tape index search ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
PQ S XNEW=0,PSOATNM=1 S %ZIS("A")="Tape Drive Device: ",%ZIS("B")="" W !! D ^%ZIS K %ZIS("A") G END:POP S PSOAT=IO I IOST'["MAGTAPE" D ^%ZISC U IO(0) W !,"Must select a MAGTAPE device",!! G PQ
 U IO(0) W !! S %ZIS("A")="Output Device: " D ^%ZIS K %ZIS("A") S PSOAP=IO G END:POP S PSOACPM=IOM,PSOACPF=IOF,PSOACPL=IOSL W !!
 I '$D(%MT("REW")) X ^%ZOSF("MAGTAPE")
R2 S DIR("A")="Do you want to print the tape index",DIR("T")=DTIME,DIR(0)="YO" D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT) END G:'Y RN
 F  U PSOAT R X:DTIME U PSOAP W !,X Q:X="!"
 U PSOAT W @%MT("REW") U IO(0)
RN W !! S DIR("A")="Enter Patient's Name ",DIR("?")="^D QNM^PSOARCIN",DIR("T")=DTIME,DIR(0)="FO" D ^DIR K DIR G:$G(DIRUT) END S DIC=2,DIC(0)="EZM" D ^DIC K DIC S NM=$S(Y=-1:"",1:$P(Y,"^",2)),TZ=1,SS=$S(Y=-1:"",1:$P(Y(0),"^",9))
 I Y=-1 S:X?1A.E NM=X S:X?9N SS=X
R U PSOAT R X:DTIME X ^%ZOSF("EOT") G:Y END G:(X="")!(X="!") NOT ;G:X'["&" R S:$P(X,"^",2)="NEW" XNEW=1
 I X="&^NEW" S XNEW=1 G R5
 I X="&" S XNEW=0 G R5
 S XNM=$P($P(X,"^"),"%",1),XSS=$P($P(X,"^"),"%",2) G R5:((NM="")&(SS'=XSS))!((NM'=XNM)&(SS=""))!((SS'="")&(SS'=XSS)) S ^TMP($J,"ZRX",TZ)=X,TZ=TZ+1 G R1
R5 U PSOAT R X:DTIME X ^%ZOSF("EOT") G:Y END G:(X="")!(X="!") NOT S XNM=$P($P(X,"^"),"%",1),XSS=$P($P(X,"^"),"%",2) G R5:((NM="")&(SS'=XSS))!((NM'=XNM)&(SS=""))!((SS'="")&(SS'=XSS)) S ^TMP($J,"ZRX",TZ)=X,TZ=TZ+1
R1 R X:DTIME G:'$T END G P:(X="")!(X="!")!($E(X,1)?1A) S ^TMP($J,"ZRX",TZ)=X,TZ=TZ+1 G R1
P S TZ=TZ-1
 U PSOAP W @PSOACPF,!,"The following scripts were archived on this tape for : ",!!
 W !,$P(^TMP($J,"ZRX",1),"%",1)," (",$P($P(^(1),"^"),"%",2),") - " S NM=$P(^TMP($J,"ZRX",1),"%",1),SS=$P($P(^(1),"^"),"%",2) F I=1:1:TZ W:I'=1 !?($L(NM)+2) W $P(^TMP($J,"ZRX",I),"^",2)
 S PSOAPG=1,PSOACDS="Rx Retrieval for "_NM G:XNEW=0 ^PSOARCRR G:XNEW=1 ^PSOARCR1
 Q
NOT U IO(0) W !!,NM_" does not have archived scripts on this tape."
END I $D(PSOAT) U IO(0) S IOP=PSOAT D ^%ZIS D ^%ZISC K IOP
 I $D(PSOAP) U IO(0) S IOP=PSOAP D ^%ZIS D ^%ZISC K IOP
 K ^TMP($J,"ZRX"),TZ,NMPSOAT,PSOAP,PSOACPM,PSOACPF,PSOACPL,XNEW,PSOAPF,TEST,%MT,DIRUT,I,NM,POP,PSOACDS,PSOAPG,PSOAT,SS,X,XNM,XSS,Y
 Q
QNM W !!,"Enter the name or Social Security Number of the patient whose archived",!,"prescriptions you wish to retrieve. Social Security Number must be in the",!,"form : ######### (NO DASHES)!!"
 Q
