SROWRQ ;B'HAM ISC/MAM - REQUESTS BY WARD ; 07/08/88  08:11
 ;;3.0; Surgery ;**37**;24 Jun 93
BEG R !!,"Do you wish to print the requests for all wards ?  NO// ",SRALL:DTIME G:'$T!(SRALL="^") END I SRALL["?" D HELP G BEG
 S SRALL=$E(SRALL) S:SRALL="" SRALL="N" I "YyNn"'[SRALL D HELP G BEG
 I "Yy"'[SRALL W ! S DIC=42,DIC(0)="QEAMZ",DIC("A")="Print Requests for which ward ?  " D ^DIC G:Y<1 END S SRWARD=$P(Y(0),"^")
 S:'$D(SRWARD) SRWARD=""
DEVICE W ! K %ZIS,IOP,POP,IO("Q") S %ZIS="Q",%ZIS("A")="Print Requests on which Device: " D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="REQUESTS BY WARD",ZTSAVE("SRWARD")=SRWARD,ZTRTN="SROWRQ1" D ^%ZTLOAD G END
 G ^SROWRQ1
HELP W !!,"Answer 'YES' if you want to print the requests for all wards, or RETURN",!,"if you want a specific ward."
 Q
END D ^SRSKILL K SRTN W @IOF
 Q
HDR I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRQ=1 Q
 W:$Y @IOF W !,?28,"Requests for Operations",! F LINE=1:1:80 W "="
 W !,?33,"Ward: "_SRWARD,! F I=1:1:80 W "="
 Q
CON ; print concurrent case
 K SROPS,MM,MMM S SROPER=$P(^SRF(SRSCC,"OP"),"^") S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,"    Procedure: ",?15,SROPS(1) I $D(SROPS(2)) W !,?15,SROPS(2) I $D(SROPS(3)) W !,?15,SROPS(3) I $D(SROPS(4)) W !,?15,SROPS(4)
 W !!,"Comments:" S COMMENT=0 F  S COMMENT=$O(^SRF(SRSCC,5,COMMENT)) Q:'COMMENT  W !," "_^SRF(SRSCC,5,COMMENT,0)
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
