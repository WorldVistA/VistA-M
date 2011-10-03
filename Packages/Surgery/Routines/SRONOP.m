SRONOP ;B;HAM ISC/MAM - NON-O.R. PROCEDURES ; [ 01/30/01  1:07 PM ]
 ;;3.0; Surgery ;**44,58,64,67,70,100**;24 Jun 93
 K SROEDIT S:$D(^XUSEC("SROEDIT",DUZ))&'$D(DUZ("SAV")) SROEDIT=1 S (SRNEWOP,SRSOUT)=0 W @IOF,!
 K DIC S DIC("A")="Select Patient: ",DIC=2,DIC(0)="QEAMZ" D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S DFN=+Y D DEM^VADPT S SRNM=VADM(1) D HDR
ADT S (SRBACK,SRDT,CNT)=0 F  S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!SRSOUT!SRNEWOP!$D(SRTN)!SRBACK  S SROP=0 F  S SROP=$O(^SRF("ADT",DFN,SRDT,SROP)) Q:'SROP!$D(SRTN)!SRSOUT!SRNEWOP!SRBACK  D LIST
 G:SRBACK ADT G:$D(SRTN) ASK G:SRNEWOP ^SRONOP1 G:SRSOUT END
 I $D(SROEDIT) S CNT=CNT+1,SRCASE(CNT)="" W !,CNT_".",?4,"NEW PROCEDURE"
SEL W !!,"Select Procedure: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I $D(SROEDIT),X="NEW"!(X="new")!(X=CNT) G ^SRONOP1
 I '$D(SRCASE(X)) W !!,"Enter the number corresponding to the procedure you want to edit." W:$D(SROEDIT) !,"Enter '"_CNT_"' or 'NEW' to create a new procedure" G SEL
 S SRTN=SRCASE(X)
ASK S SROP=SRTN,SRSDATE=$P(^SRF(SRTN,0),"^",9) I $E(SRSDATE,1,7)>DT D FUTURE G:SRSOUT END I '$D(SRTN) D HDR G ADT
 Q:'$D(SROEDIT)  D HDR W !,?1 D CASE W !!,"Do you want to edit or delete this procedure ? "
 W !!,"1. Edit",!,"2. Delete",!!,"Select Number:  1// " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 S:X="" X=1 I X<1!(X>2) W !!,"Enter '1' to edit information related to this procedure, or '2' to delete",!,"this procedure from your records.",!!,"Press RETURN to continue  " R X:DTIME G ASK
 I X=1 K SROEDIT Q
 D DEL^SRONOP1
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL K SROEDIT,SRTN W @IOF
 Q
EDIT ; edit procedure
 Q:'$D(SRTN)  I '$D(SRNM),$D(VADM(1)) S SRNM=VADM(1)
 I '$D(SRNM) S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRNM=VADM(1)
 D ^SROLOCK I SROLOCK S Q3("VIEW")=""
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK S Q3("VIEW")=""
 D RT K DR S SRDTIME=DTIME,DTIME=3600,SRSOUT=1,ST="NON-O.R. PROCEDURE"_$S(SROLOCK:" **LOCKED",1:""),DIE=130,DR="[SRNON-OR]",DA=SRTN D EN2^SROVAR,^SRCUSS S DTIME=SRDTIME I 'SROLOCK D ^SROPCE1
 S SROERR=SRTN D ^SROERR0
 I $G(SRLCK) D UNLOCK^SROUTL(SRTN)
 D ^SRSKILL
 Q
LIST ; list case
 Q:$P($G(^SRF(SROP,"NON")),"^")'="Y"
 I $Y+5>IOSL S SRBACK=0 D CONT Q:$D(SRTN)!SRSOUT!SRNEWOP  D HDR Q:SRBACK
 S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9) W !,CNT_". "
CASE S SROPER=$P(^SRF(SROP,"OP"),"^"),SRCASE(CNT)=SROP D LOCK
 K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S Y=SRSDATE D D^DIQ S SRSDATE=$P(Y,"@")_" "_$P(Y,"@",2)
 W SRSDATE,?20,SROPS(1) I $D(SROPS(2)) W !,?20,SROPS(2) I $D(SROPS(3)) W !,?20,SROPS(3) I $D(SROPS(4)) W !,?20,SROPS(4)
 W !
 Q
LOCK ; case locked?
 I $D(SRTN),$P($G(^SRF(SRTN,"LOCK")),"^") S SROPER=SROPER_" **LOCKED**"
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
RT ; start RT logging
 I $D(XRTL) S XRTN="SRONOP" D T0^%ZOSV
 Q
CONT W ! K DIR S DIR("A")="Select procedure or press RETURN to continue listing procedures: ",DIR(0)="FOA"
 S DIR("?",1)="Enter the number corresponding to the desired procedures"_$S($D(SROEDIT):", enter 'NEW' to",1:"")
 S DIR("?")=$S($D(SROEDIT):"create a new procedure, ",1:"")_"or press RETURN to continue listing procedures." D ^DIR Q:Y=""  I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I $D(SROEDIT),Y="NEW"!(Y="new") S SRNEWOP=1 Q
 I Y'?.N!'$D(SRCASE(+Y)) S SRBACK=1 D
 .W !!,"Enter the number corresponding to the procedure you want to edit.",!,"If the desired procedure does not appear, press RETURN to continue",!,"listing additional procedures"
 .W:$D(SROEDIT) ", or enter 'NEW' to create a new procedure" W ".",!
 I SRBACK K DIR S DIR("A")="  Press RETURN to continue. ",DIR("0")="FOA" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 I 'SRBACK S SRTN=+SRCASE(Y)
 Q
FUTURE  D HDR W !,?1 D CASE W !,$C(7) K DIR
 S DIR("A",1)=">>> The procedure you have selected has a future date.",DIR("A")="    Are you sure you have selected the correct procedure ? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I 'Y K SRTN
 Q
HDR ; print heading
 W @IOF,!,?1,VADM(1)_"   "_VA("PID") S X=$P($G(VADM(6)),"^") W:X "        * Died "_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" *" W !
 Q
