SROALNO ;B'HAM ISC/MAM - SELECT CASE WITHOUT ASSESS ; 2 MAR 1992  3:35 pm
 ;;3.0; Surgery ;**104**;24 Jun 93
 W ! S (SRDT,CNT)=0 F I=0:0 S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!(SRSOUT)  S SROP=0 F I=0:0 S SROP=$O(^SRF("ADT",DFN,SRDT,SROP)) Q:'SROP!($D(SRTN))!(SRSOUT)  D LIST
 I $D(SRTN) Q
OPT W !!!,"Select Operation: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRCASE(X)) W !!,"Enter the number corresponding to the surgical case for which you will be",!,"creating a surgical risk assessment." G OPT
 I X=CNT G ^SRONEW
 S SRTN=+SRCASE(X)
ENTER ; edit or delete
 W @IOF,!,?1,VADM(1)_"  "_VA("PID"),!!,?1 S SROP=SRTN,SRSDATE=$P(^SRF(SRTN,0),"^",9) D CASE
 W !!,"1. Enter Information",!,"2. Review Information",!,"3. Delete Surgery Case",!!,"Select Number:  1//  " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 S:X="" X=1 I X<1!(X>3)!(X'?.N) D HELP G ENTER
 I X=3 D ^SROPDEL G END
 I X=2 D RT K DR S ST="REVIEW" D EN2^SROVAR S Q3("VIEW")="",DR="[SROMEN-OPER]",DA=SRTN,DIE=130 D ^SRCUSS K Q3("VIEW") G END
 Q
LIST ; list cases
 I $P($G(^SRF(SROP,"NON")),"^")="Y" Q
 S SRSCAN=1 I $D(^SRF(SROP,.2)),$P(^(.2),"^",12)'="" K SRSCAN
 I $D(SRSCAN),$D(^SRF(SROP,30)),$P(^(30),"^") Q
 I $D(SRSCAN),$D(^SRF(SROP,31)),$P(^(31),"^",8) Q
 I $D(^SRF(SROP,37)),$P(^(37),"^") Q
 I $Y+5>IOSL S SRBACK=0 D SEL^SROPER Q:$D(SRTN)!(SRSOUT)  D:'SRBACK HDR I SRBACK S CNT=0,SROP=SRCASE(1)-1,SRDT=$P(SRCASE(1),"^",2) W @IOF,!,?1,VADM(1)_"   "_VA("PID"),! Q
 S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9)
 W !,CNT_". "
CASE W $E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)
 S SROPER=$P(^SRF(SROP,"OP"),"^") I $O(^SRF(SROP,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SROP,13,SROTHER)) Q:'SROTHER  D OTHER
 D ^SROP1 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W ?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3) W:$D(SROPS(4)) !,?14,SROPS(4)
 W ! S SRCASE(CNT)=SROP_"^"_SRDT
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SROP,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SROP,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
END K SRTN D ^SRSKILL W @IOF
 Q
HELP W !!,"Enter RETURN or '1' to enter or edit information contained within one of the",!,"options found under the Operations Menu.  If you want to display a two screen",!,"overview of this case, enter '2'."
 W "  To delete this case from your records,",!,"enter '3'.  Please note that deleting a case will remove EVERYTHING pertaining",!,"to this operative procedure.",!
 W !!,"Press RETURN to continue  " R X:DTIME
 Q
RT ; start RT logging
 I $D(XRTL) S XRTN="SROP" D T0^%ZOSV
 Q
HDR ; print heading
 W @IOF,!,?1,VADM(1)_"   "_VA("PID")
 Q
