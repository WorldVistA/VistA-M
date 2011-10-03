SROPSN ;B'HAM ISC/MAM - SELECT CASE ; [ 06/19/03  3:22 PM ]
 ;;3.0; Surgery ;**121**;24 Jun 93
 N SROPZ S SROPZ=SROP D HDR I $D(DUZ("SAV")) K SRNEWOP
 ;;;I $D(SRCASE(1)) S SRTN=+SRCASE(1) Q
ADT W ! S (SRDT,CNT)=0 F  S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!SRSOUT!$D(SRTN)  S SROP=0 F  S SROP=$O(^SRF("ADT",DFN,SRDT,SROP)) Q:'SROP!$D(SRTN)!SRSOUT  I SROPZ=SROP D LIST
 G:'$D(SRNEWOP)&SRSOUT END D:SRSOUT HDR I $D(SRTN) G FUTURE
 I '$D(SRNEWOP),'$D(SRCASE(1)) D  W !!,"Press RETURN to continue  " R X:DTIME G END
 .W !!,$S($P($G(^SRF(SROPZ,"NON")),"^")="Y":"Case #"_SROPZ_" is not an O.R. surgical procedure.",1:"Case #"_SROPZ_" is not marked for exclusion from assessment.")
 S SRTN=+SRCASE(1)
 Q
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
 S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9) W !
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
