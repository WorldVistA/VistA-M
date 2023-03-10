SRSCHD1 ;B'HAM ISC/MAM - SCHEDULE REQUESTED OPERATIONS (CONT);[JAN 31,2001@7:52]
 ;;3.0;Surgery;**37,100,201**;24 Jun 93;Build 5
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
 ;Modified for SR*3.0*201: call ALRDY and local LOCK/UNLOCK procedures
 K NOWAY D ALRDY I $D(NOWAY) G END
 I $$LOCK(SRTN) D ^SRSCHD2,UNLOCK(SRTN)
 G REQ
END ;
 K SRTN D ^SRSKILL W @IOF
 Q
LOOP ; break procedure if greater than 75 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<75  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
ALRDY ;Is the operation already scheduled?
 N S31,SST,SET ;Node 31, sceduled start time, scheduled end time
 I $D(^SRF(SRTN,31)) S S31=^(31),SST=$P(S31,U,4),SET=$P(S31,U,5) I SST,SET S NOWAY=1
 I $D(NOWAY) W !!,"This case is already scheduled.",!!,"Press RETURN to continue  " R X:DTIME
 Q
LOCK(SRCASE) ;
 N D0,SRCONCC,SRLCK,SRNOW,SRNOW1,SRTAG,SRUSER,SRX
 S SRNOW=$$NOW^XLFDT,SRNOW1=$$FMADD^XLFDT(SRNOW,,2)
 S SRLCK=1,SRTAG="",SRCONCC=$P($G(^SRF(SRCASE,"CON")),"^")
 I $$SIGNED^SROESUTL(SRCASE)!$G(SRESIG) D SINED Q SRLCK
 L +^XTMP("SRLOCK-"_SRCASE):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 E  D E1 S SRLCK=0 Q SRLCK
 I SRCONCC D
 .L +^XTMP("SRLOCK-"_SRCONCC):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 .E  D  S SRLCK=0
 ..D E2 L -^XTMP("SRLOCK-"_SRCASE)
 D:SRLCK XTMP
 Q SRLCK
E1 S SRUSER="Another person",SRX=$O(^XTMP("SRLOCK-"_SRCASE,0))
 I SRX S SRUSER=$P($G(^VA(200,SRX,0)),"^")
 D EN^DDIOL(SRUSER_" is editing this case. Please try later.","","!,$C(7)") H 2
 Q
E2 S SRUSER="Another person",SRX=$O(^XTMP("SRLOCK-"_SRCONCC,0))
 I SRX S SRUSER=$P($G(^VA(200,SRX,0)),"^")
 D EN^DDIOL(SRUSER_" is editing the concurrent case. Please try later.","","!,$C(7)") H 2
 Q
SINED L +^XTMP("SRLOCK-"_SRCASE):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 E  D E1 S SRLCK=0 Q
 I SRCONCC D  Q:'SRLCK
 .L +^XTMP("SRLOCK-"_SRCONCC):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 .E  D  S SRLCK=0
 ..D E2 L -^XTMP("SRLOCK-"_SRCASE)
 S SRTAG="-Master"
XTMP S ^XTMP("SRLOCK-"_SRCASE,0)=SRNOW1_"^"_SRNOW_"^Surgery Case Lock"_SRTAG_"^"_$J,^XTMP("SRLOCK-"_SRCASE,DUZ,$J)=""
 I SRCONCC S ^XTMP("SRLOCK-"_SRCONCC,0)=SRNOW1_"^"_SRNOW_"^Surgery Case Lock"_SRTAG_"^"_$J,^XTMP("SRLOCK-"_SRCONCC,DUZ,$J)=""
 Q
UNLOCK(SRCASE) ; apply decremental lock
 N SRCC,SRCONCC S SRCONCC=$P($G(^SRF(SRCASE,"CON")),"^")
 L -^XTMP("SRLOCK-"_SRCASE) K ^XTMP("SRLOCK-"_SRCASE,DUZ,$J)
 I '$O(^XTMP("SRLOCK-"_SRCASE,0))!(($G(^XTMP("SRLOCK-"_SRCASE,0))["-Master")&($P($G(^XTMP("SRLOCK-"_SRCASE,0)),"^",4)=$J)) K ^XTMP("SRLOCK-"_SRCASE)
 I SRCONCC D
 .L -^XTMP("SRLOCK-"_SRCONCC) K ^XTMP("SRLOCK-"_SRCONCC,DUZ,$J)
 .I '$O(^XTMP("SRLOCK-"_SRCONCC,0))!(($G(^XTMP("SRLOCK-"_SRCONCC,0))["-Master")&($P($G(^XTMP("SRLOCK-"_SRCONCC,0)),"^",4)=$J)) K ^XTMP("SRLOCK-"_SRCONCC)
 Q
