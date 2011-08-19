PSOARCF1 ;BHAM ISC/LGH,SAB,LC - hfs file index search ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
PQ S XNEW=0,PSOATNM=1 S %ZIS("A")="Host File Server Device: ",%ZIS("B")="",%ZIS("HFSMODE")="R"
 W !! D ^%ZIS K %ZIS("A") G END:POP S (PSOAT,PSOAIO)=IO,PSOAIOT=IOT,PSOAPAR=IOPAR
 I IOT'="HFS" D ^%ZISC U IO(0) W !,"Must select a HFS device",!! G PQ
 U IO(0) W !! S %ZIS("A")="Output Device: " D ^%ZIS K %ZIS("A") S PSOAP=IO G END:POP S PSOACPM=IOM,PSOACPF=IOF,PSOACPL=IOSL W !!
 S PSORWND=$$REWIND^%ZIS(PSOAT,PSOAIOT,PSOAPAR) G END:$G(PSORWND)=0
R2 S DIR("A")="Do you want to print the file index",DIR("T")=DTIME,DIR(0)="YO" D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT) END G:'Y RN
 F  U PSOAT R X:DTIME U PSOAP W !,X Q:X="!"
RWD U PSOAT S PSORWND=$$REWIND^%ZIS(PSOAT,PSOAIOT,PSOAPAR) U IO(0)
RN W !! S DIR("A")="Enter Patient Name ",DIR("?")="^D QNM^PSOARCF1",DIR("T")=DTIME,DIR(0)="FO" D ^DIR K DIR G:$G(DIRUT) END S DIC=2,DIC(0)="EZM" D ^DIC K DIC S NM=$S(Y=-1:"",1:$P(Y,"^",2)),TZ=1,SS=$S(Y=-1:"",1:$P(Y(0),"^",9))
 I Y=-1 S:X?1A.E NM=X S:X?9N SS=X
R U PSOAT R X:DTIME G:$$STATUS^%ZISH END D:(X="")!(X="!") NOT
 I X="&^NEW" S XNEW=1 G R5
 I X="&" S XNEW=0 G R5
 S XNM=$P($P(X,"^"),"%",1),XSS=$P($P(X,"^"),"%",2) G R5:((NM="")&(SS'=XSS))!((NM'=XNM)&(SS=""))!((SS'="")&(SS'=XSS)) S ^TMP($J,"ZRX",TZ)=X,TZ=TZ+1 G R1
R5 U PSOAT R X:DTIME S Y=$$STATUS^%ZISH G:Y END G:(X="")!(X="!") NOT S XNM=$P($P(X,"^"),"%",1),XSS=$P($P(X,"^"),"%",2) G R5:((NM="")&(SS'=XSS))!((NM'=XNM)&(SS=""))!((SS'="")&(SS'=XSS)) S ^TMP($J,"ZRX",TZ)=X,TZ=TZ+1
R1 R X:DTIME G:'$T END G P:(X="")!(X="!")!($E(X,1)?1A) S ^TMP($J,"ZRX",TZ)=X,TZ=TZ+1 G R1
P S TZ=TZ-1
 U PSOAP W @PSOACPF,!,"THE FOLLOWING SCRIPTS WERE ARCHIVED FOR : ",!!
 W !,$P(^TMP($J,"ZRX",1),"%",1)," (",$P($P(^(1),"^"),"%",2),") - " S NM=$P(^TMP($J,"ZRX",1),"%",1),SS=$P($P(^(1),"^"),"%",2) F I=1:1:TZ W:I'=1 !?($L(NM)+2) W $P(^TMP($J,"ZRX",I),"^",2)
 S PSOAPG=1,PSOACDS="RX RETRIEVAL FOR "_NM D:XNEW=0 ^PSOARCF3 D:XNEW=1 ^PSOARCF2 G RWD
 Q
NOT U IO(0) W !!,NM," does not have any archived scripts." K NM,X,Y,TZ,SS G RWD
END I $D(PSOAT) U IO(0) S IOP=PSOAT D ^%ZIS D ^%ZISC K IOP
 I $D(PSOAP) U IO(0) S IOP=PSOAP D ^%ZIS D ^%ZISC K IOP
 K ^TMP($J,"ZRX"),TZ,NMPSOAT,PSOAP,PSOACPM,PSOACPF,PSOACPL,XNEW,PSOAPF,TEST,%MT,DIRUT,I,NM,POP,PSOACDS,PSOAPG,PSOAT,SS,X,XNM,XSS,Y
 K PSOAIO,PSOAIOT,PSOAPAR,PSORWND
 Q
QNM W !!,"Enter the Name or Social Security Number of the patient whose archived",!,"prescriptions you wish to retrieve. Social Security Number must be in the",!,"form : ######### (NO DASHES)!!"
 Q
