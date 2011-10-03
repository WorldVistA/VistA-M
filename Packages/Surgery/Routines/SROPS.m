SROPS ;B'HAM ISC/MAM - SELECT CASE ; [ 07/8/03  12:10 PM ]
 ;;3.0; Surgery ;**18,44,51,64,121**;24 Jun 93
 W ! S SRSOUT=0 K DIC S DIC("A")="Select Patient: ",DIC=2,DIC(0)="QEAM" D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S DFN=+Y D DEM^VADPT
STL D HDR I $D(DUZ("SAV")) K SRNEWOP
ADT S (SRDT,CNT,SRBACK)=0 F  S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!SRSOUT!$D(SRTN)!SRBACK  S SROP=0 F  S SROP=$O(^SRF("ADT",DFN,SRDT,SROP)) Q:'SROP!$D(SRTN)!SRSOUT!SRBACK  D LIST
 G:SRBACK ADT G:'$D(SRNEWOP)&SRSOUT END D:SRSOUT HDR I $D(SRTN) G FUTURE
 I '$D(SRNEWOP),'$D(SRCASE(1)) W !!,"There are no cases entered for "_VADM(1)_".",!!,"Press RETURN to continue  " R X:DTIME G END
 I $D(SRNEWOP) S CNT=CNT+1,SRCASE(CNT)="" W !,CNT,". ENTER NEW SURGICAL CASE"
OPT S SRSOUT=0 W !!!,"Select Operation: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRCASE(X)) W !!,"Enter the number of the desired operation" W $S('$D(SRNEWOP):".",1:", or '"_CNT_"' to enter a new case.") G OPT
 I $D(SRNEWOP),(X=CNT) D NEW^SROPER Q
 S SRTN=+SRCASE(X)
FUTURE ; is this a future case? if so, OK to proceed?
 Q:$D(PRCP("I"))  ; quit if called from Inventory
 S SROP=SRTN,SRSDATE=$P(^SRF(SRTN,0),"^",9) I $E(SRSDATE,1,7)'>DT Q
 D HDR W !,?1 D CASE W !,$C(7) K DIR
 S DIR("A",1)=">>> The case you have selected has a future date.",DIR("A")="    Are you sure you have selected the correct case ? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) G END
 I 'Y K SRTN D HDR G ADT
 Q
LIST ; list cases
 I '$D(SRNONOR),$P($G(^SRF(SROP,"NON")),"^")="Y" Q
 S SRSCAN=1 I $D(^SRF(SROP,.2)),$P(^(.2),"^",12)'="" K SRSCAN
 I $D(SRSCAN),$D(^SRF(SROP,30)),$P(^(30),"^") Q
 I $D(SRSCAN),$D(^SRF(SROP,31)),$P(^(31),"^",8) Q
 I $D(^SRF(SROP,37)),$P(^(37),"^") Q
 I $Y+5>IOSL S SRBACK=0 D SEL^SROPER Q:$D(SRTN)!(SRSOUT)  D HDR Q:SRBACK
 S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9) W !,CNT_". "
CASE W $E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)
 S SROPER=$P(^SRF(SROP,"OP"),"^") I $O(^SRF(SROP,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SROP,13,SROTHER)) Q:'SROTHER  D OTHER
 D ^SROP1,LOCK K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W ?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3) W:$D(SROPS(4)) !,?14,SROPS(4)
 W ! S SRCASE(CNT)=SROP_"^"_SRDT
 Q
LOCK ; case locked?
 I $D(SRTN),$P($G(^SRF(SRTN,"LOCK")),"^") S SROPER=SROPER_" **LOCKED**"
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SROP,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SROP,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LOOP ; break procedure
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
END K SRTN D ^SRSKILL W @IOF
 Q
HDR ; print heading
 W @IOF,!,?1,VADM(1)_"   "_VA("PID") S X=$P($G(VADM(6)),"^") W:X "        * DIED "_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" *" W !
 Q
