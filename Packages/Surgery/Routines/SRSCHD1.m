SRSCHD1 ;B'HAM ISC/MAM - SCHEDULE REQUESTED OPERATIONS (CONT) ; [ 01/31/01  7:52 AM ]
 ;;3.0; Surgery ;**37,100**;24 Jun 93
REQ ; select request
 K SRCASE,SRTN W ! S SRSCHED=1 D ASK^SRSUPRQ G:'$D(SRTN) END
 I $D(^DPT(SRDFN,.35)),$P(^(.35),"^")'="" S Y=$E($P(^(.35),"^"),1,7) D D^DIQ W !!,"The records show that "_SRNM_" died on "_Y_".",!!,"Press RETURN to continue  " R X:DTIME G END
UN S DFN=SRDFN,SRSOP=$P(^SRF(SRTN,"OP"),"^")
 S SRSDOC=$P($G(^SRF(SRTN,.1)),"^",4)
 S SROPER=SRSOP K SROPS,MM,MMM S:$L(SROPER)<75 SROPS(1)=SROPER I $L(SROPER)>74 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !!!,"Case Information: ",!,SROPS(1) I $D(SROPS(2)) W !,SROPS(2) I $D(SROPS(3)) W !,SROPS(3)
 W !,"By " S USER=$S(SRSDOC:$P(^VA(200,SRSDOC,0),"^"),1:"NOT ENTERED") W USER D DEM^VADPT W ?40,"On "_VADM(1),!,"Case # "_SRTN
 S HOURS=$P($G(^SRF(SRTN,.4)),"^") I HOURS W ?40,"For "_HOURS_" Hours"
 S Z=$P(^SRF(SRTN,0),"^",10) I Z'="" S SRSTYP=$S(Z="EL":"ELECTIVE",Z="EM":"EMERGENCY",Z="A":"ADD ON TODAY (NONEMERGENT)",Z="S":"STANDBY",Z="U":"URGENT ADD ON TODAY",1:"")
 W !,$S($D(SRSTYP):SRSTYP,1:""),?40,$P(^SRF(SRTN,0),"^",11)
 W !!,"Comments:" S COMMENT=0 F  S COMMENT=$O(^SRF(SRTN,5,COMMENT)) Q:'COMMENT  W !,^SRF(SRTN,5,COMMENT,0)
 I $D(^SRF(SRTN,"CON")),$P(^("CON"),"^") S SRCON=$P(^("CON"),"^") W !!,"  * Concurrent Case # "_SRCON_"  "_$P(^SRF(SRCON,"OP"),"^")
SEL W !!,"Is this the correct operation ?  YES//  " R SRYN:DTIME S:'$T SRYN="^" G:SRYN["^" END S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "NnYn"'[SRYN W !!,"Enter 'NO' if you have selected the wrong request, or RETURN to continue",!,"scheduling this request. ",! G SEL
 I "Yy"'[SRYN G END
 K NOWAY D ^SRSCHK I $D(NOWAY) G END
 I $$LOCK^SROUTL(SRTN) D ^SRSCHD2,UNLOCK^SROUTL(SRTN)
 G REQ
END ;
 K SRTN D ^SRSKILL W @IOF
 Q
LOOP ; break procedure if greater than 75 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<75  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
